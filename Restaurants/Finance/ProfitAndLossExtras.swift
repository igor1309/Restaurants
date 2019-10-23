//
//  ProfitAndLossExtras.swift
//  Restaurants
//
//  Created by Igor Malyarov on 16.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ProfitAndLossExtrasLines: View {
    @EnvironmentObject private var userData: UserData
    var restaurant: Restaurant { userData.restaurant }
    var currency: Currency { userData.restaurant.currency }
    
    var revenue: Double { restaurant.sales.revenuePerMonth }
    var foodcost: Double { restaurant.sales.foodcostPerMonth }
    var salary: Double { restaurant.salaryPerMonth }
    var depreciation: Double { restaurant.depreciationPerMonth } //  Depreciation and Amortization
    var ebitda: Double { restaurant.ebitdaPerMonth }
    var profit: Double { restaurant.profitPerMonth }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            if revenue > 0 {
                Group {
                    PandLRow(title: "Prime Cost",
                             subtitle: "Foodcost + Salary",
                             detail: currency.idd + (foodcost + salary).formattedGrouped,
                             subdetail: ((foodcost + salary) / revenue).formattedPercentageWithDecimals,
                             highlight: true)
                    
                    
                    PandLRow(title: "EBITDA",
                             subtitle: "",
                             detail: currency.idd + ebitda.formattedGrouped,
                             subdetail: (ebitda / revenue).formattedPercentageWithDecimals)
                }
            } else {
                Text("No Data Yet")
            }
        }
    }
}

struct ProfitAndLossExtras: View {
    var body: some View {
        Card(title: "P&L Ratios",
             subtitle: "…",
             trunk: ProfitAndLossExtrasLines(),
             borderColor: .gray,
             cornerRadius: 8)
    }
}

#if DEBUG
struct ProfitAndLossExtras_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfitAndLossExtras()
        }
        .environment(\.sizeCategory, .extraLarge)
        .preferredColorScheme(.dark)
        .environmentObject(UserData())
    }
}
#endif
