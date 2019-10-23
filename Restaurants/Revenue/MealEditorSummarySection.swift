//
//  MealEditorSummarySection.swift
//
//  Created by Igor Malyarov on 29.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct MealEditorSummarySection: View {
    @EnvironmentObject var userData: UserData
    var currency: Currency { userData.restaurant.currency }
    @Binding var meal: Meal
    @State private var showModal = false
    
    var body: some View {
        Group {
            Section(header: Text("Revenue Stream Details".uppercased())) {
                HStack {
                    Text("Revenue per " + meal.noOfCoversPeriod.id)
                    Spacer()
                    Text(currency.idd + meal.revenuePerWeek.formattedGrouped)
                }
                
                HStack {
                    Text("\(currency.idd + meal.revenuePerDay.rounded(toPlaces: 0).formattedGrouped) /d")
                    Spacer()
                    Text("\(currency.idd + meal.revenuePerWeek.rounded(toPlaces: 0).formattedGrouped) /w")
                    Spacer()
                    Text("\(currency.idd + meal.revenuePerMonth.rounded(toPlaces: 0).formattedGrouped) /m")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.horizontal)
                
                HStack {
                    Text("# of Covers per \(meal.noOfCoversPeriod.id)")
                    Spacer()
                    Text(meal.noOfCovers.formattedGrouped)
                        .foregroundColor(.systemOrange)
                }
                .contentShape(Rectangle())
                .onTapGesture { self.showModal = true }
                .sheet(isPresented: $showModal) {
                    MealEditorNoOfCovers(meal: self.$meal)
                        .environmentObject(self.userData) }
            }
        }
    }
}

#if DEBUG
struct MealEditorSummarySection_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                MealEditorSummarySection(meal: .constant(Meal()))
            }
        }
        .environment(\.colorScheme, .dark)
        .environmentObject(UserData())
    }
}
#endif
