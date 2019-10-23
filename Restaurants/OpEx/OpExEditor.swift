//
//  OpExEditor.swift
//  Restaurants
//
//  Created by Igor Malyarov on 23.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct OpExEditor: View {
    @EnvironmentObject var userData: UserData
    @Binding var draft: OpExItem
    @Binding var isNameUsed: Bool
    var currency: Currency { userData.restaurant.currency }
    
    var body: some View {
        Group {
            Section(header: Text("Edit OpEx".uppercased())) {
                TextFieldWithReset("Name", text: $draft.name)
                    .alert(isPresented: $isNameUsed) {
                        Alert(title: Text("Duplicate name"),
                              message: Text("Name '\(draft.name)' is already taken, plese enter a different one."),
                              dismissButton: .default(Text("Ok")) {
                                self.isNameUsed = false
                            })}
                
                TextFieldWithReset("Description", text: $draft.description)
                
                Picker(selection: $draft.type, label: Text("OpEx Type")) {
                    ForEach(OpExType.allCases, id: \.id) { type in
                        Text(type.id).tag(type)
                    }
                }
                Stepper(value: $draft.amount, step: currency == .rub ? 10_000 : 100) {
                    BasicRow(title: "Amount", detail: currency.idd + draft.amount.formattedGrouped)
                }
                .contextMenu {
                    Button(action: {
                        self.draft.amount = 100
                    }) {
                        Image(systemName: "arrow.uturn.left.square")
                        Text(100.formattedGrouped)
                    }
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
                    }}
            }
            
            
        }
    }
}

struct OpExEditor_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                OpExEditor(draft: .constant(sampleOpex.opexes[0]), isNameUsed: .constant(false))
            }
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
