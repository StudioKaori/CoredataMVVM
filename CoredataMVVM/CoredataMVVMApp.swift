//
//  CoredataMVVMApp.swift
//  CoredataMVVM
//
//  Created by Kaori Persson on 2022-12-13.
//

import SwiftUI

@main
struct CoredataMVVMApp: App {
    //let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            CoredataBootcamp()
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
