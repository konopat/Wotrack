//
//  StartNavigationView.swift
//  Wotrack
//
//  Created by Роман Предеин on 17.02.2022.
//

import SwiftUI
import CoreData

struct StartNavigationView: View {

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
                                Spacer()
                                Text("Wotrack")
                                    .foregroundColor(Color(K.Color.lightTextColor))
                                    .font(.title)
                                    .bold()
                                Spacer()
                            }
                        }
                    }
                }
                .navigationTitle("Wotrack")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Fix problem with constraint warning
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartNavigationView()
    }
}
