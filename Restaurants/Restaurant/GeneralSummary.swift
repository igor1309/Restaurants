//
//  GeneralSummary.swift
//  Restaurants
//
//  Created by Igor Malyarov on 13.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct GeneralSummary: View {
    @EnvironmentObject private var userData: UserData
    private var restaurant: Restaurant { userData.restaurant }
    @State private var showModal = false
    
    var body: some View {
        Section(header: Text("General".uppercased()),
                footer: Text("Tap to view details or edit.")) {
                    
                    RestaurantFinanceOneRow(title:    restaurant.name,
                                            currency: restaurant.currency,
                                            amount:   restaurant.budget,
                                            color:    .systemOrange,
                                            icon:     "")
                        .contentShape(Rectangle())
                        .padding(.trailing)
                        .onTapGesture { self.showModal = true }
        }
            
        .sheet(isPresented: $showModal) {
            EditRestaurant(restaurant: self.restaurant, isNew: false)
                .environmentObject(self.userData)
        }
    }
}

#if DEBUG
struct GeneralSummary_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                GeneralSummary()
            }
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
#endif
