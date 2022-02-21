//
//  AddNewExerciseEditorView.swift
//  Wotrack
//
//  Created by Роман Предеин on 21.02.2022.
//

import SwiftUI

struct AddNewExerciseEditorView: View {
    @ObservedObject var viewModel: ExercisesViewModel
    @State var textFieldValue = "" // title
    @State var iconValue = "" // icon
    
    // Tracks focus on a field
    @FocusState private var focusedField: Field?
    enum Field: Hashable {
        case textField
    }
    
    var body: some View {
        VStack {
            TextField("New exercise", text: $textFieldValue)
                .focused($focusedField, equals: .textField)
            Button {
                if textFieldValue != "" {
                    focusedField = nil
                    addNewItem(title: textFieldValue, icon: textFieldValue)
                    print("Saved")
                }
            } label: {
                Text("Add")
            }
        }
    }
    
    private func addNewItem(title: String, icon: String) {
        viewModel.addNewItem(with: title, and: icon)
    }
}

struct AddNewExerciseEditorView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewExerciseEditorView(viewModel: ExercisesViewModel())
    }
}
