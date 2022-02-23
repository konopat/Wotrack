//
//  ExerciseListView.swift
//  Wotrack
//
//  Created by Роман Предеин on 21.02.2022.
//

import SwiftUI
import UniformTypeIdentifiers // Need for drag and drop reordering in LazyVGrid

struct ExerciseListView: View {
    
    @ObservedObject var viewModel: ExercisesViewModel
    let geometry: GeometryProxy
    
    var body: some View {
        LazyVGrid(columns: K.Grid.columns, spacing: K.Grid.spacing) {
            // CustomViewsExtenssion with drag and drop reordering feauter
            ReorderableForEach(items: viewModel.items) { item in
                NavigationLink {
                    ExerciseEditorView(viewModel: viewModel, item: item)
                } label: {
                    ExerciseCardView(item: item, geometry: geometry)
                }

            } moveAction: { from, to in
                move(fromOffsets: from, toOffset: to)
            }
            AddNewExerciseButtonView(viewModel: viewModel)
        }
        .padding(.horizontal)
    }
    
    // MARK: - Functions
    
    private func move(fromOffsets: IndexSet, toOffset: Int) {
        viewModel.move(from: fromOffsets, to: toOffset)
    }
}

// MARK: - Preview

struct ExerciseListView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            ExerciseListView(viewModel: ExercisesViewModel(), geometry: geometry)
        }
    }
}
