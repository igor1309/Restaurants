//
//  CreateKPIModal.swift
//  Restaurants
//
//  Created by Igor Malyarov on 09.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct CreateKPIModal: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject private var userData: UserData
    
    @State private var draft = KPIItem()
    @State private var isNameUsed = false
    
    var body: some View {
        NavigationView {
            Form {
                KPIEditor(draft: $draft, isNameUsed: $isNameUsed)
            }
            .navigationBarTitle(draft.name.isEmpty ? "New KPI Name" : draft.name)
                
            .navigationBarItems(
                leading: LeadingButtonSFSymbol("xmark") {
                    self.presentation.wrappedValue.dismiss()
                }
                .foregroundColor(.systemRed),
                
                trailing: TrailingButtonSFSymbol("checkmark") {
                    self.saveAndDismiss()
                }
                .disabled(draft.name.isEmpty))
        }
    }
    
    private func saveAndDismiss() {
        if draft.name.isNotEmpty {
            let generator = UINotificationFeedbackGenerator()
            if userData.restaurant.kpi.isNameUsed(draft) {
                isNameUsed = true
                generator.notificationOccurred(.error)
            } else {
                userData.restaurant.kpi.add(draft)
                generator.notificationOccurred(.success)
                presentation.wrappedValue.dismiss()
            }
        }
    }
}

struct CreateKPIModal_Previews: PreviewProvider {
    static var previews: some View {
        CreateKPIModal()
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
    }
}
