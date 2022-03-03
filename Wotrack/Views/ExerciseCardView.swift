//
//  ExerciseCardView.swift
//  Wotrack
//
//  Created by Роман Предеин on 21.02.2022.
//

import SwiftUI

struct ExerciseCardView: View {
    
    @ObservedObject var viewModel: ExercisesViewModel
    let exercise: Exercise // Expect the exercise from the parent view
    let geometry: GeometryProxy // Expect dynamic sizes from the parent view
    
    var body: some View {
        if let itemTitle = exercise.title { // Only if exercise data is received
            ZStack {
                // Background
                K.Card.shape
                    .foregroundColor(Color(K.Color.cardBackgroundColor))
                // Content
                VStack(spacing: K.Card.spacing) {
                    Image(exercise.icon ?? K.Icons.Default.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width / K.Card.iconRatio)
                    Text(itemTitle)
                        .bold()
                        .foregroundColor(Color(K.Color.textColor))
                        
                    VStack(spacing: K.Card.spacingCaption) {
                        Text("\(K.Text.toDay[viewModel.language] ?? "Today"): \(exercise.toDayIterances)")
                        Text("\(K.Text.total[viewModel.language] ?? "Total"): \(exercise.sumOfIterances)")
                    }
                    .font(.caption2)
                    .foregroundColor(Color(K.Color.textColor))
                }
                .padding()
            }
            .aspectRatio(K.Card.aspectRatio, contentMode: .fit)
        }
    }
}
