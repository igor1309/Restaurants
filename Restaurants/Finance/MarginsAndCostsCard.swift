//
//  MarginsAndCostsCard.swift
//  Restaurants
//
//  Created by Igor Malyarov on 16.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct MarginsAndCostsCard: View {
    //    @EnvironmentObject private var userData: UserData
    var meal: Meal
    
    var body: some View {
        MarginsPerCoverCard(price: meal.coverPrice,
                            gp: meal.coverPrice - meal.coverCost,
                            op: 0,
                            ptp: 0,
                            foodcost: meal.coverCost,
                            salary: 0,
                            fixedCosts: 0)
    }
}

#if DEBUG
struct MarginsAndCostsCard_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MarginsAndCostsCard(meal: UserData().restaurant.sales.meals[0])
                .padding()
        }
        .environment(\.sizeCategory, .extraLarge)
        .preferredColorScheme(.dark)
        .environmentObject(UserData())
    }
}
#endif
