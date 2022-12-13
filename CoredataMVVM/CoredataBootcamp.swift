//
//  CoredataBootcamp.swift
//  CoredataMVVM
//
//  Created by Kaori Persson on 2022-12-13.
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject {
  
  let container: NSPersistentContainer
  @Published var savedEntities: [FruitEntity] = []
  
  init() {
    // Set up the container, name should be the same as container file
    container = NSPersistentContainer(name: "FruitsContainer")
    container.loadPersistentStores { description, error in
      
      // If the error occurs, print it
      if let error = error {
        print("Error loading core data: \(error)")
      }
    }
    fetchFruits()
  } // END: init
  
  func fetchFruits() {
    // NSFetchRequest needs to know the generic type
    let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
    
    do {
      // fetch() throws error, so wrap with do and catch the error. Put try in front.
      savedEntities = try container.viewContext.fetch(request)
    } catch let error {
      print("Error fetching: \(error)")
    }
  } // END: fetchFruits
  
  func addFruit(text: String) {
    let newFruit = FruitEntity(context: container.viewContext)
    newFruit.name = text
    saveData()
  } // END: addFruit
  
  func updateFruit(entity: FruitEntity) {
    let currentName = entity.name ?? ""
    let newName = currentName + "!"
    entity.name = newName
    saveData()
  }
  
  func deleteFruit(indexSet: IndexSet) {
    // take out the index from the indexSet, it's optional type needs to be unwrapped
    guard let index = indexSet.first else { return }
    let entity = savedEntities[index]
    container.viewContext.delete(entity)
    saveData()
  } // END: deleteFruit
  
  func saveData() {
    do {
      try container.viewContext.save()
      // to refresh the view, we need to republish @Published var savedEntities.
      // For that, call fetchFruits after the saving.
      fetchFruits()
    } catch let error {
      print("Error saving: \(error)")
    }
  } // END: saveData
}

struct CoredataBootcamp: View {
  
  @StateObject var vm = CoreDataViewModel()
  @State var textFieldText: String = ""
  
  var body: some View {
    NavigationView {
      VStack(spacing: 20) {
        TextField("Add fruit here...", text: $textFieldText)
          .font(.headline)
          .padding(.leading)
          .frame(height: 55)
          .background(.gray)
          .cornerRadius(10)
        
        Button {
          guard !textFieldText.isEmpty else { return }
          vm.addFruit(text: textFieldText)
          textFieldText = ""
        } label: {
          Text("Save")
            .font(.headline)
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(.pink)
            .cornerRadius(10)
        }

        List {
          ForEach(vm.savedEntities) { entity in
            Text(entity.name ?? "NO NAME")
              .onTapGesture {
                // TapGesture in foreach list will pass 'entity: FruitEntity'
                vm.updateFruit(entity: entity)
              }
          }
          // You can ommit indexSet in the parametor, indexSet will be passed automatically
          .onDelete(perform: vm.deleteFruit)
        }
        .listStyle(PlainListStyle())
      }
      .padding(.horizontal)
      .navigationTitle("Fruits")
    }
  }
}

struct CoredataBootcamp_Previews: PreviewProvider {
  static var previews: some View {
    CoredataBootcamp()
  }
}
