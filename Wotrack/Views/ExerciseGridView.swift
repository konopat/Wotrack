//
//  ExerciseGridView.swift
//  Wotrack
//
//  Created by Роман Предеин on 21.02.2022.
//

import SwiftUI
import UniformTypeIdentifiers // Need for drag and drop reordering in LazyVGrid

struct ExerciseGridView: View {
    
    @ObservedObject var viewModel: ExercisesViewModel
    let geometry: GeometryProxy // Expect dynamic sizes from the parent view
    
    var body: some View {
        LazyVGrid(columns: K.Grid.columns, spacing: K.Grid.spacing) {
            // CustomViewsExtenssion with drag and drop reordering feauter
            ReorderableForEach(items: viewModel.exercisesArray) { item in
                NavigationLink {
                    IteranceListView(viewModel: viewModel, exercise: item, geometry: geometry)
                } label: {
                    ExerciseCardView(viewModel: viewModel, exercise: item, geometry: geometry)
                }
            } moveAction: { source, destination in
                move(sourceOffsets: source, destinationOffset: destination)
            }
            AddNewExerciseButtonView(viewModel: viewModel)
        }
        .padding(.horizontal)
    }
    
    private func move(sourceOffsets: IndexSet, destinationOffset: Int) {
        viewModel.moveExercise(from: sourceOffsets, to: destinationOffset)
    }
}

// MARK: - Preview
struct ExerciseListView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            ExerciseGridView(viewModel: ExercisesViewModel(), geometry: geometry)
        }
    }
}
