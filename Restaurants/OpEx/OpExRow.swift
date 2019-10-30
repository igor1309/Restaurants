//
//  OpExRow.swift
//
//  Created by Igor Malyarov on 31.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct OpExRow : View {
    @EnvironmentObject var userData: UserData
    var opEx: OpExItem
    @State private var showAlert = false
    @State private var showModal = false
    @State private var modal: ModalType = .detail

    var body: some View {
        ListRow2(title: opEx.name,
                 subtitle: opEx.description,
                 detail: userData.restaurant.currency.idd + opEx.amount.formattedGrouped)
            .contentShape(Rectangle())
            .onTapGesture { self.showModal = true }
            .sheet(isPresented: $showModal) {
                OpExDetail(opEx: self.opEx, isNew: false)
                    .environmentObject(self.userData) }
            .contextMenu {
                Button(action: {
                    self.modal = .detail
                    self.showModal = true
                }) {
                    HStack {
                        Text("Show/Edit \("OpEx")")
                        Image(systemName: "aspectratio")
                    }
                }
                Button(action: {
                    self.duplicate(self.opEx)
                }) {
                    HStack {
                        Text("Duplicate \("OpEx")")
                        Image(systemName: "plus.square.on.square")
                    }
                }
                Button(action: {
                    self.showAlert = true
                }) {
                    HStack {
                        Text("Delete \("OpEx")")
                        Image(systemName: "trash.circle")
                    }
                }
                .actionSheet(isPresented: $showAlert) {
                    ActionSheet(title: Text("Delete this \("OpEx?")".uppercased()),
                                message: Text("You can't undo this action."),
                                buttons: [
                                    .cancel(),
                                    .destructive(Text("Yes, delete it")) { self.delete() } ])}}
    }
    
    func duplicate(_ opEx: OpExItem) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        withAnimation {
            userData.restaurant.opex.add(opEx)
        }
    }
    
    func delete() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        
        withAnimation {
            if userData.restaurant.opex.delete(opEx) {
                generator.impactOccurred()
            }
        }
    }
}

#if DEBUG
struct OpExRow_Previews : PreviewProvider {
    static let userData = UserData()
    
    static var previews: some View {
        NavigationView {
            List {
                OpExRow(opEx: userData.restaurant.opex.opexes[0])
                
                OpExRow(opEx: userData.restaurant.opex.opexes[0])
                    .environment(\.sizeCategory, .extraExtraLarge)
            }
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
        }
    }
}
#endif
