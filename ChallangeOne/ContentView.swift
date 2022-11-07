//
//  ContentView.swift
//  ChallangeOne
//
//  Created by Elkilany on 02/11/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var timeValue = 0.0
    @State private var selectInputUnit: Unites = .seconds
    @State private var selectOutputUnit: Unites = .seconds
    @FocusState private var dismissKeyboard: Bool
    
    var timeResult: Double {
        var result = 0.0
        
        guard  timeValue > 0  else{
            return 0
        }
        
        if selectInputUnit == .seconds {
            result = secondResult(selectedUnit: selectOutputUnit)
        }else if selectInputUnit == .minutes {
            result = minutesResult(selectedUnit: selectOutputUnit)
        }else if selectInputUnit == .hours {
            result = hoursResult(selectedUnit: selectOutputUnit)
        }else if selectInputUnit == .days {
            result = DaysResult(selectedUnit: selectOutputUnit)
        }
        return result
    }
    
    func secondResult(selectedUnit:Unites)->Double{
        switch selectedUnit {
        case .seconds:
            return timeValue
        case .minutes:
            return (timeValue / 60)
        case .hours:
            return (timeValue / 3600)
        case .days:
            return (timeValue / 86400)
        }
    }
    
    func minutesResult(selectedUnit:Unites)->Double{
        switch selectedUnit {
        case .seconds:
            return (timeValue * 60)
        case .minutes:
            return timeValue
        case .hours:
            return (timeValue / 60)
        case .days:
            return timeValue / 1440
        }
    }
    
    func hoursResult(selectedUnit:Unites)->Double{
        switch selectedUnit {
        case .seconds:
            return (timeValue * 3600)
        case .minutes:
            return (timeValue * 60)
        case .hours:
            return timeValue
        case .days:
            return (timeValue / 24)
        }
    }
    
    func DaysResult(selectedUnit:Unites)->Double{
        switch selectedUnit {
        case .seconds:
            return (timeValue * 86400)
        case .minutes:
            return (timeValue * 1440)
        case .hours:
            return (timeValue * 24)
        case .days:
            return timeValue
        }
    }
    
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Time value",value: $timeValue, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                        .focused($dismissKeyboard)
                }
                
            header:{
                Text("Enter the value of time")
            }
                Section{
                    Picker("Select Input Unit",selection: $selectInputUnit){
                        ForEach(Unites.allCases,id: \.self){ InputUnit in
                            Text(InputUnit.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            header:{
                Text("Choose the input unit")
            }
                
                Section{
                    Picker("Select the ouput Unit",selection: $selectOutputUnit){
                        
                        ForEach(Unites.allCases,id: \.self){ outputunit in
                            Text(outputunit.rawValue.capitalized)
                        }
                        //                        ForEach(0..<ouputUntites.count,id: \.self){ outputunit in
                        //                            Text(ouputUntites[outputunit])
                        //                        }
                    }
                    .pickerStyle(.segmented)
                }
            header:{
                Text("Choose output unit")
            }
                Section{
                    Text("\(timeResult)")
                }
            header:{
                Text("time Conversion Result")
            }
            }
            .navigationTitle("Time Conversion")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done"){
                        dismissKeyboard = false
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


enum Unites: String, CaseIterable, Identifiable{
    case seconds, minutes, hours,days
    var id: Self {self}
}
/*
 for (key, value) in dict {
 println("key is - \(key) and value is - \(value)")
 }
 */
