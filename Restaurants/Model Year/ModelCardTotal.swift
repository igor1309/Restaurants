//
//  ModelCardTotal.swift
//  Restaurants
//
//  Created by Igor Malyarov on 23.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

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

struct ModelCardTotal_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VStack {
                ModelCardTotal().padding()
                Spacer()
            }
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
    }
}
