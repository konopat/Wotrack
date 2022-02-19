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
    let testitems = [
        "Squats",
        "Push-ups",
        "Pull-ups",
        "Sit-ups",
    ]

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
                                Text("WoTrack")
                                    .foregroundColor(Color(K.Color.lightTextColor))
                                    .font(.title)
                                    .bold()
                            }
                            .padding()
                            // Content
                            ScrollView {
                                LazyVGrid(columns: [GridItem(), GridItem()], spacing: 10) {
                                    ForEach(testitems, id: \.self) { item in
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 10)
                                                .foregroundColor(Color(K.Color.cardBackgroundColor))
                                            VStack(spacing: 5) {
                                                Image(K.Icons.Squat.icon)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: geometry.size.width / 4)
                                                Text(item)
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
                                            
//                                        if let itemTitle = item.title {
//                                            VStack {
//                                                Text(itemTitle)
//                                            }
//                                            .aspectRatio(3/2, contentMode: .fit)
//                                        }
                                    }
                                    AddWorkoutButtonView()
                                }
                                .padding(.horizontal)
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
        viewModel.loadData()
    }
}

struct AddWorkoutButtonView: View {
    var body: some View {
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartNavigationView(viewModel: ExercisesViewModel())
            .preferredColorScheme(.light)
    }
}


