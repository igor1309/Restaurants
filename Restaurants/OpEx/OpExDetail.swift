//
//  OpExDetail.swift
//
//  Created by Igor Malyarov on 31.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct OpExDetail: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    
    var opEx: OpExItem
    var isNew: Bool
    
    @State private var draft: OpExItem
    @State private var isNameUsed = false
    @State private var showActionSheet = false
    
    init(opEx: OpExItem, isNew: Bool) {
        self.opEx = opEx
        self._draft = State(initialValue: opEx)
        self.isNew = isNew
    }
    
    var body: some View {
        NavigationView {
            Form {
                OpExEditor(draft: $draft, isNameUsed: $isNameUsed)
                
                SectionDeleteThis(item: "OpEx", action: deleteAndDismiss)
            }
            .navigationBarTitle(draft.name.isEmpty ? "NONAME" : draft.name)
                
            .navigationBarItems(
                trailing: TrailingButtonSFSymbol("checkmark") { self.saveAndDismiss() }
                    .disabled(draft.name.isEmpty))
        }
    }
    
    private func saveAndDismiss() {
        if draft.name.isEmpty { return }
        
        let generator = UINotificationFeedbackGenerator()
        
        //  make sure name isn't used twice
        if userData.restaurant.opex.isNameUsed(draft) {
            isNameUsed = true
            generator.notificationOccurred(.error)
            print("NAME IS USED")
            return
        }
        
        if isNew {
            generator.notificationOccurred(.success)
            userData.restaurant.opex.add(draft)
            self.presentation.wrappedValue.dismiss()
            print("NEW ELEMENT ADDED")
            return
        }
        
        if userData.restaurant.opex.update(opEx, with: draft) {
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
        
        if userData.restaurant.opex.delete(opEx) {
            generator.notificationOccurred(.success)
            self.presentation.wrappedValue.dismiss()
        } else {
            generator.notificationOccurred(.error)
        }
    }
}

#if DEBUG
struct OpExDetail_Previews: PreviewProvider {
    static var previews: some View {
        OpExDetail(opEx: OpExItem(), isNew: false)
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
    }
}
#endif
