//
//  KPISampleRow.swift
//  Restaurants
//
//  Created by Igor Malyarov on 09.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct KPISampleRow: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    var kpi: KPIItem
    @State private var showDetail = false
    
    var body: some View {
        ListRow2a(title: kpi.name,
                  subtitle: kpi.description,
                  detail: kpi.dueDate.toString())
            .contentShape(Rectangle())
            .onTapGesture { self.showDetail = true }
            .sheet(isPresented: $showDetail) {
                KPIDetail(kpi: self.kpi, isNew: true)
                    .environmentObject(self.userData) }
    }
}

struct KPISampleRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                KPISampleRow(kpi: sampleKPI.kpis[0])
                KPISampleRow(kpi: sampleKPI.kpis[1])
            }
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
    }
}
