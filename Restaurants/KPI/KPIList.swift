//
//  KPIList.swift
//
//  Created by Igor Malyarov on 31.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct KPIList: View {
    @EnvironmentObject private var userData: UserData
    @State private var showModal = false
    @State private var modal: ModalType = .options
    
    var body: some View {
        List {
            Section(header: Text("Urgent".uppercased())
                .foregroundColor(.systemRed)) {
                    ForEach(userData.restaurant.kpi.urgent, id: \.self) { kpi in
                        KPIRow(kpi: kpi)
                    }
            }

            Section(header: Text("Soon".uppercased())
                .foregroundColor(.orange)) {
                    ForEach(userData.restaurant.kpi.soon, id: \.self) { kpi in
                        KPIRow(kpi: kpi)
                    }
            }

            Section(header: Text("Have some time".uppercased())) {
                ForEach(userData.restaurant.kpi.haveSomeTime, id: \.self) { kpi in
                    KPIRow(kpi: kpi)
                }
            }
        }
        .listStyle(GroupedListStyle())
            
        .navigationBarTitle(Text("KPIs"))
            
        .navigationBarItems(trailing: HStack {
            TrailingButtonSFSymbol("slider.horizontal.3") {
                self.modal = .settings
                self.showModal = true
            }
            
            TrailingButtonSFSymbol("plus.square") {
                self.modal = .options
                self.showModal = true
            }
            TrailingButtonSFSymbol("plus") {
                self.modal = .new
                self.showModal = true
            }})
            .sheet(isPresented: self.$showModal) {
                if self.modal == .new {
                    CreateKPIModal()
                        .environmentObject(self.userData)
                }
                
                if self.modal == .options {
                    KPISampleList()
                        .environmentObject(self.userData)
                }
                
                if self.modal == .settings {
                    KPIColorSettings()
                        .environmentObject(self.userData)
                }}
    }
}

#if DEBUG
struct KPIList_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                KPIList()
            }
            
            KPIColorSettings()
        }
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
        .environmentObject(UserData())
    }
}
#endif
