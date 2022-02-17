//
//  WotrackApp.swift
//  Wotrack
//
//  Created by Роман Предеин on 17.02.2022.
//

import SwiftUI

@main
struct WotrackApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
