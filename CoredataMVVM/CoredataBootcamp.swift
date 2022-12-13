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
  
  init() {
    container = NSPersistentContainer(name: "")
    container.loadPersistentStores { description, error in
      if let error = error {
        print("Error loading core data: \(error)")
      }
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
