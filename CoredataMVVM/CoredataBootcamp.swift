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
      } else {
        print("Successfully loaded core data!")
      }
    }
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
  }
}

struct CoredataBootcamp: View {
  
  @StateObject var vm = CoreDataViewModel()
  
  var body: some View {
    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
  }
}

struct CoredataBootcamp_Previews: PreviewProvider {
  static var previews: some View {
    CoredataBootcamp()
  }
}
