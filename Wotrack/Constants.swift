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
    
    static let persistentContainerName = "Wotrack"
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy"
        return formatter
    }()
}
