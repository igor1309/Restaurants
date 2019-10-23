//
//  ProfitAndLossStatement.swift
//
//  Created by Igor Malyarov on 03.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

let myColor: Color = .orange

import SwiftUI

struct ProfitLossLines: View {
    @EnvironmentObject private var userData: UserData
    var restaurant: Restaurant { userData.restaurant }
    
    let dividerOpacity = 1.0
    
    var currency: Currency { userData.restaurant.currency }
    
    var revenue: Double { restaurant.sales.revenuePerMonth }
    var foodcost: Double { restaurant.sales.foodcostPerMonth }
    var salary: Double { restaurant.salaryPerMonth }
    var salaryKitchen: Double { restaurant.salaryKitchenPerMonth }
    var salaryExKitchen: Double { restaurant.salaryExKitchenPerMonth }
    var opEx: Double { restaurant.opExPerMonth }
    var opExForPandL: Double { restaurant.opExPerMonth - restaurant.salaryKitchenPerMonth - restaurant.occupancyCostsPerMonth }
    var occupancyCosts: Double { restaurant.occupancyCostsPerMonth }
    var depreciation: Double { restaurant.depreciationPerMonth } //  Depreciation and Amortization
    var taxRate: Double { restaurant.taxRate }
    
    var grossProfit: Double { restaurant.grossProfitPerMonth }
    var primeCost: Double { restaurant.primeCostPerMonth }
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
                        
                        PandLRow(title: "Foodcost",
                                 subtitle: "Food and beverages cost (GOGS)",
                                 detail: currency.idd + foodcost.formattedGrouped,
                                 subdetail: (foodcost / revenue).formattedPercentageWithDecimals,
                                 highlight: true)
                        
                        PandLRow(title: "Salary Kitchen",
                                 subtitle: "(Production cost)",
                                 
                                 detail: currency.idd + salaryKitchen.formattedGrouped,
                                 subdetail: (salaryKitchen / revenue).formattedPercentageWithDecimals)
                    }
                    
                    Group {
                        Divider().opacity(dividerOpacity)
                        
                        PandLRow(title: "Gross Profit",
                                 subtitle: "Gross Margin",
                                 detail: currency.idd + grossProfit.formattedGrouped,
                                 subdetail: (grossProfit / revenue).formattedPercentageWithDecimals)
                        
                        //                        Divider().opacity(dividerOpacity)
                        
                        PandLRow(title: "Operating Expenses",
                                 subtitle: "Salary minus Kitchen and Occupancy Costs",
                                 detail: currency.idd + opExForPandL.formattedGrouped,
                                 subdetail: (opExForPandL / revenue).formattedPercentageWithDecimals)
                        
                        //  https://pos.toasttab.com/blog/restaurant-profit-and-loss-statement
                        PandLRow(title: "Occupancy Costs",
                                 subtitle: "Fixed overhead (rent, etc.)",
                                 detail: currency.idd + occupancyCosts.formattedGrouped,
                                 subdetail: (occupancyCosts / revenue).formattedPercentageWithDecimals)
                    }
                    
                    Group {
                        
                        PandLRow(title: "Depreciation and Amortization",
                                 subtitle: "Including items with 1 year lifetime",
                                 detail: currency.idd + depreciation.formattedGrouped,
                                 subdetail: (depreciation / revenue).formattedPercentageWithDecimals)
                        
                        Divider().opacity(dividerOpacity)
                        
                        PandLRow(title: "EBIT",
                                 subtitle: "Operating Margin",
                                 detail: currency.idd + ebit.formattedGrouped,
                                 subdetail: (ebit / revenue).formattedPercentageWithDecimals,
                                 highlight: true)
                        
                        PandLRow(title: "Tax",
                                 subtitle: "All Corporate Income Taxes",
                                 detail: currency.idd + tax.formattedGrouped,
                                 subdetail: (tax / revenue).formattedPercentageWithDecimals)
                        
                        Divider().opacity(dividerOpacity)
                        
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

struct ProfitAndLossStatement: View {
    var body: some View {
        Card(title: "P&L",
             subtitle: "Profit and Loss Statement, monthly",
             trunk: ProfitLossLines(),
             borderColor: .gray,
             cornerRadius: 8)
    }
}

#if DEBUG
struct ProfitAndLossStatement_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProfitLossLines()
                .padding()
            
            ForEach([ /* "iPhone SE", "iPhone XS Max", */ "iPhone XS"], id: \.self) { deviceName in
                ProfitAndLossStatement()
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
