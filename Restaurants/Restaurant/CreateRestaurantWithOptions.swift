//
//  CreateRestaurantWithOptions.swift
//  Restaurants
//
//  Created by Igor Malyarov on 10.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

func randomString(length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length).map{ _ in letters.randomElement()! })
}

struct NewRestaurantRow: View {
    @EnvironmentObject var userData: UserData
    var restaurant: Restaurant
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(restaurant.name)
                    .foregroundColor(.systemOrange)
                Spacer()
                Text(restaurant.currency.idd + restaurant.budget.formattedGrouped)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Text("\(restaurant.projectName), \(restaurant.city)")
                //                .fontWeight(.light)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 3)
    }
}


struct CreateRestaurantWithOptions: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Select sample".uppercased())) {
                    ForEach(sampleRestaurants) { sample in
                        NewRestaurantRow(restaurant: sample)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                var draft = Restaurant(from: sample)
                                draft.name.append(randomString(length: 4))
                                self.userData.business.add(draft)
                                self.presentation.wrappedValue.dismiss() }
                        
                    }
                }
            }
            .listStyle(GroupedListStyle())
                
            .navigationBarTitle("Select Sample")
                
            .navigationBarItems(trailing: TrailingButtonSFSymbol("checkmark") {
                self.presentation.wrappedValue.dismiss() })
        }
    }
}

struct CreateRestaurantWithOptions_Previews: PreviewProvider {
    static var previews: some View {
        CreateRestaurantWithOptions()
            .environment(\.sizeCategory, .extraLarge)
            .preferredColorScheme(.dark)
            .environmentObject(UserData())
        
    }
}
