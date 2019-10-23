//
//  SalesCard4.swift
//  CardModifier
//
//  Created by Igor Malyarov on 13.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct SalesCard4: View {
    @EnvironmentObject private var userData: UserData
    var currency: Currency { userData.restaurant.currency }
    
    var restaurant: Restaurant { userData.restaurant }
    var period: Period = .week
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            if restaurant.sales.meals.reduce(0, { $0 + $1.financial(.beveragesPrice, for: period) }) > 0 {
                Text("Food/Beverages split".uppercased())
                    .font(.footnote)
                    .foregroundColor(Color.secondary)
                
                UnitOfSomethingWithBarsUnsorted(data: [
                    "Food": restaurant.sales.meals.reduce(0, { $0 + $1.financial(.foodPrice, for: period) }),
                    "Beverages": restaurant.sales.meals.reduce(0, { $0 + $1.financial(.beveragesPrice, for: period) })
                    ],
                                                prefix: currency.idd)
            }
            
            Text("by Meal".uppercased())
                .font(.footnote)
                .foregroundColor(Color.secondary)
                .padding(.top)
            
            UnitOfSomethingWithBarsSorted(
                data: restaurant.sales.meals.filter({ $0.isOffered }).reduce(into: [:]) { $0[$1.name] = $1.financial(.coverPrice, for: period) },
                prefix: currency.idd
            )
            
            SalesRow(title: "Total Revenue",
                     detail: currency.idd + restaurant.sales.meals.reduce(0, { $0 + $1.financial(.coverPrice, for: period) }).formattedGrouped,
                     highlight: true)
        }
    }
}

#if DEBUG
struct SalesCard4_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SalesCard4().padding()
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
#endif
