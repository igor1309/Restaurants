//
//  MealSampleRow.swift
//  Restaurants
//
//  Created by Igor Malyarov on 10.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct MealSampleRow: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    var currency: Currency { userData.restaurant.currency }
    var meal: Meal
    @State private var showDetail = false
    
    var body: some View {
        ListRow2(title: meal.name,
                 subtitle: meal.description,
                 extra: meal.isOffered ? currency.idd + meal.coverPrice.formattedGroupedWithDecimals + " × " + (meal.hasDailyBreakdown ? meal.covers.values.reduce(0, +) : meal.noOfCovers).formattedGrouped + " covers per " + meal.noOfCoversPeriod.id + ", cost " + String(format: "%.0f%%", meal.foodPrice > 0 ? meal.foodCost / meal.foodPrice * 100.0 : 0.0) : "",
                 detail: meal.isOffered ? currency.idd + meal.revenuePerMonth.formattedGrouped : "OFF",
                 active: meal.isOffered)
            .contentShape(Rectangle())
            .onTapGesture { self.showDetail = true }
            .sheet(isPresented: $showDetail) {
                MealDetail(meal: self.meal, isNew: true)
                    .environmentObject(self.userData)
        }
    }
}

struct MealSampleRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                MealSampleRow(meal: sampleSales.meals[0])
            }
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
    }
}
