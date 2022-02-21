//
//  Constants.swift
//  Wotrack
//
//  Created by Роман Предеин on 17.02.2022.
//

import Foundation

struct K {
    
    struct Brand {
        static let logoTitle = "WoTrack"
    }
    
    struct Color {
        static let accentColor = "accentColor"
        static let backgroundColor = "backgroundColor"
        static let cardBackgroundColor = "cardBackgroundColor"
        static let textColor = "textColor"
        static let lightTextColor = "lightTextColor"
    }
    
    struct CoreData {
        static let persistentContainerName = "Wotrack"
        static let parentEntityName = "Exercise"
        static let basicSortingKey = "order"
        static let fallbackSortingKey = "timestamp"
    }
    
    struct Tools {
        static let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "E, dd MMM yyyy"
            return formatter
        }()
    }
    
    struct Icons {
        struct Default {
            static let defaultIconSet = [
                "squat",
                "pullups",
                "pushups",
                "situps",
            ]
            static let icon = "default"
            static let iconTitle = "exercise icons"
            static let iconUrl = "https://www.flaticon.com/free-icons/exercise"
            static let iconText = "Exercise icons created by ultimatearm - Flaticon"
        }
        struct Squat {
            static let icon = "squat"
            static let iconTitle = "squat icons"
            static let iconUrl = "https://www.flaticon.com/free-icons/squat"
            static let iconText = "Squat icons created by ultimatearm - Flaticon"
        }
        struct PullUps {
            static let icon = "pullups"
            static let iconTitle = "pull up icons"
            static let iconUrl = "https://www.flaticon.com/free-icons/pull-up"
            static let iconText = "Pull up icons created by ultimatearm - Flaticon"
        }
        struct PushUps {
            static let icon = "pushups"
            static let iconTitle = "workout icons"
            static let iconUrl = "https://www.flaticon.com/free-icons/workout"
            static let iconText = "Workout icons created by ultimatearm - Flaticon"
        }
        struct SitUps {
            static let icon = "situps"
            static let iconTitle = "sit up icons"
            static let iconUrl = "https://www.flaticon.com/free-icons/sit-up"
            static let iconText = "Sit up icons created by ultimatearm - Flaticon"
        }
    }
}
