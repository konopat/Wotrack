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
    
    struct Card {
        static let shape = RoundedRectangle(cornerRadius: 10)
        static let spacing: CGFloat = 5
        static let spacingCaption: CGFloat = 2
        static let aspectRatio: CGFloat = 4/5
        static let iconRatio: CGFloat = 4
        static let iconWidth: CGFloat = 60
        static let iconHeight: CGFloat = 60
        
        struct inGallery {
            struct Frame {
                static let width: CGFloat = 100
                static let height: CGFloat = 100
            }
            struct Icon {
                struct Frame {
                    static let width: CGFloat = 80
                    static let height: CGFloat = 80
                }
            }
        }
        struct Selected {
            struct Frame {
                static let width: CGFloat = 150
                static let height: CGFloat = 150
            }
            struct Icon {
                struct Frame {
                    static let width: CGFloat = 100
                    static let height: CGFloat = 100
                }
            }
        }
    }
    
    struct Button {
        static let shape = RoundedRectangle(cornerRadius: 0)
        static let height: CGFloat = 50
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
        struct SystemSet {
            static let plus = "plus"
            static let trash = "trash"
        }
        struct Default {
            static let authorURL = "https://www.flaticon.com/authors/ultimatearm"
            static let authorCitation = "Icons made by Ultimatearm from www.flaticon.com"
            static let icon = "default"
            static let iconSet = [
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
        }
    }
    
    struct Text {
        static let toDay = [
            "Eng": "Today",
            "Ru": "Сегодня",
        ]
        static let total = [
            "Eng": "Total",
            "Ru": "Всего",
        ]
        static let chooseAnIcon = [
            "Eng": "Choose an icon",
            "Ru": "Выберите иконку",
        ]
        static let nameTheExercise = [
            "Eng": "Name the exercise",
            "Ru": "Название упражнения",
        ]
        static let newExercise = [
            "Eng": "New exercise",
            "Ru": "Новое упражнение",
        ]
        static let confirm = [
            "Eng": "Confirm",
            "Ru": "Подтвердить",
        ]
        static let newIterance = [
            "Eng": "New iterance",
            "Ru": "Новое повторение",
        ]
        static let add = [
            "Eng": "Add",
            "Ru": "Добавить",
        ]
        static let date = [
            "Eng": "Date",
            "Ru": "Дата",
        ]
        static let deleteAlert = [
            "Eng": "Confirm deletion",
            "Ru": "Подтвердите удаление",
        ]
        static let deleteAlertDescription = [
            "Eng": "Are you sure you want to delete the exercise with all iteration history?",
            "Ru": "Вы действительно хотите удалить упражнение со всей историей повторений?",
        ]
        static let cancel = [
            "Eng": "Cancel",
            "Ru": "Отмена",
        ]
        static let delete = [
            "Eng": "Delete",
            "Ru": "Удалить",
        ]
    }
}
