//
//  StartNavigationView.swift
//  Wotrack
//
//  Created by Роман Предеин on 17.02.2022.
//

import SwiftUI
import CoreData

struct StartNavigationView: View {
    
    // The first screen includes root options for navigation
    
    @ObservedObject var viewModel: ExercisesViewModel

    var body: some View {
        NavigationView {
            ZStack {
                // Background
                Color(K.Color.backgroundColor)
                    .edgesIgnoringSafeArea(.all)
                // Body
                GeometryReader { geometry in // Calculates screen sizes dynamically
                        VStack {
                            // Header
                            HStack {
                                Text(K.Brand.logoTitle)
                                    .foregroundColor(Color(K.Color.lightTextColor))
                                    .font(.title)
                                    .bold()
                            }
                            .padding()
                            // Content
                            ScrollView {
                                ExerciseGridView(viewModel: viewModel, geometry: geometry)
                            }
                            .onAppear(perform: loadData)
                        }
                }
                .navigationTitle(K.Brand.logoTitle) // For back button title
                .navigationBarHidden(true) // We wrote custom header above
                .navigationBarTitleDisplayMode(.inline) // Reduces heading space
            }
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Fix problem with constraint warning        
    }
    private func loadData() {
        viewModel.loadData()
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartNavigationView(viewModel: ExercisesViewModel())
            .preferredColorScheme(.light)
    }
}


