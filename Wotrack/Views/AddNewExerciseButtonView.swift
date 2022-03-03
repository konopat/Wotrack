//
//  AddNewExerciseButtonView.swift
//  Wotrack
//
//  Created by Роман Предеин on 21.02.2022.
//

import SwiftUI

struct AddNewExerciseButtonView: View {
    
    @ObservedObject var viewModel: ExercisesViewModel
    @State private var showSheet = false // Show or hide new exercise options
    
    var body: some View {
        Button {
            showSheet = true
        } label: {
            ZStack {
                K.Card.shape
                    .foregroundColor(Color(K.Color.cardBackgroundColor))
                Image(systemName: K.Icons.SystemSet.plus)
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .frame(width: K.Card.iconWidth, height: K.Card.iconHeight)
                    .foregroundColor(Color(K.Color.textColor))
            }
            .aspectRatio(K.Card.aspectRatio, contentMode: .fit)
        }
        .sheet(isPresented: $showSheet) {
            AddNewExerciseEditorView(viewModel: viewModel, isPresented: $showSheet)
        }
    }
}

// MARK: - Preview
struct AddNewExerciseButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewExerciseButtonView(viewModel: ExercisesViewModel())
    }
}
