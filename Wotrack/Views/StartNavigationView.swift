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
                    ScrollView {
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
                            List {
                                ForEach(viewModel.items) { item in
                                    Text(item.title ?? "test")
                                }
                            }
                        }
                    }
                    .frame(width: geometry.size.width ,height: geometry.size.height)
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartNavigationView(viewModel: ExercisesViewModel())
    }
}
