//
//  IteranceEditorView.swift
//  Wotrack
//
//  Created by Роман Предеин on 02.03.2022.
//

import SwiftUI

struct IteranceEditorView: View {
    
    @ObservedObject var viewModel: ExercisesViewModel
    @Environment(\.dismiss) var dismiss
    @State var numberOfIterance: Int16 = 0
    @State var timestamp: Date = Date()
    
    let iterance: Iterance
    
    var body: some View {
        ZStack {
            Color(K.Color.backgroundColor)
                .edgesIgnoringSafeArea(.bottom)
            VStack {
                TextField(K.Text.newIterance[viewModel.language] ?? "New iterance", value: $numberOfIterance, format: .number)
                    .foregroundColor(Color(K.Color.lightTextColor))
                    .multilineTextAlignment(.center)
                    .padding()
                    .font(.system(size: 70) .bold())
                    .keyboardType(.decimalPad)
                
                DatePicker("\(K.Text.date[viewModel.language] ?? "Date"):", selection: $timestamp)
                    .labelsHidden()    
                    .padding()
                    .background(Color(K.Color.cardBackgroundColor))
                    
                    
                Button {
                    saveData()
                    dismiss()
                } label: {
                    ZStack {
                        K.Button.shape
                            .foregroundColor(Color(K.Color.backgroundColor))
                        Text(K.Text.confirm[viewModel.language] ?? "Confirm")
                            .bold()
                            .foregroundColor(Color(K.Color.lightTextColor))
                            .padding()
                    }
                    .frame(height: K.Button.height)
                }
                Spacer()
            }
            .padding()
            .onAppear(perform: loadData)
            .onDisappear(perform: saveData)
        }
    }
    
    func loadData() {
        numberOfIterance = iterance.number
        if let iteranceDate = iterance.timestamp {
            timestamp = iteranceDate
        }
        
    }
    func saveData() {
        iterance.number = numberOfIterance
        iterance.timestamp = timestamp
        viewModel.saveData()
    }
}
