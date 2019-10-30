//
//  EditRestaurant.swift
//
//  Created by Igor Malyarov on 26.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct EditRestaurant: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    
    var restaurant: Restaurant
    var isNew: Bool
    
    @State private var draft: Restaurant
    @State private var isNameUsed = false
    @State private var showActionSheet = false
    
    init(restaurant: Restaurant, isNew: Bool) {
        self.restaurant = restaurant
        self._draft = State(initialValue: restaurant)
        self.isNew = isNew
    }
    
    var body: some View {
        NavigationView {
            Form {
                RestaurantEditor(draft: $draft)
                
                Spacer()
                
                Section(header: Text("Don't".uppercased())) {
                    Button("Delete Restaurant") {
                        self.showActionSheet = true
                    }
                    .foregroundColor(.systemRed)
                    .actionSheet(isPresented: $showActionSheet) {
                        ActionSheet(
                            title: Text("Delete Restaurant".uppercased()),
                            message: Text("Are you 100% sure you want to delete this Restaurant?\nYou can't undo this action."),
                            buttons: [
                                .cancel(),
                                .destructive(Text("Yes, delete it")) {
                                    self.delete()
                                }
                            ]
                        )
                    }
                }
            }
                
            .navigationBarTitle(Text(draft.name.isEmpty ? "NONAME" : draft.name))
                
            .navigationBarItems(
                trailing: TrailingButtonSFSymbol("checkmark") {
                    self.saveAndDismiss()
                }
                .disabled(draft.name.isEmpty)
                .alert(isPresented: $isNameUsed) {
                    Alert(title: Text("Duplicate name"),
                          message: Text("Name '\(draft.name)' is taken, please enter a different one."),
                          dismissButton: .default(Text("Ok")))})
        }
    }
    
    private func saveAndDismiss() {
        if draft.name.isEmpty { return }
        
        let generator = UINotificationFeedbackGenerator()
        
        //  make sure name isn't used twice
        if userData.business.isNameUsed(draft) {
            isNameUsed = true
            generator.notificationOccurred(.error)
            print("NAME IS USED")
            return
        }
        
        if isNew {
            generator.notificationOccurred(.success)
            userData.business.add(draft)
            self.presentation.wrappedValue.dismiss()
            print("NEW ELEMENT ADDED")
            return
        }
        
        if userData.business.update(restaurant, with: draft) {
            generator.notificationOccurred(.success)
            self.presentation.wrappedValue.dismiss()
            print("ELEMENT UPDATED SUCCESSFULLY")
        } else {
            generator.notificationOccurred(.error)
            print("ERROR UPDATING ELEMENT")
        }
    }
    
    private func delete() {
        let generator = UINotificationFeedbackGenerator()
        
        if self.userData.deleteRestaurant(userData.restaurant) {
            print("restaurant deleted")
            self.userData.restaurant = self.userData.business.restaurants[0]
            generator.notificationOccurred(.success)
        } else {
            print("restaurant WAS NOT deleted")
            generator.notificationOccurred(.error)
        }
    }
}

#if DEBUG
struct EditRestaurant_Previews: PreviewProvider {
    static var previews: some View {
        EditRestaurant(restaurant: UserData().business.restaurants[0], isNew: false)
            .environmentObject(UserData())
            .preferredColorScheme(.dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
#endif
