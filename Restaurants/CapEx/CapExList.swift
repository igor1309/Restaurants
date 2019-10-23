//
//  CapExList.swift
//
//  Created by Igor Malyarov on 31.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CapExList: View {
    @EnvironmentObject private var userData: UserData
    @State private var showModal = false
    @State private var modal: ModalType = .options
    var currency: Currency { userData.restaurant.currency }
    
    var body: some View {
        List {
            
            Section(header:
                VStack {
                    SuperTotalRow(title: "Investment, total",
                                  detail: currency.idd + self.userData.restaurant.capEx.formattedGrouped,
                                  color: .systemYellow)
                    BasicRow(title: "Depreciation, per month",
                             detail: currency.idd + self.userData.restaurant.depreciationPerMonth.formattedGrouped,
                             color: .secondary)
                        .font(.caption)
            }) {
                EmptyView()
            }
            
            ForEach(userData.restaurant.capex.lifetimes, id: \.self) { lifetime in
                
                Section(header:
                    BasicRow(title: "Lifetime: \(lifetime.formattedGrouped)".uppercased(),
                             detail: self.currency.idd + self.userData.restaurant.capex.capexes
                                .filter({ $0.lifetime == lifetime })
                                .reduce(0, { $0 + $1.amount }).formattedGrouped,
                             color: .systemYellow)
                ) {
                    
                    ForEach(self.userData.restaurant.capex.capexes
                        .filter({ $0.lifetime == lifetime }), id: \.self) { capEx in
                            
                            CapExRow(capEx: capEx)
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
            
        .navigationBarTitle(Text("CapEx"))
            
        .navigationBarItems(trailing: HStack {
            TrailingButtonSFSymbol("plus.square") {
                self.modal = .options
                self.showModal = true
            }
            TrailingButtonSFSymbol("plus") {
                self.modal = .new
                self.showModal = true }})
            
            .sheet(isPresented: self.$showModal) {
                if self.modal == .new {
                    CreateCapExModal()
                        .environmentObject(self.userData)
                }
                
                if self.modal == .options {
                    CapExSampleList()
                        .environmentObject(self.userData) }}
    }
}

#if DEBUG
struct CapExList_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView { CapExList() }
                .environment(\.sizeCategory, .extraExtraLarge)
            
            NavigationView { CapExList() }
        }
        .preferredColorScheme(.dark)
        .environmentObject(UserData())
    }
}
#endif
