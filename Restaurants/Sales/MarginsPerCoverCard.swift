//
//  MarginsPerCoverCard.swift
//  CardModifier
//
//  Created by Igor Malyarov on 13.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct MarginsPerCoverCard: View {
    @EnvironmentObject var userData: UserData
    var currency: Currency { userData.restaurant.currency }
    
    var price: Double = 25.00
    var gp: Double = 19.00
    var gm: Double = 15.35
    var op: Double = 9.19
    var ptp: Double = 7.46
    
    var foodcost: Double = 15
    var salary: Double = 6
    var fixedCosts: Double = 3
    
    var bars: [CGFloat] {
        [CGFloat(price),
         CGFloat(gp),
         CGFloat(gm),
         CGFloat(op),
         CGFloat(ptp)
        ]
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Group {
                Text("Margins")
                    .font(.subheadline)
                    .fontWeight(.bold)
                
                SalesRow(title: "Price",
                         detail: currency.idd + price.formattedGroupedWithDecimals,
                         subdetail: "")
                
                SalesRow(title: "GP & Gross Margin",
                         detail: currency.idd + gp.formattedGroupedWithDecimals,
                         subdetail: (gp/price).formattedPercentage)
                
                SalesRow(title: "Operating Profit",
                         detail: currency.idd + op.formattedGroupedWithDecimals,
                         subdetail: (op/price).formattedPercentage)
                
                SalesRow(title: "Pre-tax Profit",
                         detail: currency.idd + ptp.formattedGroupedWithDecimals,
                         subdetail: (ptp/price).formattedPercentage)
            }
            
            Group {
                Text("Costs")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .padding(.top)
                
                SalesRow(title: "Foodcost",
                         detail: currency.idd + foodcost.formattedGroupedWithDecimals,
                         subdetail: (foodcost / price).formattedPercentage)
                
                SalesRow(title: "Salary NOT YET",
                         detail: currency.idd + salary.formattedGroupedWithDecimals,
                         subdetail: (salary / price).formattedPercentage)
                
                SalesRow(title: "Fixed Costs NOT YET",
                         detail: currency.idd + fixedCosts.formattedGroupedWithDecimals,
                         subdetail: (fixedCosts / price).formattedPercentage)
                
                SalesRow(title: "Foodcost + Salary NOT YET",
                         detail: currency.idd + (foodcost + salary).formattedGroupedWithDecimals,
                         subdetail: ((foodcost + salary) / price).formattedPercentage)
                
                SalesRow(title: "Salary + Fixed Costs NOT YET",
                         detail: currency.idd + (salary + fixedCosts).formattedGroupedWithDecimals,
                         subdetail: ((salary + fixedCosts) / price).formattedPercentage)
            }
        }
    }
}

#if DEBUG
struct MarginsPerCoverCard_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MarginsPerCoverCard()
                .padding()
        }
        .environment(\.sizeCategory, .extraLarge)
        .preferredColorScheme(.dark)
        .environmentObject(UserData())
    }
}
#endif
