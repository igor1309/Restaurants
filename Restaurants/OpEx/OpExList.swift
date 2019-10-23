//
//  OpExList.swift
//
//  Created by Igor Malyarov on 31.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct OpExList: View {
    @EnvironmentObject private var userData: UserData
    var currency: Currency { userData.restaurant.currency }
    
    @State private var showAction = false
    @State private var showModal = false
    @State private var modal: ModalType = .new
    
    var body: some View {
        List {
            Section(header: SuperTotalRow(title: "OpEx, per month",
                                          detail: currency.idd + self.userData.restaurant.opExPerMonth.formattedGrouped,
                                          color: .systemTeal)) { EmptyView() }
            
            ForEach(userData.restaurant.opex.types, id: \.self) { type in
                
                //                if !self.userData.restaurant.opex.opexes.filter({ $0.type == type }).isEmpty {
                
                Section(header:
                    BasicRow(title: type.id.uppercased(),
                             detail: self.currency.idd + self.userData.restaurant.opex.opexes
                                .filter({ $0.type == type })
                                .reduce(0, { $0 + $1.amount }).formattedGrouped,
                             color: .systemTeal)) {
                                OpExItems(type: type)
                }
                //                }
            }
        }
        .listStyle(GroupedListStyle())
            
        .navigationBarTitle(Text("OpExes"))
            
        .navigationBarItems(
            trailing: HStack {
                TrailingButtonSFSymbol("plus.square") {
                    self.modal = .options
                    self.showModal = true
                }
                .sheet(isPresented: self.$showModal) {
                    if self.modal == .payroll {
                        Text("Create Payroll\nTO BE DONE\n(Needs some code integration)")
                    }
                    if self.modal == .new {
                        CreateOpExModal()
                            .environmentObject(self.userData)
                    }
                    if self.modal == .options {
                        OpExSampleList()
                            .environmentObject(self.userData) }}
                
                TrailingButtonSFSymbol("plus") {
                    self.modal = .new
                    self.showAction = true
                }
                .actionSheet(isPresented: $showAction) {
                    ActionSheet(
                        title: Text("Create Opex"),
                        message: Text("Select the OpEx type you want to create"),
                        buttons: [
                            .cancel(),
                            .default(Text("Create Payroll")) {
                                self.modal = .payroll
                                self.showModal = true },
                            .default(Text("Create other OpEx")) {
                                self.modal = .new
                                self.showModal = true } ])}})
    }
}

#if DEBUG
struct OpExList_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView { OpExList() }
            .environmentObject(UserData())
            .preferredColorScheme(.dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
#endif
