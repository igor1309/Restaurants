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
            Group {
                Text(restaurant.name)
                    .foregroundColor(.systemOrange)
                
                RestaurantFinanceOneRow(title: "\(restaurant.projectName), \(restaurant.city)",
                    currency: restaurant.currency,
                    amount: restaurant.budget,
                    color: .systemOrange)
                    .padding(.trailing)
            }
            .contentShape(Rectangle())
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
        
        return Group {
            NavigationView {
                Form {
                    GeneralSummary()
                }
            }
            
            NavigationView {
                Form {
                    GeneralSummary()
                        //  .preferredColorScheme(.dark)
                        .environment(\.sizeCategory, .extraLarge)
                }
            }
        }
        .environment(\.colorScheme, .dark)
        .environmentObject(UserData())
    }
}
#endif
