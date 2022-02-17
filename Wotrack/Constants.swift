//
//  Constants.swift
//  Wotrack
//
//  Created by Роман Предеин on 17.02.2022.
//

import Foundation

struct K {
    
    struct Color {
        static let backgroundColor = "backgroundColor"
        static let lightTextColor = "lightTextColor"
    }
    
    struct CoreData {
        static let persistentContainerName = "Wotrack"
        static let parentEntityName = "Exercise"
        static let basicSortingKey = "order"
        static let fallbackSortingKey = "timestamp"
        
        static let defaultItems = [
            "Squats",
            "Push-ups",
            "Pull-ups",
            "Sit-ups",
        ]
    }
    
    struct Tools {
        static let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "E, dd MMM yyyy"
            return formatter
        }()
    }
}
