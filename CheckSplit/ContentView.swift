//
//  ContentView.swift
//  CheckSplit
//
//  Created by Жанибек Асылбек on 11.10.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var isFocused: Bool
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerson = grandTotal / peopleCount
        return amountPerson
    }
    var totalCheck: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        return grandTotal
    }
    
    var body: some View {
        
        NavigationView {
            ZStack{
                Color(.red)
                Form {
                    
                    Section {
                        
                        TextField("Amount", value: $checkAmount, format: .currency(code: "KZT"))
                            .keyboardType(.decimalPad)
                            .focused($isFocused)
                        
                        Picker("Number of people", selection: $numberOfPeople) {
                            ForEach(2..<100){
                                Text("\($0) people")
                                
                            }
                        }
                    }
                    
                    Section("How much do you want to tip?"){
                        
                        Picker("Tip percentage", selection: $tipPercentage) {
    //                        ForEach(tipPercentages, id:\.self)
                            ForEach(0..<101)
                            {
                                Text($0, format: .percent )
                            }
                            .padding()
                            
                            .clipShape(Capsule())
                        }
                        .pickerStyle(.navigationLink)
                    }
                    
                    Section("Amount per person") {
                        Text(totalPerPerson, format: .currency(code:"KZT"))
                    }
                    
                    Section("Total anount for the check"){
                        Text(totalCheck, format: .currency(code: "KZT"))
                            .frame(maxWidth: .infinity)
                            .background(tipPercentage == 0 ? .red : .white)
                    }
                    
                    
                }
                
            }
            
            .navigationTitle("CheckSplit")
            .toolbar{
                if isFocused{
                    Button("Done"){
                        isFocused = false
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
