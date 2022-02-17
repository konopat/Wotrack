//
//  Persistence.swift
//  Wotrack
//
//  Created by Роман Предеин on 17.02.2022.
//

import CoreData

struct PersistenceController {

    let container = NSPersistentCloudKitContainer(name: K.persistentContainerName)

    init(inMemory: Bool = false) {
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
