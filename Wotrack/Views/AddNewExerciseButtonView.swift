//
//  AddNewExerciseButtonView.swift
//  Wotrack
//
//  Created by Роман Предеин on 21.02.2022.
//

import SwiftUI

struct AddNewExerciseButtonView: View {
    
    @ObservedObject var viewModel: ExercisesViewModel
    @State private var showSheet = false
    
    var body: some View {
        Button {
            showSheet = true
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color(K.Color.cardBackgroundColor))
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .frame(width: 60, height: 60)
                    .foregroundColor(Color(K.Color.textColor))
            }
            .aspectRatio(4/5, contentMode: .fit)
        }
        .sheet(isPresented: $showSheet) {
            AddNewExerciseEditorView(viewModel: viewModel, isPresented: $showSheet)
        }
    }
}

struct AddNewExerciseButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewExerciseButtonView(viewModel: ExercisesViewModel())
    }
}
