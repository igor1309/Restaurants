//
//  OpExSampleRow.swift
//  Restaurants
//
//  Created by Igor Malyarov on 09.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct OpExSampleRow: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    var opEx: OpExItem
    @State private var showDetail = false
    
    var body: some View {
        ListRow2a(title: opEx.name,
                  subtitle: opEx.type.id,
                  extra: opEx.description,
                  detail: userData.restaurant.currency.idd + opEx.amount.formattedGrouped)
            .contentShape(Rectangle())
            .onTapGesture { self.showDetail = true }
            .sheet(isPresented: $showDetail) {
                OpExDetail(opEx: self.opEx, isNew: true)
                    .environmentObject(self.userData)
        }
    }
}

struct OpExSampleRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List(0..<5) {_ in
                OpExSampleRow(opEx: sampleOpex.opexes[0])
            }
        }
        .environment(\.colorScheme, .dark)
        .environmentObject(UserData())
    }
}
