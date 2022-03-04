//
//  IteranceListView.swift
//  Wotrack
//
//  Created by Роман Предеин on 25.02.2022.
//

import SwiftUI
import CoreData

struct IteranceListView: View {
    
    @ObservedObject var viewModel: ExercisesViewModel
    let exercise: Exercise // Expect the exercise from the parent view
    let geometry: GeometryProxy // Expect dynamic sizes from the parent view
    @State private var showingAlert = false
    
    var body: some View {
        ScrollView { // If you want to place something other than a List on this view.
            VStack(spacing: K.Grid.spacing) {
                HStack {
                    if let exerciseTitle = exercise.title {
                        Text(exerciseTitle)
                            .font(.largeTitle .bold())
                            .foregroundColor(Color(K.Color.lightTextColor))
                        Spacer()
                        Button {
                            showingAlert = true
                        } label: {
                            Image(systemName: K.Icons.SystemSet.trash)
                                .foregroundColor(Color(K.Color.lightTextColor))
                        }
                        .alert(isPresented: $showingAlert) {
                            Alert(
                                title: Text(K.Text.deleteAlert[viewModel.language] ?? "Confirm deletion"),
                                message: Text(K.Text.deleteAlertDescription[viewModel.language] ?? "Are you sure?"),
                                primaryButton: .destructive(Text(K.Text.delete[viewModel.language] ?? "Delete")) {
                                    delete()
                                },
                                secondaryButton: .cancel(Text(K.Text.cancel[viewModel.language] ?? "Cancel" ))
                            )
                        }

                    }
                }
                .padding()
                
                // Field
                AddNewItemFieldView(viewModel: viewModel, exercise: exercise)
                HStack() {
                    Group {
                        Text("\(K.Text.toDay[viewModel.language] ?? "Today"): \(exercise.toDayIterances)")
                        Text("\(K.Text.total[viewModel.language] ?? "Total"): \(exercise.sumOfIterances)")
                        Spacer()
                    }
                    .foregroundColor(Color(K.Color.lightTextColor))
                }
                .padding(.horizontal)
                // Listing
                ListOfItemsView(viewModel: viewModel, geometry: geometry, exercise: exercise)
            }
            .background(
                Color(K.Color.backgroundColor)
                            .edgesIgnoringSafeArea(.all)
            )
        }        
    }
    
    func delete() {
        viewModel.delete(the: exercise)
    }
}

// MARK: - SubViews

struct AddNewItemFieldView: View {
    
    @State var viewModel: ExercisesViewModel
    @State var numberOfIterance: Int?
    let exercise: Exercise
    
    // Tracks focus on a field
    @FocusState private var focusedField: Field?
    enum Field: Hashable {
        case textField
    }
    
    var body: some View {
        Group {
            HStack {
                TextField(K.Text.newIterance[viewModel.language] ?? "New iterance", value: $numberOfIterance, format: .number)
                    .foregroundColor(Color(K.Color.textColor))
                    .keyboardType(.decimalPad)
                    .focused($focusedField, equals: .textField)
                    
                Button {
                    focusedField = nil
                    addNewTask()
                } label: {
                    Text(K.Text.add[viewModel.language] ?? "Add")
                        .foregroundColor(Color(K.Color.textColor))
                }
            }
            .padding()
            .background(Color(K.Color.cardBackgroundColor)) // Only for iOS 15 and above
        }
        .padding(.horizontal)
    }
    
    private func addNewTask() {
        if let currentNumber = numberOfIterance {
            viewModel.addNewIterance(number: currentNumber, to: exercise)
            numberOfIterance = nil
        }
    }
    
}

struct ListOfItemsView: View {
    
    @State var viewModel: ExercisesViewModel
    let geometry: GeometryProxy
    let exercise: Exercise
    let calendar = Calendar.current
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.iterancesArray) { item in
                    HStack {
                        NavigationLink {
                            IteranceEditorView(viewModel: viewModel, iterance: item)
                        } label: {
                            if let iteranceItem = item {
                                if let number = iteranceItem.number {
                                    HStack {
                                        Text("\(number)")
                                            .font(.title)
                                            .bold()
                                            .foregroundColor(Color(K.Color.textColor))
                                        Spacer()
                                        if let timestamp = item.timestamp {
                                            if calendar.isDateInToday(timestamp) {
                                                Text(K.Text.toDay[viewModel.language] ?? "Today")
                                                    .foregroundColor(Color(K.Color.textColor))
                                            } else {
                                                Text("\(timestamp, format: Date.FormatStyle().year().month().day().hour().minute())")
                                                    .font(.caption)
                                                    .foregroundColor(Color(K.Color.textColor))
                                            }
                                            
                                        }
                                    }
                                    .padding()
                                }
                            }
                        }
                    }
                    .listRowBackground(Color(K.Color.cardBackgroundColor))
                    .onDrag {
                        return NSItemProvider()
                        // Combination with NSItemProvider() on drag gesture and .OnMove function
                        // allows the ability to move tasks by simply grabbing the one you need
                        // without activating the edit mode.
                    }
                }
                .onDelete(perform: deleteItems)

            }
            .listStyle(PlainListStyle()) // Removes defaults padding.
            .padding(.horizontal)
            .frame(height: geometry.size.height) // Required for Scrollview to work properly.
            .onAppear(perform: loadItems)
        }
    }
        
    
    private func loadItems() {
        viewModel.loadIterances(by: exercise)
    }
    
    private func deleteItems(offsets: IndexSet) {
        viewModel.deleteIterance(by: offsets)
        viewModel.loadIterances(by: exercise)
    }
}
