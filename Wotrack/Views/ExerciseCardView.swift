//
//  ExerciseCardView.swift
//  Wotrack
//
//  Created by Роман Предеин on 21.02.2022.
//

import SwiftUI

struct ExerciseCardView: View {
    
    let item: Exercise
    let geometry: GeometryProxy
    var body: some View {
        
        if let itemTitle = item.title {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color(K.Color.cardBackgroundColor))
                VStack(spacing: 5) {
                    Image(item.icon ?? K.Icons.Default.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width / 4)
                    Text(itemTitle)
                        .bold()
                        .foregroundColor(Color(K.Color.textColor))
                        
                    VStack(spacing: 2) {
                        Text("150 / 150 / 33150")
                    }
                    .font(.caption2)
                }
                .padding()
            }
            .aspectRatio(4/5, contentMode: .fit)
        }
    }
}
