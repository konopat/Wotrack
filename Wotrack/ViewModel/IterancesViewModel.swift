//
//  IterancesViewModel.swift
//  Wotrack
//
//  Created by Роман Предеин on 25.02.2022.
//

import Foundation
import CoreData

class IterancesViewModel: ObservableObject {
    
    typealias EntityModel = Iterance
    private let persistenceController = PersistenceController.shared
    @Published var items: [EntityModel] = []

    
    // MARK: - Add data
    func addNewItem(number: Int, to exercise: Exercise) {
            
            // Initializing the creation of a new entity
            let newItem = EntityModel(context: persistenceController.container.viewContext)
            
            // Then assign values to all properties
            newItem.id = UUID()
            newItem.timestamp = Date()
            newItem.number = Int16(number)
            newItem.parentExercise = exercise
            
            // And start saving
            saveData(for: exercise)
        }
    
    // MARK: - Remove data
    func deleteItems(by offsets: IndexSet, in exercise: Exercise) {
            // The IndexSet contains all passed items
            // Most of the time it's just one item, but theoretically, we can work with bulk items.
            
            // Select all matches and start the removal cycle
            offsets.map { items[$0] }.forEach(persistenceController.container.viewContext.delete)
            
            // And start saving certainly
            saveData(for: exercise)
        }
    
    // MARK: - Saving data
    func saveData(for exercise: Exercise) {
            
            // Only if changes are detected
            if persistenceController.container.viewContext.hasChanges {
                do {
                    // Try to save all data in the currrent container
                    try persistenceController.container.viewContext.save()
                    
                    // And load it again to update the published variable to reflect this change
                    loadData(from: exercise)
                } catch let error {
                    // If it doesn't work
                    print("Error: \(error)")
                }
            }
        }
    
    // MARK: - Loading data
    func loadData(from exercise: Exercise) {
            
            let currentExercise = exercise
        
            let predicate = NSPredicate(format: "parentExercise.title MATCHES %@", currentExercise.title!)
        
            // Request objects that match our model
            let request = NSFetchRequest<EntityModel>(entityName: K.CoreData.parentEntityName)
            request.predicate = predicate
        
            // SORT RULES:
            // Priority or basic sort mean sort by a special attribute in CoreData Item.
            // That allow us to save changes in order by user.
            let sort = NSSortDescriptor(key: K.CoreData.fallbackSortingKey, ascending: false)
            
            // Applying sorting
            request.sortDescriptors = [sort]
            
            do {
                // Try to load the result into the monitored array
                try items = persistenceController.container.viewContext.fetch(request)
            } catch {
                // If it doesn't work
                print("Error getting data. \(error.localizedDescription)")
            }
        }

}
