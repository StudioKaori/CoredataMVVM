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
    // Set up the container
    container = NSPersistentContainer(name: "")
    
    container.loadPersistentStores { description, error in
      
      // If the error occurs, print it
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
