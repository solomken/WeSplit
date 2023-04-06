//
//  ContentView.swift
//  WeSplit
//
//  Created by Anastasiia Solomka on 28.02.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    var totalPerPerson: Double { //calculate the total amount per person
        let peopleCount = Double(numberOfPeople + 2) //convert value to a double. the range 2 to 100, but it counts from 0, which is why we need to add the 2.
        let tipSelection = Double(tipPercentage) //convert value to a double
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var originalTotalAmount: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        
        let originalAmountPlusTips = checkAmount + tipValue
        
        return originalAmountPlusTips
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format:
                        .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                } header: {
                    Text("How much tip you wanna leave?")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Total to pay per person")
                }
                
                Section {
                    Text(originalTotalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Original amount")
                }
            }
            .navigationTitle("WeSplit")
            
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer() //center button Done (all in toolbar to the right)
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
