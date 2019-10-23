//
//  KPIEditor.swift
//  Restaurants
//
//  Created by Igor Malyarov on 23.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CapsuleButtonForDates: View {
    var days: Int
    @Binding var dueDate: Date
    
    var body: some View {
        Text("+" + days.formattedGrouped)
            .font(.footnote)
            .foregroundColor(.systemOrange)
            .padding(.vertical, 6)
            .padding(.horizontal)
            .background(Capsule()
                .stroke(lineWidth: 2)
                .foregroundColor(.systemOrange))
            .padding(8)
            .onTapGesture { self.dueDate = Date().addDays(self.days) }
    }
}

struct KPIEditor: View {
    @EnvironmentObject var userData: UserData
    @Binding var draft: KPIItem
    @Binding var isNameUsed: Bool
    
    var body: some View {
        Group {
            Section(header: Text("Edit KPI".uppercased())) {
                TextFieldWithReset("Name", text: $draft.name)
                    .alert(isPresented: $isNameUsed) {
                        Alert(title: Text("Duplicate name"),
                              message: Text("Name '\(draft.name)' is taken, please enter a different one."),
                              dismissButton: .default(Text("Ok")))}
                
                TextFieldWithReset("Description", text: $draft.description)
                
                DatePicker("Due",
                           selection: $draft.dueDate,
                           displayedComponents: [.date])
                
                HStack {
                    CapsuleButtonForDates(days: 14, dueDate: $draft.dueDate)
                    Spacer()
                    CapsuleButtonForDates(days: 30, dueDate: $draft.dueDate)
                    Spacer()
                    CapsuleButtonForDates(days: 90, dueDate: $draft.dueDate)
                    Spacer()
                    CapsuleButtonForDates(days: 180, dueDate: $draft.dueDate)
                }
            }
        }
    }
}

struct KPIEditor_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                KPIEditor(draft: .constant(sampleKPI.kpis[0]), isNameUsed: .constant(false))
            }
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
