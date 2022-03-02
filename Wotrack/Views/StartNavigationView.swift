//
//  StartNavigationView.swift
//  Wotrack
//
//  Created by Роман Предеин on 17.02.2022.
//

import SwiftUI
import CoreData

struct StartNavigationView: View {
    
    @ObservedObject var viewModel: ExercisesViewModel

    var body: some View {
        NavigationView {
            ZStack {
                // Background
                Color(K.Color.backgroundColor)
                    .edgesIgnoringSafeArea(.all)
                GeometryReader { geometry in
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
                                ExerciseListView(viewModel: viewModel, geometry: geometry)
                            }
                            .onAppear(perform: loadData)
                        }
                }
                .navigationTitle("Wotrack")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Fix problem with constraint warning
        
    }
    private func loadData() {
        viewModel.loadExercises()
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartNavigationView(viewModel: ExercisesViewModel())
            .preferredColorScheme(.light)
    }
}


