# Wotrack
Workout tracker (SwiftUI + MVVM + CoreData + CloudKit). 

Also used: Relationships, Multilingual, Drag and Drop reordered Grid.

![App gif preview](https://github.com/konopat/Wotrack/blob/a106b7b7f1cf028e306bded25d708accdcd429e8/preview.gif)

Icons made by Ultimatearm from [flaticon.com](https://www.flaticon.com/authors/ultimatearm "The best icons for free")

## CoreData + MVVM
MVVM makes work with CoreData clearer. You will find all the logic with detailed comments in the file:
[ViewModel/ExercisesViewModel.swift](https://github.com/konopat/Wotrack/blob/9dd84bf6a328c76a686a285f6a3a574025d1cec5/Wotrack/ViewModel/ExercisesViewModel.swift "ViewModel example")



## Drag and Drop reordered Grid
Just use ReorderableForEach (Views/CustomViewsExtenssions/ReorderableForEach) and moveAction in LazyVGrid() to activate Drag and Drop reordered Grid:

```
  LazyVGrid(columns: columns, spacing: spacing) {
            ReorderableForEach(items: viewModel.items) { item in
                Text(item.title)
            } moveAction: { source, destination in
                move(sourceOffsets: source, destinationOffset: destination)
            }
  }

```

![App gif preview](https://github.com/konopat/Wotrack/blob/ff954dc262c43ebf8de850c66589cc2058ef3c80/dragableGrid.gif)

## Add new parent-item with custom icon picker

```
ScrollView(.horizontal){
    HStack {
        ForEach(K.Icons.Default.iconSet, id: \.self) { icon in
            IconToChooseFromView(icon: icon)
                .onTapGesture {
                    iconValue = icon
                }
        }
    }
}

```
![App gif preview](https://github.com/konopat/Wotrack/blob/3a270d845d91d1571033ac00f567060c1450501c/iconSet.gif)

You can change the default icon set with your own in Constants.swift file

```
struct Icons {
    struct SystemSet {
        static let plus = "plus"
        static let trash = "trash"
    }
    struct Default {
        static let authorURL = "https://www.flaticon.com/authors/ultimatearm"
        static let authorCitation = "Icons made by Ultimatearm from www.flaticon.com"
        static let icon = "default"
        static let iconSet = []
   }
}

```
## Core Data relationships

Relationships allows you to create child lists.

![App gif preview](https://github.com/konopat/Wotrack/blob/3a270d845d91d1571033ac00f567060c1450501c/CDRelationships.gif)

## Switch language

I use just Eng/Rus, but you can add more. The user's choice is stored in userDefaults.

![App gif preview](https://github.com/konopat/Wotrack/blob/efa9cae25341108248022e9153b9acdb28315a45/switchLanguage.gif)

## First generation iPhone SE supported

![First generation iPhone SE supported](https://github.com/konopat/Wotrack/blob/6be8c796087054a53887a18f6811f1ce5ce2bf43/iphoneSE.png)
