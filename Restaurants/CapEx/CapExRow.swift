//
//  CapExRow.swift
//
//  Created by Igor Malyarov on 31.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CapExRow : View {
    @EnvironmentObject var userData: UserData
    var currency: Currency { userData.restaurant.currency }
    var capEx: CapExItem
    @State private var showAlert = false
    @State private var showModal = false
    @State private var modal: ModalType = .detail
    
    var body: some View {
        ListRow2(title: capEx.name,
                 subtitle: capEx.description,
                 extra: "Depreciation: \(capEx.lifetime) year\(capEx.lifetime > 1 ? "s" : ""): \(currency.idd) \(capEx.depreciationPerMonth.formattedGrouped) per month",
            detail: currency.idd + capEx.amount.formattedGrouped)
            .contentShape(Rectangle())
            .onTapGesture {
                self.modal = .detail
                self.showModal = true }
            .sheet(isPresented: $showModal) {
                CapExDetail(capEx: self.capEx, isNew: false)
                    .environmentObject(self.userData) }
            .contextMenu {
                Button(action: {
                    self.modal = .detail
                    self.showModal = true
                }) {
                    HStack {
                        Text("Show/Edit \("CAPEX")")
                        Image(systemName: "aspectratio")
                    }
                }
                Button(action: {
                    self.duplicate(self.capEx)
                }) {
                    HStack {
                        Text("Duplicate \("CAPEX")")
                        Image(systemName: "plus.square.on.square")
                    }
                }
                Button(action: {
                    self.showAlert = true
                }) {
                    HStack {
                        Text("Delete \("CAPEX")")
                        Image(systemName: "trash.circle")
                    }
                }
                .actionSheet(isPresented: $showAlert) {
                    ActionSheet(title: Text("Delete this \("CAPEX?")".uppercased()),
                                message: Text("You can't undo this action."),
                                buttons: [
                                    .cancel(),
                                    .destructive(Text("Yes, delete it")) { self.delete() } ])}}
    }
    
    func duplicate(_ capEx: CapExItem) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        withAnimation {
            userData.restaurant.capex.add(capEx)
        }
    }
    
    func delete() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        
        withAnimation {
            if userData.restaurant.capex.delete(capEx) {
                generator.impactOccurred()
            }
        }
    }
}

#if DEBUG
struct CapExRow_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                CapExRow(capEx: sampleCapex.capexes[0])
                CapExRow(capEx: sampleCapex.capexes[0])                    .environment(\.sizeCategory, .extraExtraLarge)
            }
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
        }
    }
}
#endif
