# Wotrack
Workout tracker (SwiftUI + MVVM + CoreData + CloudKit). Also used: Relationships, Multilingual, Drag and Drop reordered Grid.

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

You can change the default icon set with your own in Contants.swift file

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

Allows you to create child lists

![App gif preview](https://github.com/konopat/Wotrack/blob/3a270d845d91d1571033ac00f567060c1450501c/CDRelationships.gif)

## Switch language

I use just Eng/Rus, but you can add more. The user's choice is stored in userDefaults.

![App gif preview](https://github.com/konopat/Wotrack/blob/efa9cae25341108248022e9153b9acdb28315a45/switchLanguage.gif)

## First generation iPhone SE supported

![First generation iPhone SE supported](https://github.com/konopat/Wotrack/blob/6be8c796087054a53887a18f6811f1ce5ce2bf43/iphoneSE.png)
