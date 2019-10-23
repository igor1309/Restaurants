//
//  ModelView.swift
//  Restaurants
//
//  Created by Igor Malyarov on 18.08.2019.
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

struct ModelCardTotal: View {
    @EnvironmentObject private var userData: UserData
    var currency: Currency { userData.restaurant.currency }
    var model: Model { Model(restaurant: userData.restaurant, modelYears: userData.modelYears) }
    
    var body: some View {
        VStack {
            PandLRow(title: "Discounted Revenue",
                     subtitle: "avg per Month",
                     detail: currency.idd + (model.discountedRevenue * 12).formattedGrouped,
                     subdetail: currency.idd + model.discountedRevenue.formattedGrouped,
                     highlight: false)
            
            PandLRow(title: "Profit/Loss",
                     subtitle: "avg per Month",
                     detail: currency.idd + (model.discountedProfit * 12).formattedGrouped,
                     subdetail: currency.idd + model.discountedProfit.formattedGrouped,
                     highlight: false)
            
            PandLRow(title: "Cash Flow Est.",
                     subtitle: "avg per Month",
                     detail: currency.idd + (model.discountedCashFlowEstimate * 12).formattedGrouped,
                     subdetail: currency.idd + model.discountedCashFlowEstimate.formattedGrouped,
                     highlight: false)
        }
    }
}

struct ModelCard: View {
    @EnvironmentObject private var userData: UserData
    var restaurant: Restaurant { userData.restaurant }
    var modelYear: ModelYear
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

struct ModelView: View {
    @EnvironmentObject private var userData: UserData
    @State private var showModelSettings = false
    
    let cardWidth: CGFloat = 359
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 8) {
                
                Card(title: "Target",
                     subtitle: "Restaurant Data as entered",
                     trunk: Target(),
                     borderColor: .gray,
                     cornerRadius: 8)
                
                Text("Discounted Model Years")
                    .font(.headline)
                    .padding(.leading)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 0) {
                        
                        hScrollingCard(title: "Model Period",
                                       subtitle: "\(userData.modelYears.count) years, total",
                            trunk: ModelCardTotal(),
                            borderColor: .gray,
                            cornerRadius: 8)
                            .frame(minWidth: cardWidth)
                        
                        ForEach(userData.modelYears) { modelYear in
                            hScrollingCard(title: "Model Year \(modelYear.id.formattedGrouped)",
                                subtitle: "Discount \(modelYear.discount.formattedPercentage). Data per year.",
                                trunk: ModelCard(modelYear: modelYear),
                                borderColor: .gray,
                                cornerRadius: 8)
                                .frame(minWidth: self.cardWidth)
                        }
                    }
                    .padding(.top, 1)
                    .padding(.leading)
                }
                
                Spacer()
            }
            .navigationBarTitle("Model")
                
            .navigationBarItems(trailing:
                TrailingButtonSFSymbol(systemName: "square.grid.2x2") {
                    self.showModelSettings = true }
                    .sheet(isPresented: self.$showModelSettings,
                           content: { ModelSettings()
                            .environmentObject(self.userData) }))
        }
    }
}

#if DEBUG
struct Model_Previews: PreviewProvider {
    static var previews: some View {
        ModelView()
            .environmentObject(UserData())
    }
}
#endif
