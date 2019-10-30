//
//  CapExDetail.swift
//
//  Created by Igor Malyarov on 31.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct CapExDetail: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    
    var capEx: CapExItem
    var isNew: Bool
    
    @State private var draft: CapExItem
    @State private var isNameUsed = false
    @State private var showActionSheet = false
    
    init(capEx: CapExItem, isNew: Bool) {
        self.capEx = capEx
        self._draft = State(initialValue: capEx)
        self.isNew = isNew
    }
    
    var body: some View {
        NavigationView {
            Form {
                CapExEditor(draft: $draft, isNameUsed: $isNameUsed)
                
                SectionDeleteThis(item: "CAPEX", action: deleteAndDismiss)
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
        if userData.restaurant.capex.isNameUsed(draft) {
            isNameUsed = true
            generator.notificationOccurred(.error)
            print("NAME IS USED")
            return
        }
        
        if isNew {
            generator.notificationOccurred(.success)
            userData.restaurant.capex.add(draft)
            self.presentation.wrappedValue.dismiss()
            print("NEW ELEMENT ADDED")
            return
        }
        
        if userData.restaurant.capex.update(capEx, with: draft) {
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
        
        if userData.restaurant.capex.delete(capEx) {
            generator.notificationOccurred(.success)
            self.presentation.wrappedValue.dismiss()
        } else {
            generator.notificationOccurred(.error)
        }
    }
}

#if DEBUG
struct CapExDetail_Previews: PreviewProvider {
    static var previews: some View {
        CapExDetail(capEx: CapExItem(), isNew: false)
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
        
    }
}
#endif
