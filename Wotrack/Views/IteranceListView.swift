//
//  IteranceListView.swift
//  Wotrack
//
//  Created by Роман Предеин on 25.02.2022.
//

import SwiftUI
import CoreData

struct IteranceListView: View {
    
    @ObservedObject var viewModel: IterancesViewModel
    let exercise: Exercise
    
    var body: some View {
        GeometryReader { geometry in // For dynamic size calculations.
            ScrollView { // If you want to place something other than a List on this view.
                VStack {
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
    
    @State var viewModel: IterancesViewModel
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
        .padding(.top)
        .padding(.bottom, 5)
        .padding(.horizontal)
    }
    
    private func addNewTask() {
        if let currentNumber = numberOfIterance {
            viewModel.addNewItem(number: currentNumber, to: exercise)
            numberOfIterance = nil
        }
    }
    
}

struct ListOfItemsView: View {
    
    @State var viewModel: IterancesViewModel
    let geometry: GeometryProxy
    let exercise: Exercise
    
    var body: some View {
        List {
            ForEach(viewModel.items) { item in
                HStack {
                    NavigationLink {
                        //
                    } label: {
                        if let number = item.number, let timestamp = item.timestamp {
                            HStack {
                                Text("\(number)")
                                    .font(.title)
                                    .bold()
                                Spacer()
                                Text("\(timestamp)")
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
        
    
    private func loadItems() {
        viewModel.loadData(from: exercise)
    }
    
    private func deleteItems(offsets: IndexSet) {
        viewModel.deleteItems(by: offsets, in: exercise)
    }
}

// MARK: - Preview

//
//struct IteranceListView_Previews: PreviewProvider {
//    static var previews: some View {
//        IteranceListView()
//    }
//}
