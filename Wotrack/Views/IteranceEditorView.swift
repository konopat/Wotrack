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
        VStack {
            TextField("New iterance", value: $numberOfIterance, format: .number)
                .multilineTextAlignment(.center)
                .padding()
                .font(.largeTitle .bold())
                .keyboardType(.decimalPad)
            
            DatePicker("Date:", selection: $timestamp)
                
            Button {
                saveData()
                dismiss()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 0)
                        .foregroundColor(Color(K.Color.backgroundColor))
                    Text("Confirm")
                        .bold()
                        .foregroundColor(Color(K.Color.lightTextColor))
                        .padding()
                }
                .frame(height: 50)
            }
            Spacer()
        }
        .padding()
        .onAppear(perform: loadData)
        .onDisappear(perform: saveData)
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

//struct IteranceEditorView_Previews: PreviewProvider {
//    static var previews: some View {
//        IteranceEditorView()
//    }
//}
