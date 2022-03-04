# Wotrack
Workout tracker (SwiftUI + CoreData + Relationships + CloudKit + Multilingual + Drag and Drop reordered Grid)

## Drag and Drop reordered Grid
Just use ReorderableForEach and moveAction to activate Drag and Drop reordered Grid:

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
![App gif preview](https://github.com/konopat/Wotrack/blob/ff954dc262c43ebf8de850c66589cc2058ef3c80/editMode.gif)

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
