//
//  KPIDetail.swift
//
//  Created by Igor Malyarov on 31.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct KPIDetail: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    
    var kpi: KPIItem
    var isNew: Bool
    
    @State private var draft: KPIItem
    @State private var isNameUsed = false
    
    init(kpi: KPIItem, isNew: Bool) {
        self.kpi = kpi
        self._draft = State(initialValue: kpi)
        self.isNew = isNew
    }
    var body: some View {
        NavigationView {
            Form {
                KPIEditor(draft: $draft, isNameUsed: $isNameUsed)
                
                SectionDeleteThis(item: "KPI", action: deleteAndDismiss)
            }
            .navigationBarTitle(Text(draft.name.isEmpty ? "KPI or Milestone" : draft.name))
                
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
        if userData.restaurant.kpi.isNameUsed(draft) {
            isNameUsed = true
            generator.notificationOccurred(.error)
            print("NAME IS USED")
            return
        }
        
        if isNew {
            generator.notificationOccurred(.success)
            userData.restaurant.kpi.add(draft)
            self.presentation.wrappedValue.dismiss()
            print("NEW ELEMENT ADDED")
            return
        }
        
        if userData.restaurant.kpi.update(kpi, with: draft) {
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
        
        if userData.restaurant.kpi.delete(kpi) {
            generator.notificationOccurred(.success)
            self.presentation.wrappedValue.dismiss()
        } else {
            generator.notificationOccurred(.error)
        }
    }
}

#if DEBUG
struct KPIDetail_Previews: PreviewProvider {
    static var previews: some View {
        KPIDetail(kpi: KPIItem(), isNew: false)
            .environment(\.colorScheme, .dark)
            .environmentObject(UserData())
    }
}
#endif
