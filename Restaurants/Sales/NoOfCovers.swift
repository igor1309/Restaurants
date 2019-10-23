//
//  NoOfCovers.swift
//
//  Created by Igor Malyarov on 04.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct NoOfCovers: View {
    @EnvironmentObject private var userData: UserData
    var restaurant: Restaurant { userData.restaurant }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            UnitOfSomethingWithBarsSorted(
                data: restaurant.sales.meals.filter({ $0.isOffered }).reduce(into: [:]) { $0[$1.name] = Double($1.noOfCoversPerWeek) }
            )
            
            SalesRow(title: "Total # of Covers",
                     detail: restaurant.sales.meals.reduce(0, { $0 + $1.noOfCoversPerWeek }).formattedGrouped,
                     highlight: true)
        }
    }
}

#if DEBUG
struct NoOfCovers_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VStack {
                NoOfCovers()
                    .padding()
                
                Spacer()
            }
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
#endif
