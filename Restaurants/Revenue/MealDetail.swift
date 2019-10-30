//
//  MealDetail.swift
//
//  Created by Igor Malyarov on 28.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct MealDetail: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    
    var meal: Meal
    var isNew: Bool
    
    @State private var draft: Meal
    @State private var isNameUsed = false
    @State private var showActionSheet = false
    
    init(meal: Meal, isNew: Bool) {
        self.meal = meal
        self._draft = State(initialValue: meal)
        self.isNew = isNew
    }
    
    var body: some View {
        NavigationView {
            Form {
                MealEditor(draft: $draft, isNameUsed: $isNameUsed)

                SectionDeleteThis(item: "Revenue Stream", action: deleteAndDismiss)
            }
            .navigationBarTitle(Text(draft.name.isEmpty ? "NONAME" : draft.name))
                
            .navigationBarItems(
                trailing: TrailingButtonSFSymbol("checkmark") {
                    self.saveAndDismiss()
                }
                .disabled(draft.name.isEmpty))
        }
    }
    
    private func saveAndDismiss() {
        if draft.name.isEmpty { return }
        
        let generator = UINotificationFeedbackGenerator()
        
        //  make sure name isn't used twice
        if userData.restaurant.sales.isNameUsed(draft) {
            isNameUsed = true
            generator.notificationOccurred(.error)
            print("NAME IS USED")
            return
        }
        
        if isNew {
            generator.notificationOccurred(.success)
            userData.restaurant.sales.add(draft)
            self.presentation.wrappedValue.dismiss()
            print("NEW ELEMENT ADDED")
            return
        }
        
        if userData.restaurant.sales.update(meal, with: draft) {
            generator.notificationOccurred(.success)
            self.presentation.wrappedValue.dismiss()
            print("ELEMENT UPDATED SUCCESSFULLY")
        } else {
            generator.notificationOccurred(.error)
            print("ERROR UPDATING ELEMENT")
        }
    }
    
    private func deleteAndDismiss() {
        let generator = UINotificationFeedbackGenerator()
        
        if userData.restaurant.sales.delete(meal) {
            generator.notificationOccurred(.success)
            self.presentation.wrappedValue.dismiss()
        } else {
            generator.notificationOccurred(.error)
        }
    }
}

#if DEBUG
struct MealDetail_Previews: PreviewProvider {
    static var previews: some View {
        MealDetail(meal: sampleSales.meals[0], isNew: false)
            .environment(\.colorScheme, .dark)
            .environmentObject(UserData())
    }
}
#endif
