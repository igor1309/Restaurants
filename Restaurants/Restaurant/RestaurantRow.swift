//
//  RestaurantRow.swift
//
//  Created by Igor Malyarov on 16.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct RestaurantRow : View {
    var restaurant: Restaurant
    /*
     RestaurantRow view has two design options:
     - with project name and without restaurant name to use in Restaurant detail view, and
     - without project name and with restaurant name to use in Restaurant List
     */
    var showName = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack {
                if !showName {
                    Text(restaurant.projectName.uppercased())
                        .fontWeight(.light)
                    
                    Spacer()
                }
                
                Text(restaurant.city.uppercased())
                    .fontWeight(.light)
                
                Spacer()
                
                Text(restaurant.currency.idd + restaurant.budget.formattedGrouped)
                    .fontWeight(.light)
            }
            .font(.footnote)
            .foregroundColor(.systemOrange)
            
            if showName {
                Text(restaurant.name)
                    .font(.title2)
                //                    .fontWeight(.light)
            }
            
            VStack(alignment: .leading, spacing: 3) {
                if showName {
                    Text(restaurant.concept.uppercased())
                        .font(.caption)
                        .fontWeight(.light)
                        .foregroundColor(.systemOrange)
                    
                    Text(restaurant.type.id)
                        .font(.subheadline)
                        .fontWeight(.light)
                }
                else {
                    Text(restaurant.type.id.uppercased())
                        .font(.caption)
                        .fontWeight(.thin)
                    
                    Text(restaurant.concept)
                        .font(.callout)
                        .foregroundColor(.systemOrange)
                }
            }
            
            //            Text(restaurant.description)
            //                .fontWeight(.light)
            //                .foregroundColor(.secondary)
            //                .font(.subheadline)
            
            HStack {
                HStack(alignment: .firstTextBaseline) {
                    Text("❂")
                        .foregroundColor(.systemOrange)
                    
                    Text(restaurant.status.id)
                        .foregroundColor(.secondary)
                }
                
                Text(restaurant.comment)
            }
            .font(.caption)
        }
        .contentShape(Rectangle())
    }
}


#if DEBUG
struct RestaurantRow_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                RestaurantRow(restaurant: sampleRestaurants[0])
                    .padding()
            }
                
            .preferredColorScheme(.dark)
            .environment(\.sizeCategory, .extraLarge)
            
            NavigationView {
                RestaurantRow(restaurant: sampleRestaurants[0],
                              showName: false)
                    .padding()
            }
        }
        //        .previewLayout(.sizeThatFits)
    }
}
#endif
