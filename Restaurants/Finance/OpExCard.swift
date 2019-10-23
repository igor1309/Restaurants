//
//  OpExCard.swift
//  Restaurants
//
//  Created by Igor Malyarov on 16.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct OpExLines: View {
    @EnvironmentObject private var userData: UserData
    var restaurant: Restaurant { userData.restaurant }
    var currency: Currency { userData.restaurant.currency }
    
    var revenue: Double { restaurant.sales.revenuePerMonth }
    var opEx: Double { restaurant.opExPerMonth }
    var salary: Double { restaurant.salaryPerMonth }
    var salaryKitchen: Double { restaurant.salaryKitchenPerMonth }
    var salaryExKitchen: Double { restaurant.salaryExKitchenPerMonth }
    var occupancyCosts: Double { restaurant.occupancyCostsPerMonth }
    var utilities: Double { restaurant.utilitiesPerMonth }
    var marketing: Double { restaurant.marketingPerMonth }
    var otherOpEx: Double { restaurant.otherOpExPerMonth }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            if revenue > 0 {
                Text("to Revenue")
                    .font(.footnote)
                    .foregroundColor(Color.secondary)
                    .padding(.bottom, 0)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                PandLRow(title: "Total OpEx",
                         subtitle: "Operating Expenses",
                         detail: currency.idd + opEx.formattedGrouped,
                         subdetail: (opEx / revenue).formattedPercentageWithDecimals,
                         highlight: true)
                
                Group {
                    PandLRow(title: "Salary",
                             subtitle: "All Payroll Expenses",
                             detail: currency.idd + salary.formattedGrouped,
                             subdetail: (salary / revenue).formattedPercentageWithDecimals)
                    
                    PandLRow(title: "Occupancy Costs",
                             subtitle: "Rent, etc",
                             detail: currency.idd + occupancyCosts.formattedGrouped,
                             subdetail: (occupancyCosts / revenue).formattedPercentageWithDecimals)
                    
                    PandLRow(title: "Utilities",
                             subtitle: "Utilities",
                             detail: currency.idd + utilities.formattedGrouped,
                             subdetail: (utilities / revenue).formattedPercentageWithDecimals)
                    
                    PandLRow(title: "Marketing",
                             subtitle: "Marketing",
                             detail: currency.idd + marketing.formattedGrouped,
                             subdetail: (marketing / revenue).formattedPercentageWithDecimals)
                    
                    PandLRow(title: "Other OpEx",
                             subtitle: "OtherOpEx",
                             detail: currency.idd + otherOpEx.formattedGrouped,
                             subdetail: (otherOpEx / revenue).formattedPercentageWithDecimals)
                }
                
                Divider()
                
                PandLRow(title: "non Salary OpEx",
                         subtitle: "OpEx without Payroll Expenses",
                         detail: currency.idd + (opEx - salary).formattedGrouped,
                         subdetail: ((opEx - salary) / revenue).formattedPercentageWithDecimals)
                
                Divider()
                
                SalaryLines()
                
            } else {
                Text("No Data Yet")
            }
        }
    }
}

struct SalaryLines: View {
    @EnvironmentObject private var userData: UserData
    var restaurant: Restaurant { userData.restaurant }
    var currency: Currency { userData.restaurant.currency }
    
    var revenue: Double { restaurant.sales.revenuePerMonth }
    var opEx: Double { restaurant.opExPerMonth }
    var salary: Double { restaurant.salaryPerMonth }
    var salaryKitchen: Double { restaurant.salaryKitchenPerMonth }
    var salaryExKitchen: Double { restaurant.salaryExKitchenPerMonth }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            if revenue > 0 && salary > 0 {
                Group {
                    PandLRow(title: "Salary",
                             subtitle: "Incl Payroll Expenses to OpEx",
                             detail: currency.idd + salary.formattedGrouped,
                             subdetail: (salary / opEx).formattedPercentageWithDecimals,
                             highlight: true)
                    
                    PandLRow(title: "Salary Kitchen",
                             subtitle: "to Salary Total",
                             detail: currency.idd + salaryKitchen.formattedGrouped,
                             subdetail: (salaryKitchen / salary).formattedPercentageWithDecimals)
                    
                    PandLRow(title: "Salary ex Kitchen",
                             subtitle: "to Salary Total",
                             detail: currency.idd + salaryExKitchen.formattedGrouped,
                             subdetail: (salaryExKitchen / salary).formattedPercentageWithDecimals)
                }
            } else {
                Text("No Data Yet")
            }
            
            NavigationLink(destination: OpExList()
            ) {
                HStack {
                    Spacer()
                    Text("Operating Expenses")
                        .foregroundColor(Color.accentColor)
                    Spacer()
                }
            }
        }
    }
}

struct OpExCard: View {
    var body: some View {
        Card(title: "Operating Expenses",
             subtitle: "OpEx, monthly",
             trunk: OpExLines(),
             borderColor: .gray,
             cornerRadius: 8)
    }
}

#if DEBUG
struct OpExCard_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VStack {
                OpExCard()
            }
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
#endif
