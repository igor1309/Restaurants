//
//  FinancialSummary.swift
//  Restaurants
//
//  Created by Igor Malyarov on 13.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct FinancialSummary: View {
    @EnvironmentObject private var userData: UserData
    
    var currency: Currency { userData.restaurant.currency }
    var revenue: Int { Int(userData.restaurant.sales.revenuePerMonth) }
    var noOfRevenueStreams: Int { Int(userData.restaurant.sales.noOfRevenueStreams) }
    var noOfActiveRevenueStreams: Int { Int(userData.restaurant.sales.noOfActiveRevenueStreams) }
    var opEx: Int { Int(userData.restaurant.opExPerMonth) }
    
    var body: some View {
        Section(header: Text("Operations".uppercased()),
                footer: Text("Revenue and Expenses per month.")) {
                    NavigationLink(destination: MealList()) {
                        RowIconAmount(title: "Revenue",
                                      subtitle: "\(noOfActiveRevenueStreams) active revenue streams (\(noOfRevenueStreams) total)",
                            currency: currency,
                            amount: Int(revenue),
                            color: .systemGreen,
                            icon: "text.badge.plus") //increase.indent
                    }
                    
                    NavigationLink(destination: OpExList()) {
                        RowIconAmount(title: "OpEx (TBD: ex Payroll)",
                                      currency: currency,
                                      amount: opEx,
                                      color: .systemTeal,
                                      icon: "text.badge.minus")
                    }
                    
                    RowIconAmount(title: "TO BE DONE Payroll",
                                  currency: Currency.none,
                                  amount: -1, color: .systemTeal,
                                  icon: "person")
                    
                    RowIconAmount(title: "TBD: OpEx + Payroll",
                                  currency: currency,
                                  amount: opEx,
                                  color: .systemTeal,
                                  icon: "text.badge.minus")
                        .padding(.trailing)
        }
    }
}

#if DEBUG
struct FinancialSummary_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                FinancialSummary()
            }
        }
        .preferredColorScheme(.dark)
        .environment(\.sizeCategory, .extraLarge)
        .environmentObject(UserData())
    }
}
#endif
