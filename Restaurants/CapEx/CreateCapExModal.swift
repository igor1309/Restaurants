//
//  CreateCapExModal.swift
//  Restaurants
//
//  Created by Igor Malyarov on 08.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CreateCapExModal: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject private var userData: UserData
    var currency: Currency { userData.restaurant.currency }
    
    @State private var draft = CapExItem()
    @State private var isNameUsed = false
    
    var body: some View {
        NavigationView {
            Form {
                CapExEditor(draft: $draft, isNameUsed: $isNameUsed)
            }
            .navigationBarTitle(draft.name.isEmpty ? "New CapEx Name" : draft.name)
                
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
            if userData.restaurant.capex.isNameUsed(draft) {
                isNameUsed = true
                generator.notificationOccurred(.error)
            } else {
                userData.restaurant.capex.add(draft)
                generator.notificationOccurred(.success)
                presentation.wrappedValue.dismiss()
            }
        }
    }
}

struct CreateCapExModal_Previews: PreviewProvider {
    static var previews: some View {
        CreateCapExModal()
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
