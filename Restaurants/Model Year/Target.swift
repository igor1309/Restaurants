//
//  Target.swift
//  Restaurants
//
//  Created by Igor Malyarov on 23.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct Target: View {
    @EnvironmentObject private var userData: UserData
    var restaurant: Restaurant { userData.restaurant }
    var currency: Currency { userData.restaurant.currency }
    
    var unchangedExpenses: Double { restaurant.sales.foodcostPerMonth + restaurant.opExPerMonth + restaurant.depreciationPerMonth }
    
    var body: some View {
        VStack {
            PandLRow(title: "Revenue",
                     subtitle: "per month",
                     detail: currency.idd + (restaurant.sales.revenuePerMonth * 12).formattedGrouped,
                     subdetail: currency.idd + restaurant.sales.revenuePerMonth.formattedGrouped)
            
            PandLRow(title: "Foodcost, OpEx, D&A, year",
                     subtitle: "per month",
                     detail: currency.idd + (unchangedExpenses * 12).formattedGrouped,
                     subdetail: currency.idd + unchangedExpenses.formattedGrouped)
            
            PandLRow(title: "Profit",
                     subtitle: "per month",
                     detail: currency.idd + (restaurant.profitPerMonth * 12).formattedGrouped,
                     subdetail: currency.idd + restaurant.profitPerMonth.formattedGrouped)
            
            PandLRow(title: "Cash Flow Estimate",
                     subtitle: "per month",
                     detail: currency.idd + (restaurant.cashFlowEstimatePerMonth * 12).formattedGrouped,
                     subdetail: currency.idd + restaurant.cashFlowEstimatePerMonth.formattedGrouped)
        }
    }
}

struct Target_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VStack {
                Target().padding()
                Spacer()
            }
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
