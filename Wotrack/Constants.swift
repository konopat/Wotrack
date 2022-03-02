//
//  Constants.swift
//  Wotrack
//
//  Created by Роман Предеин on 17.02.2022.
//

import Foundation
import SwiftUI

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
    
    struct Grid {
        static let columns = [GridItem(), GridItem()]
        static let spacing: CGFloat = 10
    }
    
    struct CoreData {
        static let persistentContainerName = "Wotrack"
        static let parentEntityName = "Exercise"
        static let childeEntityName = "Iterance"
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
        struct Autors {
            struct FlatIconWorkoutSet {
                static let iconSetUrl = "https://www.flaticon.com/authors/ultimatearm"
                static let iconSetText = "Icons made by Ultimatearm from www.flaticon.com"
            }
        }
        struct Default {
            static let defaultIconSet = [
                "squat",
                "pullups",
                "pushups",
                "situps",
                "arrow",
                "berpie",
                "boxing",
                "chestRolling",
                "dumbbell-1",
                "dumbbell",
                "exerciseBike",
                "highСhair",
                "jumping-rope",
                "jumps",
                "kettlebell",
                "kneeToChest",
                "legArmUp",
                "lowJumps",
                "lunges",
                "plank-boy",
                "plank",
                "runner",
                "scissorJumps",
                "trainingTV",
                "triangularis",
                "video",
                "workout-11",
                "workout-12",
                "workout-14",
                "workout-15",
                "workout-16",
                "workout-17",
                "yogaBall",
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
