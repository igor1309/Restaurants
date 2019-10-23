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
    var capEx: Int { Int(userData.restaurant.capEx) }
    var depreciation: Int { Int(userData.restaurant.depreciationPerMonth) }
    
    var body: some View {
        Group {
            Section(header: Text("Finance".uppercased()),
                    footer: Text("Revenue and Expenses per month, CAPEX total.")) {
                        NavigationLink(destination: MealList()) {
                            RestaurantFinanceOneRow(title: "Revenue",
                                                    subtitle: "\(noOfActiveRevenueStreams) active revenue streams (\(noOfRevenueStreams) total)",
                                                    currency: currency,
                                                    amount: Int(revenue),
                                                    color: .systemGreen,
                                                    icon: "text.badge.plus") //increase.indent
                        }
                        
                        NavigationLink(destination: OpExList()) {
                            RestaurantFinanceOneRow(title: "OpEx (TBD: ex Payroll)",
                                                    currency: currency,
                                                    amount: opEx,
                                                    color: .systemTeal,
                                                    icon: "text.badge.minus")
                        }
                        
                        RestaurantFinanceOneRow(title: "TO BE DONE Payroll",
                                                currency: Currency.none,
                                                amount: -1, color: .systemTeal,
                                                icon: "person")
                        
                        RestaurantFinanceOneRow(title: "TBD: OpEx + Payroll",
                                                currency: currency,
                                                amount: opEx,
                                                color: .systemTeal,
                                                icon: "text.badge.minus")
                            .padding(.trailing)
                        
                        NavigationLink(destination: CapExList()) {
                            RestaurantFinanceOneRow(title: "CAPEX, total",
                                                    subtitle: "Monthly Depreciation \(currency.idd) \(depreciation.formattedGrouped)",
                                                    currency: currency,
                                                    amount: capEx,
                                                    color: .systemYellow,
                                                    icon: "text.badge.checkmark")
                        }
                        
                        
                        RestaurantFinanceRow(title: "TO BE DONE Return of Investment", subtitle: "Estimated return of Investment, years", currency: Currency.none, amount: -1)
            }
            
            Section(header: Text("KPI".uppercased())) {
                NavigationLink(destination: KPIList()) {
                    
                    RestaurantFinanceOneRow(title: "KPIs & Milestones",
                                            currency: .none,
                                            amount: -1,
                                            color: .systemPurple,
                                            icon: "text.badge.star") //star.circle
                }
            }
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
