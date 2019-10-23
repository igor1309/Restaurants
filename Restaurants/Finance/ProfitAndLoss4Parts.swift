//
//  ProfitAndLoss4Parts.swift
//  Restaurants
//
//  Created by Igor Malyarov on 17.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ProfitAndLoss4PartsLines: View {
    @EnvironmentObject private var userData: UserData
    var restaurant: Restaurant { userData.restaurant }
    
    let dividerOpacity = 1.0
    
    var currency: Currency { userData.restaurant.currency }

    var revenue: Double { restaurant.sales.revenuePerMonth }
    var foodcost: Double { restaurant.sales.foodcostPerMonth }
    var salary: Double { restaurant.salaryPerMonth }
    var opEx: Double { restaurant.opExPerMonth }
    var expenses: Double { opEx - salary + depreciation + tax }
    var occupancyCosts: Double { restaurant.occupancyCostsPerMonth }
    var depreciation: Double { restaurant.depreciationPerMonth } //  Depreciation and Amortization
    var taxRate: Double { restaurant.taxRate }
    
    var ebit: Double { restaurant.ebitPerMonth }
    var ebitda: Double { restaurant.ebitdaPerMonth }
    var tax: Double { restaurant.taxPerMonth }
    var profit: Double { restaurant.profitPerMonth }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            if revenue > 0 {
                Group {
                    PandLRow(title: "Revenue (sales)",
                             subtitle: "All Revenue Streams",
                             detail: currency.idd + revenue.formattedGrouped,
                             highlight: true)
                    
                    Divider()
                    
                    PandLRow(title: "Foodcost",
                             subtitle: "Food and beverages cost (GOGS)",
                             detail: currency.idd + foodcost.formattedGrouped,
                             subdetail: (foodcost / revenue).formattedPercentageWithDecimals,
                             highlight: true)
                    
                    PandLRow(title: "Salary",
                             subtitle: "Payroll Expenses",
                             detail: currency.idd + salary.formattedGrouped,
                             subdetail: (salary / revenue).formattedPercentageWithDecimals)
                    
                    PandLRow(title: "Expenses",
                             subtitle: "Rent, Other OpEx, D&A, Tax",
                             detail: currency.idd + expenses.formattedGrouped,
                             subdetail: (expenses / revenue).formattedPercentageWithDecimals)
                    
                    PandLRow(title: "Net Profit/Loss",
                             subtitle: "",
                             detail: currency.idd + profit.formattedGrouped,
                             subdetail: (profit / revenue).formattedPercentageWithDecimals,
                             highlight: true)
                }
            } else {
                Text("No Revenue Streams Yet")
            }
        }
    }
}

struct ProfitAndLoss4Parts: View {
    var body: some View {
        Card(title: "P&L: 4 Pieces of the Pie",
             subtitle: "Profit and Loss Statement, monthly",
             trunk: ProfitAndLoss4PartsLines(),
             borderColor: .gray,
             cornerRadius: 8)
    }
}

#if DEBUG
struct ProfitAndLoss4Parts_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            //            ProfitAndLoss4PartsLines()
            //                .padding()
            
            ForEach([ /* "iPhone SE", "iPhone XS Max", */ "iPhone XS"], id: \.self) { deviceName in
                ProfitAndLoss4Parts()
                    .previewDevice(PreviewDevice(rawValue: deviceName))
                    .previewDisplayName(deviceName)
            }
        }
        .environment(\.sizeCategory, .extraLarge)
        .preferredColorScheme(.dark)
        .environmentObject(UserData())
    }
}
#endif
