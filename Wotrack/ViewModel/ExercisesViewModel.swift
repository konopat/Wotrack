//
//  ExercisesViewModel.swift
//  Wotrack
//
//  Created by Роман Предеин on 17.02.2022.
//

import SwiftUI
import CoreData

class ExercisesViewModel: ObservableObject {
    
    typealias ExerciseEntity = Exercise
    typealias IteranceEntity = Iterance
    
    private let persistenceController = PersistenceController.shared
    
    @Published var exercisesArray: [ExerciseEntity] = []
    @Published var iterancesArray: [IteranceEntity] = []
    
    init() {
        loadData()
    }
    
    // MARK: - Universal functions
    
    func loadData(by exercise: Exercise? = nil) {
        loadExercises()
        if let currentExercise = exercise {
            loadIterances(by: currentExercise)
        }
    }
    
    func saveData(by exercise: Exercise? = nil) {
        // Only if changes are detected
        if persistenceController.container.viewContext.hasChanges {
            do {
                // Try to save all data in the currrent container
                try persistenceController.container.viewContext.save()
                
                // And load it again to update the published variable to reflect this change
                loadData()
                if let currentExercise = exercise {
                    loadIterances(by: currentExercise)
                }
            } catch let error {
                // If it doesn't work
                print("Error: \(error)")
            }
        }
    }
    
    // MARK: - Exercises functions
    func addNewExercise(with title: String, and icon: String) {
        
        // Initializing the creation of a new entity
        let newItem = ExerciseEntity(context: persistenceController.container.viewContext)
        
        // Then assign values to all properties
        newItem.id = UUID()
        newItem.title = title
        newItem.icon = icon
        newItem.timestamp = Date()
        newItem.order = 0 // By default is zero unless an user wants to change the sort.
        
        
        // And start saving
        saveData()
    }

    func deleteExercise(by offsets: IndexSet) {
        // The IndexSet contains all passed items
        // Most of the time it's just one item, but theoretically, we can work with bulk items.
        
        // Select all matches and start the removal cycle
        offsets.map { exercisesArray[$0] }.forEach(persistenceController.container.viewContext.delete)
        
        // And start saving certainly
        saveData()
    }

    func loadExercises() {
        
        // Request objects that match our model
        let request = NSFetchRequest<ExerciseEntity>(entityName: K.CoreData.parentEntityName)
        
        // SORT RULES:
        // Priority or basic sort mean sort by a special attribute in CoreData Item.
        // That allow us to save changes in order by user.
        let sort = NSSortDescriptor(key: K.CoreData.basicSortingKey, ascending: true)
        let fallbackSort = NSSortDescriptor(key: K.CoreData.fallbackSortingKey, ascending: false)
        
        // Applying sorting
        request.sortDescriptors = [sort, fallbackSort]
        
        do {
            // Try to load the result into the monitored array
            try exercisesArray = persistenceController.container.viewContext.fetch(request)
        } catch {
            // If it doesn't work
            print("Error getting data. \(error.localizedDescription)")
        }
    }

    func moveExercise(from: IndexSet, to: Int) {
        exercisesArray.move(fromOffsets: from, toOffset: to)
        for reverseIndex in stride( from: exercisesArray.count - 1, through: 0, by: -1 ) {
            exercisesArray[ reverseIndex ].order = Int16( reverseIndex )
        }
        saveData()
    }
    
    // MARK: - Iterances functions
    
    func addNewIterance(number: Int, to exercise: Exercise) {
            
        // Initializing the creation of a new entity
        let newItem = IteranceEntity(context: persistenceController.container.viewContext)
        
        // Then assign values to all properties
        newItem.id = UUID()
        newItem.timestamp = Date()
        newItem.number = Int16(number)
        
        if let exerciseIndex = exercisesArray.firstIndex(where: { $0.id == exercise.id  }) {
            newItem.parentExercise = exercisesArray[exerciseIndex]
        }
        
        // And start saving
        saveData(by: exercise)
    }
    
    func loadIterances(by exercise: Exercise) {
        
        if let currentExerciseIndex = exercisesArray.firstIndex(where: { $0.id == exercise.id }) {
            
            // Request objects that match our model
            let request = NSFetchRequest<IteranceEntity>(entityName: K.CoreData.childeEntityName)
            
            let currentExercise = exercisesArray[currentExerciseIndex]
            request.predicate = NSPredicate(format: "%K == %@", "parentExercise.id" , currentExercise.id! as CVarArg)
            
            // SORT RULES:
            // Priority or basic sort mean sort by a special attribute in CoreData Item.
            // That allow us to save changes in order by user.
            let sort = NSSortDescriptor(key: K.CoreData.fallbackSortingKey, ascending: false)
            
            // Applying sorting
            request.sortDescriptors = [sort]
            
            do {
                // Try to load the result into the monitored array
                try iterancesArray = persistenceController.container.viewContext.fetch(request)
            } catch {
                // If it doesn't work
                print("Error getting data. \(error.localizedDescription)")
            }
        }

    }
    
    func deleteIterance(by offsets: IndexSet) {
        // The IndexSet contains all passed items
        // Most of the time it's just one item, but theoretically, we can work with bulk items.
        
        // Select all matches and start the removal cycle
        offsets.map { iterancesArray[$0] }.forEach(persistenceController.container.viewContext.delete)
        
        // And start saving certainly
        saveData()
    }
    
}

public extension NSManagedObject {

    convenience init(context: NSManagedObjectContext) {
        let name = String(describing: type(of: self))
        let entity = NSEntityDescription.entity(forEntityName: name, in: context)!
        self.init(entity: entity, insertInto: context)
    }

}
