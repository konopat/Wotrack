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
            // Content
            ScrollView {
                VStack {
                    // Icons
                    Group {
                        HStack {
                            SelectedIcon(icon: iconValue)
                            Spacer()
                        }
                        HStack {
                            Text(K.Text.chooseAnIcon[viewModel.language] ?? "Choose an icon")
                                .font(.title)
                                .foregroundColor(Color(K.Color.lightTextColor))
                            Spacer()
                        }
                        ScrollView(.horizontal){
                            HStack {
                                ForEach(K.Icons.Default.iconSet, id: \.self) { icon in
                                    IconToChooseFromView(icon: icon)
                                        .onTapGesture {
                                            iconValue = icon
                                        }
                                }
                            }
                        }
                    }
                    // Title
                    HStack {
                        Text(K.Text.nameTheExercise[viewModel.language] ?? "Name the exercise:")
                            .font(.title)
                            .foregroundColor(Color(K.Color.lightTextColor))
                        Spacer()
                    }.padding(.top)
                    TextField(K.Text.nameTheExercise[viewModel.language] ?? "New exercise", text: $textFieldValue)
                        .padding()
                        .background(.white)
                        .focused($focusedField, equals: .textField)
                    // Confirm button
                    Button {
                        addNewItem(title: textFieldValue, icon: iconValue)
                    } label: {
                        ZStack {
                            K.Button.shape
                                .foregroundColor(Color(K.Color.cardBackgroundColor))
                            Text(K.Text.confirm[viewModel.language] ?? "Confirm")
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
            viewModel.addNewExercise(with: title, and: icon)
            isPresented = false
        }
    }
}

// MARK: - Sub views
struct IconToChooseFromView: View {
    let icon: String
    var body: some View {
        ZStack {
            K.Card.shape
                .foregroundColor(Color(K.Color.cardBackgroundColor))
                .frame(width: K.Card.inGallery.Frame.width, height: K.Card.inGallery.Frame.height)
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: K.Card.inGallery.Icon.Frame.width, height: K.Card.inGallery.Icon.Frame.height)
        }
    }
}

struct SelectedIcon: View {
    let icon: String
    var body: some View {
        ZStack {
            K.Card.shape
                .foregroundColor(Color(K.Color.cardBackgroundColor))
                .frame(width: K.Card.Selected.Frame.width, height: K.Card.Selected.Frame.height)
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: K.Card.Selected.Icon.Frame.width, height: K.Card.Selected.Icon.Frame.height)
        }
    }
}
