//
//  InvestmentSection.swift
//  Restaurants
//
//  Created by Igor Malyarov on 24.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct InvestmentSection: View {
    @EnvironmentObject private var userData: UserData
    
    var currency: Currency { userData.restaurant.currency }
    var capEx: Int { Int(userData.restaurant.capEx) }
    var depreciation: Int { Int(userData.restaurant.depreciationPerMonth) }
    
    var body: some View {
        Section(header: Text("Investment & CAPEX".uppercased())) {
            
            NavigationLink(destination: CapExList()) {
                RowIconAmount(title: "CAPEX, total",
                              subtitle: "Monthly Depreciation \(currency.idd) \(depreciation.formattedGrouped)",
                    currency: currency,
                    amount: capEx,
                    color: .systemYellow,
                    icon: "text.badge.checkmark")
            }
            
            RestaurantFinanceRow(title: "TO BE DONE Return of Investment", subtitle: "Estimated return of Investment, years", currency: Currency.none, amount: -1)
        }
    }
}

struct InvestmentSection_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                InvestmentSection()
            }
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
