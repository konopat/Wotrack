//
//  ExerciseEditorView.swift
//  Wotrack
//
//  Created by Роман Предеин on 21.02.2022.
//

import SwiftUI

struct ExerciseEditorView: View {
    
    @ObservedObject var viewModel: ExercisesViewModel
    @State var textFieldValue = "New exercise" // title
    
    let item: Exercise
    
    var body: some View {
        TextField("New exercise", text: $textFieldValue)
            .font(.title)
            .onDisappear(perform: saveData)
    }
    
    private func getTitleValue() {
        if let itemTitle = item.title {
            textFieldValue = itemTitle
        }
    }
    
    private func saveData() {
        item.title = textFieldValue
        viewModel.saveData()
        print(viewModel.items)
    }
}

// MARK: - Preview

struct ExerciseEditorView_Previews: PreviewProvider {
    
    static let persistence = PersistenceController()
    
    static var testItem: Exercise = {
        let context = persistence.container.viewContext
        let testItem = Exercise(context: context)
        testItem.id = UUID()
        testItem.title = "Test"
        testItem.timestamp = Date()
        testItem.icon = K.Icons.Default.icon
        return testItem
    }()
    
    static var previews: some View {
        ExerciseEditorView(viewModel: ExercisesViewModel(), item: testItem)
            .environment(\.managedObjectContext, persistence.container.viewContext)
    }
}
