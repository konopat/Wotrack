//
//  AddNewExerciseEditorView.swift
//  Wotrack
//
//  Created by Роман Предеин on 21.02.2022.
//

import SwiftUI

struct AddNewExerciseEditorView: View {
    
    @ObservedObject var viewModel: ExercisesViewModel
    @Binding var isPresented: Bool
    @State private var textFieldValue = "" // title
    @State private var iconValue = K.Icons.Default.icon // icon
    
    // Tracks focus on a field
    @FocusState private var focusedField: Field?
    enum Field: Hashable {
        case textField
    }
    
    var body: some View {
        ZStack {
            // Background
            Color(K.Color.backgroundColor)
            ScrollView {
                VStack {
                    Group {
                        HStack {
                            SelectedIcon(icon: iconValue)
                            Spacer()
                        }
                        HStack {
                            Text("Choose an icon:")
                                .font(.title)
                                .foregroundColor(Color(K.Color.lightTextColor))
                            Spacer()
                        }
                        ScrollView(.horizontal){
                            HStack {
                                ForEach(K.Icons.Default.defaultIconSet, id: \.self) { icon in
                                    IconToChooseFromView(icon: icon)
                                        .onTapGesture {
                                            iconValue = icon
                                        }
                                }
                            }
                        }
                    }
                    
                    HStack {
                        Text("Name the exercise:")
                            .font(.title)
                            .foregroundColor(Color(K.Color.lightTextColor))
                        Spacer()
                    }.padding(.top)
                    TextField("New exercise", text: $textFieldValue)
                        .padding()
                        .background(.white)
                        .focused($focusedField, equals: .textField)
                    
                    Button {
                        addNewItem(title: textFieldValue, icon: iconValue)
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 0)
                                .foregroundColor(Color(K.Color.cardBackgroundColor))
                            Text("Confirm")
                                .bold()
                                .foregroundColor(Color(K.Color.textColor))
                                .padding()
                        }
                    }

                    
                    Spacer()
                }
                .padding()
            }
        }
    }
    
    private func addNewItem(title: String, icon: String) {
        if textFieldValue != "" {
            viewModel.addNewItem(with: title, and: icon)
            isPresented = false
        }
    }
}

struct IconToChooseFromView: View {
    let icon: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color(K.Color.cardBackgroundColor))
                .frame(width: 100, height: 100)
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
        }
    }
}

struct SelectedIcon: View {
    let icon: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color(K.Color.cardBackgroundColor))
                .frame(width: 150, height: 150)
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
        }
    }
}
