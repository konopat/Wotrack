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
    let exercise: Exercise
    
    var body: some View {
        GeometryReader { geometry in // For dynamic size calculations.
            ScrollView { // If you want to place something other than a List on this view.
                VStack {
                    HStack {
                        if let exerciseTitle = exercise.title {
                            Text(exerciseTitle)
                                .font(.largeTitle .bold())
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text("Today: \(exercise.toDayIterances)")
                                Text("Total: \(exercise.sumOfIterances)")
                            }
                            .font(.caption)
                        }
                    }
                    .padding(.top)
                    .padding(.horizontal)
                    
                    AddNewItemFieldView(viewModel: viewModel, exercise: exercise)
                    
                    ListOfItemsView(viewModel: viewModel, geometry: geometry, exercise: exercise)
                }
                .background(Color(UIColor.systemGray6)) // Only for iOS 15 and above
            }
        }
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
                TextField("New iterance", value: $numberOfIterance, format: .number)
                    .keyboardType(.decimalPad)
                    .focused($focusedField, equals: .textField)
                Button {
                    focusedField = nil
                    addNewTask()
                } label: {
                    Text("Add")
                }
            }
            .padding()
            .background(.white) // Only for iOS 15 and above
        }
        .padding(.bottom, 5)
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
                                        Spacer()
                                        if let timestamp = item.timestamp {
                                            if calendar.isDateInToday(timestamp) {
                                                Text("Today")
                                            } else {
                                                Text("\(timestamp, format: Date.FormatStyle().year().month().day().hour().minute())")
                                                    .font(.caption)
                                            }
                                            
                                        }
                                    }
                                }
                            }
                        }
                    }
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
            .frame(height: geometry.size.height) // Required for Scrollview to work properly.
            .padding(.horizontal)
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

// MARK: - Preview

//
//struct IteranceListView_Previews: PreviewProvider {
//    static var previews: some View {
//        IteranceListView()
//    }
//}
