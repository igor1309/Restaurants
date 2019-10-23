//
//  KPISampleList.swift
//  Restaurants
//
//  Created by Igor Malyarov on 09.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct KPISampleList: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Sample".uppercased()),
                        footer: Text("Use this samples to create your KPI.")) {
                            ForEach(sampleKPI.kpis
                                .sorted(by: { $0.dueDate > $1.dueDate }), id: \.self) { kpi in
                                    
                                    KPISampleRow(kpi: kpi)
                            }
                }
            }
            .listStyle(GroupedListStyle())
                
            .navigationBarTitle("Select Sample KPI")
                
            .navigationBarItems(trailing:
                TrailingButtonSFSymbol("checkmark") {
                    self.presentation.wrappedValue.dismiss() })
        }
    }
}

struct KPISampleList_Previews: PreviewProvider {
    static var previews: some View {
        KPISampleList()
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
    }
}
