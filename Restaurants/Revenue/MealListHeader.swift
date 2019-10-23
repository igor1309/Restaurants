//
//  MealListHeader.swift
//  Restaurants
//
//  Created by Igor Malyarov on 10.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct MealListHeader: View {
    @EnvironmentObject private var userData: UserData
    var currency: Currency { userData.restaurant.currency }
    
    var body: some View {
        VStack {
            HStack {
                Text("Revenue, per month")
                Spacer()
                Text(currency.idd + self.userData.restaurant.sales.revenuePerMonth.formattedGrouped)
            }
            .font(.headline)
            
            HStack {
                Text("Revenue, per week")
                Spacer()
                Text(currency.idd + self.userData.restaurant.sales.revenuePerWeek.formattedGrouped)
            }
            .font(.caption)
        }
        .foregroundColor(.systemGreen)
    }
}

struct MealListHeader_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                MealListHeader()
            }
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
    }
}
