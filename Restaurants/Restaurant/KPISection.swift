//
//  KPISection.swift
//  Restaurants
//
//  Created by Igor Malyarov on 24.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct KPISection: View {
    //    @EnvironmentObject private var userData: UserData
    //
    //    var currency: Currency { userData.restaurant.currency }
    //    var capEx: Int { Int(userData.restaurant.capEx) }
    //    var depreciation: Int { Int(userData.restaurant.depreciationPerMonth) }
    
    var body: some View {
        Section(header: Text("KPI".uppercased())) {
            
            NavigationLink(destination: KPIList()) {
                
                RestaurantFinanceOneRow(title: "KPIs & Milestones",
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
