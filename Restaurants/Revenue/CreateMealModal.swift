//
//  CreateMealModal.swift
//
//  Created by Igor Malyarov on 02.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct CreateMealModal: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject private var userData: UserData
    
    @State private var draft = Meal()
    @State private var isNameUsed = false
    
    var body: some View {
        NavigationView {
            Form {
                MealEditor(draft: $draft, isNameUsed: $isNameUsed)
            }
            .navigationBarTitle(draft.name.isEmpty ? "New Name" : draft.name)
                
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
            if userData.restaurant.sales.isNameUsed(draft) {
                isNameUsed = true
                generator.notificationOccurred(.error)
            } else {
                userData.restaurant.sales.add(draft)
                generator.notificationOccurred(.success)
                presentation.wrappedValue.dismiss()
            }
        }
    }
}

struct CreateMealModal_Previews: PreviewProvider {
    static var previews: some View {
        CreateMealModal()
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
    }
}
