//
//  ModelCard.swift
//  Restaurants
//
//  Created by Igor Malyarov on 24.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ModelCard: View {
    @EnvironmentObject private var userData: UserData
    var modelYear: ModelYear
    
    var restaurant: Restaurant { userData.restaurant }
    var currency: Currency { userData.restaurant.currency }
    
    var discountedRevenue: Double { restaurant.sales.revenuePerMonth * (1 - modelYear.discount) }
    var unchangedExpenses: Double { restaurant.sales.foodcostPerMonth + restaurant.opExPerMonth + restaurant.depreciationPerMonth }
    var depreciation: Double { restaurant.depreciationPerMonth }
    
    var discountedEBIT: Double { discountedRevenue - unchangedExpenses }
    var discountedTax: Double {
        if discountedEBIT > 0 {
            return discountedEBIT * restaurant.taxRate
        } else {
            return 0
        }
    }
    var discountedProfit: Double { discountedEBIT - discountedTax }
    
    var investment: Double { restaurant.investment }
    var cashFlowEstimate: Double { discountedProfit + depreciation }
    
    var body: some View {
        VStack {
            PandLRow(title: "Discounted Revenue",
                     subtitle: "per Month",
                     detail: currency.idd + (discountedRevenue * 12).formattedGrouped,
                     subdetail: currency.idd + discountedRevenue.formattedGrouped,
                     highlight: false)
            
            PandLRow(title: "Profit/Loss",
                     subtitle: "per Month",
                     detail: currency.idd + (discountedProfit * 12).formattedGrouped,
                     subdetail: currency.idd + discountedProfit.formattedGrouped,
                     highlight: false)
            
            PandLRow(title: "Cash Flow Est.",
                     subtitle: "per Month",
                     detail: currency.idd + (cashFlowEstimate * 12).formattedGrouped,
                     subdetail: currency.idd + cashFlowEstimate.formattedGrouped,
                     highlight: false)
        }
    }
}

struct ModelCard_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VStack {
                ModelCard(modelYear: ModelYear(id: 1, discount: 0.20)).padding()
                Spacer()
            }
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
