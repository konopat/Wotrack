//
//  ExercisesViewModel.swift
//  Wotrack
//
//  Created by Роман Предеин on 17.02.2022.
//

import SwiftUI
import CoreData

class ExercisesViewModel: ObservableObject {
    
    typealias EntityModel = Exercise
    private let persistenceController = PersistenceController()
    @Published var items: [EntityModel] = []
    
//    private let defaults = UserDefaults.standard
//    private var isFirstRun: Bool
    
//    // DOESNT WORK
//    func loadDefaultData() {
//        isFirstRun = true
//        defaults.set(isFirstRun, forKey: "isFirstRun")
//    }
//    init() {
//        // Default data
//        for defaultItem in K.CoreData.defaultItems {
//            let newItem = EntityModel(context: persistenceController.container.viewContext)
//            newItem.title = defaultItem
//            newItem.id = UUID()
//            newItem.order = 0
//            newItem.timestamp = Date()
//
//            items.append(newItem)
//        }
//    }
    
    // MARK: - Add data
        func addNewItem(with title: String) {
            
            // Initializing the creation of a new entity
            let newItem = EntityModel(context: persistenceController.container.viewContext)
            
            // Then assign values to all properties
            newItem.id = UUID()
            newItem.title = title
            newItem.timestamp = Date()
            newItem.order = 0 // By default is zero unless an user wants to change the sort.
            
            // And start saving
            saveData()
        }
    
    // MARK: - Remove data
        func deleteItems(by offsets: IndexSet) {
            // The IndexSet contains all passed items
            // Most of the time it's just one item, but theoretically, we can work with bulk items.
            
            // Select all matches and start the removal cycle
            offsets.map { items[$0] }.forEach(persistenceController.container.viewContext.delete)
            
            // And start saving certainly
            saveData()
        }
    
    // MARK: - Saving data
        func saveData() {
            
            // Only if changes are detected
            if persistenceController.container.viewContext.hasChanges {
                do {
                    // Try to save all data in the currrent container
                    try persistenceController.container.viewContext.save()
                    
                    // And load it again to update the published variable to reflect this change
                    loadData()
                } catch let error {
                    // If it doesn't work
                    print("Error: \(error)")
                }
            }
        }
    
    // MARK: - Loading data
        func loadData() {
            
            // Request objects that match our model
            let request = NSFetchRequest<EntityModel>(entityName: K.CoreData.parentEntityName)
            
            // SORT RULES:
            // Priority or basic sort mean sort by a special attribute in CoreData Item.
            // That allow us to save changes in order by user.
            let sort = NSSortDescriptor(key: K.CoreData.basicSortingKey, ascending: true)
            let fallbackSort = NSSortDescriptor(key: K.CoreData.fallbackSortingKey, ascending: false)
            
            // Applying sorting
            request.sortDescriptors = [sort, fallbackSort]
            
            do {
                // Try to load the result into the monitored array
                try items = persistenceController.container.viewContext.fetch(request)
            } catch {
                // If it doesn't work
                print("Error getting data. \(error.localizedDescription)")
            }
        }
    
    // MARK: - Reorder data items
        func move(from source: IndexSet, to destination: Int) {
            // Just like in deleteItems func we have the IndexSet contains all passed items.
            // And destination with number of row in the List.
             
            // Change the order of the items in the array is really simple
            items.move(fromOffsets: source, toOffset: destination )

            // Then, to save the new order in CoreData we can by update a special attribute for all of Items
            // We simply take the number of all entries (remember that the first element is numbered zero, so we subtract one from the total) and assign the value in order, subtracting one each time until we reach position zero.
            for reverseIndex in stride( from: items.count - 1, through: 0, by: -1 ) {
                items[ reverseIndex ].order = Int16( reverseIndex )
            }
            saveData()
        }
    
    
}
