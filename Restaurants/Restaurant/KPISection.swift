//
//  KPISection.swift
//  Restaurants
//
//  Created by Igor Malyarov on 24.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct KPISection: View {
    var body: some View {
        Section(header: Text("KPI".uppercased())) {
            
            NavigationLink(destination: KPIList()) {
                RowIconAmount(title: "KPIs & Milestones",
                              currency: .none,
                              amount: -1,
                              color: .systemPurple,
                              icon: "text.badge.star")
            }
        }
    }
}

struct KPISection_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                KPISection()
            }
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
