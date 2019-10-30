//
//  CreateRestaurantModal.swift
//  Restaurants
//
//  Created by Igor Malyarov on 10.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct CreateRestaurantModal: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject private var userData: UserData
    
    @State private var draft = Restaurant()
    @State private var isNameUsed = false
    
    var body: some View {
        NavigationView {
            Form {
                RestaurantEditor(draft: $draft)
            }
            .navigationBarTitle(draft.name.isEmpty ? "New Restaurant" : draft.name)
                
            .navigationBarItems(
                leading: LeadingButtonSFSymbol("xmark") {
                    self.presentation.wrappedValue.dismiss()
                }
                .foregroundColor(.systemRed),
                
                trailing: TrailingButtonSFSymbol("checkmark") {
                    self.saveAndDismiss()
                }
                .disabled(draft.name.isEmpty))
                
            .alert(isPresented: $isNameUsed) {
                Alert(title: Text("Duplicate name"),
                      message: Text("Name '\(draft.name)' is already taken, plese enter a different one."),
                      dismissButton: .default(Text("Ok")) {
                        self.isNameUsed = false
                    })}
        }
    }
    
    private func saveAndDismiss() {
        if draft.name.isNotEmpty {
            let generator = UINotificationFeedbackGenerator()
            if userData.business.isNameUsed(draft) {
                isNameUsed = true
                generator.notificationOccurred(.error)
            } else {
                userData.business.add(draft)
                generator.notificationOccurred(.success)
                presentation.wrappedValue.dismiss()
            }
        }
    }
}

struct CreateRestaurantModal_Previews: PreviewProvider {
    static var previews: some View {
        CreateRestaurantModal()
            .environment(\.sizeCategory, .extraLarge)
            .preferredColorScheme(.dark)
            .environmentObject(UserData())
    }
}
