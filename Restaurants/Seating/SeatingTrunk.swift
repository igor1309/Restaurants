//
//  SeatingTrunk.swift
//
//  Created by Igor Malyarov on 06.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct SeatingTrunk: View {
    var restaurant: Restaurant
    
    let vstackSpacing: CGFloat = 12
    
    var body: some View {
        VStack(alignment: .leading, spacing: vstackSpacing) {
            
            VStack(alignment: .leading, spacing: 4) {
                SeatingRow(significantRow: true,
                           title: "Inside Seating")
                
                SeatingRow(title: "Guests",
                           detail: restaurant.insideSeating.formattedGrouped)
                SeatingRow(title: "Dining area, sq m",
                           detail: restaurant.area.formattedGrouped)
                SeatingRow(subRow: true,
                           title: "per guest*",
                           detail: (Double(restaurant.area) / Double(restaurant.insideSeating)).formattedGroupedWithDecimals,
                           highlight: false)
                SeatingRow(title: "Kitchen + other, sq m",
                           detail: restaurant.kitchenArea.formattedGrouped,
                           subdetail: (Double(restaurant.kitchenArea) / Double(restaurant.totalArea)).formattedPercentage)
                SeatingRow(title: "Total, sq m",
                           detail: restaurant.totalArea.formattedGrouped)
            }
            
            SeatingRow(significantRow: true,
                       title: "Outside Seating",
                       detail: restaurant.outsideSeating.formattedGrouped,
                       highlight: true)
                .padding(.top, 8)
            
            SeatingRow(significantRow: true,
                       title: "Inside + Outside Seating",
                       detail: (restaurant.insideSeating + restaurant.outsideSeating).formattedGrouped,
                       highlight: true)
                .padding(.top, 8)
        }
    }
}

#if DEBUG
struct SeatingTrunk_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SeatingTrunk(restaurant: sampleRestaurants[0])
                .padding()
        }
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
        .environmentObject(UserData())
    }
}
#endif
