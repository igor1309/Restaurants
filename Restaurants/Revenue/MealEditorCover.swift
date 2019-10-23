//
//  MealEditorCover.swift
//
//  Created by Igor Malyarov on 29.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct MealEditorCover: View {
    @EnvironmentObject var userData: UserData
    @Binding var meal: Meal
    var currency: Currency { userData.restaurant.currency }
    
    var body: some View {
        Group {
            Section {
                Toggle(isOn: $meal.hasFoodAndBevBreakdown.animation()) {
                    Text("Food-Beverages Breakdown")
                }
            }
            
            Section(header: Text("Price".uppercased())) {
                
                if meal.hasFoodAndBevBreakdown {
                    
                    RowWithStepperDouble(title: "Food Price", currency: currency, amount: $meal.foodPrice)
                    
                    RowWithStepperDouble(title: "Beverages Price", currency: currency, amount: $meal.beveragesPrice)
                    
                    StreamRow(title: "Cover Price",
                              detail: currency.idd + meal.coverPrice.formattedGroupedWithDecimals,
                              hasLink: false)
                    
                } else {
                    //  если нет разбивки на Food Beverages
                    //  (то есть hasFoodAndBevBreakdown = false)
                    //  то coverPrice = foodPrice
                    //  и coverCost = foodCost
                    //  поэтому меняется foodCost, а coverCost автоматически пересчитывается
                    RowWithStepperDouble(title: "Cover Price", currency: currency, amount: $meal.foodPrice)
                }
            }
            
            Section(
                header: Text("Cost".uppercased()),
                footer: Text("Enter Cost of Food and Beverages and check the percentage of Cover Price. Benckmark is 25%.")
                    .lineLimit(nil)
            ) {
                if meal.hasFoodAndBevBreakdown {
                    RowWithStepperDouble(title: "Food Cost \(String(format: "%.0f%%", meal.foodPrice > 0 ? meal.foodCost / meal.foodPrice * 100.0 : 0.0))", currency: currency, amount: $meal.foodCost)
                    
                    RowWithStepperDouble(title: "Beverages Cost \(String(format: "%.0f%%", meal.beveragesPrice > 0 ? meal.beveragesCost / meal.beveragesPrice * 100.0 : 0.0))", currency: currency, amount: $meal.beveragesCost)
                    
                    StreamRow(title: "Cover Cost",
                              detail: String(format: "%.0f%%", meal.coverPrice > 0 ? meal.coverCost / meal.coverPrice * 100.0 : 0.0) + " ・ " + currency.idd + meal.coverCost.formattedGroupedWithDecimals,
                              hasLink: false)
                    
                } else {
                    //  если нет разбивки на Food Beverages
                    //  (то есть hasFoodAndBevBreakdown = false)
                    //  то coverPrice = foodPrice
                    //  и coverCost = foodCost
                    //  поэтому меняется foodCost, а coverCost автоматически пересчитывается
                    RowWithStepperDouble(title: "Cover Cost \(String(format: "%.0f%%", meal.foodPrice > 0 ? meal.foodCost / meal.foodPrice * 100.0 : 0.0))", currency: currency, amount: $meal.foodCost)
                }
            }
        }
    }
}

struct ShowMealEditorCover: View {
    @State var meal: Meal
    
    init() {
        self._meal = State(initialValue: sampleSales.meals[0])
    }
    
    var body: some View {
        MealEditorCover(meal: $meal)
    }
}


#if DEBUG
struct MealEditorCover_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                ShowMealEditorCover()
            }
        }
        .environment(\.colorScheme, .dark)
        .environmentObject(UserData())
    }
}
#endif
