//
//  CapExEditor.swift
//  Restaurants
//
//  Created by Igor Malyarov on 23.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CapExEditor: View {
    @EnvironmentObject var userData: UserData
    @Binding var draft: CapExItem
    @Binding var isNameUsed: Bool
    var currency: Currency { userData.restaurant.currency }
    
    var body: some View {
        Group {
            Section(header: Text("Name and Description".uppercased())) {
                TextFieldWithReset("Text", text: $draft.name)
                    .alert(isPresented: $isNameUsed) {
                        Alert(title: Text("Duplicate name"),
                              message: Text("Name '\(draft.name)' is taken, please enter a different one."),
                              dismissButton: .default(Text("Ok")))}
                
                TextFieldWithReset("Description", text: $draft.description)
            }
            
            Section(header: Text("Price".uppercased()),
                    footer: Text("Full purchase price of the asset or services considered CAPEX or amount of Working Capital.")) {
                        Stepper(value: $draft.amount, step: currency == .rub ? 100_000 : 1_000) {
                            BasicRow(title: "Price (amount)", detail: currency.idd + draft.amount.formattedGrouped)
                        }
                        .contextMenu {
                            Button(action: {
                                self.draft.amount = 1_000
                            }) {
                                Image(systemName: "arrow.uturn.left.square")
                                Text(1_000.formattedGrouped)
                            }
                            Button(action: {
                                self.draft.amount = 10_000
                            }) {
                                Image(systemName: "arrow.uturn.left.square")
                                Text(10_000.formattedGrouped)
                            }
                            Button(action: {
                                self.draft.amount = 50_000
                            }) {
                                Image(systemName: "arrow.uturn.left.square")
                                Text(50_000.formattedGrouped)
                            }
                            Button(action: {
                                self.draft.amount = 100_000
                            }) {
                                Image(systemName: "arrow.uturn.left.square")
                                Text(100_000.formattedGrouped)
                            }
                            Button(action: {
                                self.draft.amount = 1_000_000
                            }) {
                                Image(systemName: "arrow.uturn.left.square")
                                Text(1_000_000.formattedGrouped)
                            }}
            }
            
            
            Section(header: Text("Lifetime, years".uppercased()),
                    footer: Text("Investment in Working Capital should be entered with Lifetime of 1.")) {
                        //
                        Picker(selection: $draft.lifetime, label: Text("Asset lifetime, years")) {
                            ForEach(1...7, id: \.self) { index in
                                Text("\(index)").tag(index)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .labelsHidden()
                        
                        BasicRow(title: "Depreciation, per month", detail: currency.idd + draft.depreciationPerMonth.formattedGrouped, color: .secondary)
            }
        }
    }
}

struct CapExEditor_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                CapExEditor(draft: .constant(sampleCapex.capexes[0]), isNameUsed: .constant(false))
            }
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
