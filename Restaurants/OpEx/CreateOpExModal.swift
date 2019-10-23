//
//  CreateOpExModal.swift
//  Restaurants
//
//  Created by Igor Malyarov on 08.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CreateOpExModal: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject private var userData: UserData
    var currency: Currency { userData.restaurant.currency }
    
    @State private var draft = OpExItem()
    @State private var isNameUsed = false
    
    var body: some View {
        NavigationView {
            Form {
                OpExEditor(draft: $draft, isNameUsed: $isNameUsed)
            }
            .navigationBarTitle(draft.name.isEmpty ? "New OpEx Name" : draft.name)
                
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
            if userData.restaurant.opex.isNameUsed(draft) {
                isNameUsed = true
                generator.notificationOccurred(.error)
            } else {
                userData.restaurant.opex.add(draft)
                generator.notificationOccurred(.success)
                presentation.wrappedValue.dismiss()
            }
        }
    }
}

struct CreateOpExModal_Previews: PreviewProvider {
    static var previews: some View {
        CreateOpExModal()
    }
}
