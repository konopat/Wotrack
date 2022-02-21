//
//  ExerciseListView.swift
//  Wotrack
//
//  Created by Роман Предеин on 21.02.2022.
//

import SwiftUI

struct ExerciseListView: View {
    
    @ObservedObject var viewModel: ExercisesViewModel
    let geometry: GeometryProxy
    
    var body: some View {
        LazyVGrid(columns: [GridItem(), GridItem()], spacing: 10) {
            ForEach(viewModel.items) { item in
                ExerciseCardView(item: item, geometry: geometry)
                    .onDrag {
                        return NSItemProvider()
                    }
            }
            .onMove(perform: move)
            
            AddNewExerciseButtonView(viewModel: viewModel)
        }
        .padding(.horizontal)
    }
    
    private func move(the source: IndexSet, to destination: Int) {
        viewModel.move(from: source, to: destination)
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
