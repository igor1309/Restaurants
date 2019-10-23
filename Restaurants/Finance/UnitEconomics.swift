//
//  UnitEconomics.swift
//  CardModifier
//
//  Created by Igor Malyarov on 13.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct UnitEconomics: View {
    @EnvironmentObject private var userData: UserData
    var restaurant: Restaurant { userData.restaurant }
    
    
    let minCardWidth = CGFloat(310)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Unit Economics")
                .font(.headline)
                .padding(.leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    
                    hScrollingCard(title: "Average TO BE DONE",
                                   subtitle: "Weighted Average (Total)",
                                   trunk: MarginsPerCoverCard(),
                                   cornerRadius: 8)
                        .frame(minWidth: minCardWidth)
                    
                    ForEach(restaurant.sales.meals) { meal in
                        hScrollingCard(title: meal.name,
                                       subtitle: "…",
                                       trunk: MarginsAndCostsCard(meal: meal),
                                       cornerRadius: 8)
                            .frame(minWidth: self.minCardWidth)
                    }
                }
                .padding(.leading)
            }
        }
        .padding(.bottom)
    }
}

#if DEBUG
struct UnitEconomics_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UnitEconomics()
        }
        .environmentObject(UserData())
        .environment(\.sizeCategory, .extraLarge)
        .preferredColorScheme(.dark)
    }
}
#endif
