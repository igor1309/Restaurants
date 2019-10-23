//
//  CapExSampleRow.swift
//  Restaurants
//
//  Created by Igor Malyarov on 09.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CapExSampleRow: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    var currency: Currency { userData.restaurant.currency }
    var capEx: CapExItem
    @State private var showDetail = false
    
    var body: some View {
        ListRow2a(title: capEx.name,
                  subtitle: capEx.description,
                  detail: currency.idd + capEx.amount.formattedGrouped)
            .contentShape(Rectangle())
            .onTapGesture { self.showDetail = true }
            .sheet(isPresented: $showDetail) {
                CapExDetail(capEx: self.capEx, isNew: true)
                    .environmentObject(self.userData) }
    }
}

struct CapExSampleRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List(0..<5) { _ in
                CapExSampleRow(capEx: sampleCapex.capexes[0])
            }
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
        }
    }
}
