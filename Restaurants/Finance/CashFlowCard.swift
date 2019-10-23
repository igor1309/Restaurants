//
//  CashFlowCard.swift
//  Restaurants
//
//  Created by Igor Malyarov on 16.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CashFlowLines: View {
    @EnvironmentObject private var userData: UserData
    var restaurant: Restaurant { userData.restaurant }
    var currency: Currency { userData.restaurant.currency }

    var investment: Double { restaurant.investment }
    var cashFlowEstimate: Double { restaurant.cashFlowEstimatePerMonth }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            if cashFlowEstimate != 0 {
                Group {
                    PandLRow(title: "Investment",
                             subtitle: "CapEx, total",
                             detail: currency.idd + investment.formattedGrouped)
                    
                    PandLRow(title: "Cash Flow Est., per year",
                             subtitle: "Net Profit + D&A, per month",
                             detail: currency.idd + (cashFlowEstimate * 12).formattedGrouped,
                             subdetail: currency.idd + cashFlowEstimate.formattedGrouped)
                    
                    if cashFlowEstimate > 0 {
                        PandLRow(title: "Investment Return in",
                                 subtitle: "",
                                 detail: (investment / cashFlowEstimate).rounded(.up).formattedGrouped + " months")
                    } else {
                        PandLRow(title: "Cash Flow is negative, no Investment return",
                                 subtitle: "",
                                 detail: "")
                            .foregroundColor(Color.systemRed)
                            .lineLimit(3)
                        
                    }
                }
            } else {
                Text("No Data or Profit is zero")
            }
        }
    }
}

struct CashFlowCard: View {
    var body: some View {
        Card(title: "Cash Flow",
             subtitle: "and Investment",
             trunk: CashFlowLines(),
             borderColor: .gray,
             cornerRadius: 8)
    }
}

#if DEBUG
struct CashFlowCard_Previews: PreviewProvider {
    static var previews: some View {
        CashFlowCard()
            .environment(\.sizeCategory, .extraLarge)
            .preferredColorScheme(.dark)
            .environmentObject(UserData())
    }
}
#endif
