//
//  MealEditorNoOfCovers.swift
//
//  Created by Igor Malyarov on 29.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct MealEditorNoOfCovers: View {
    @EnvironmentObject private var userData: UserData
    var currency: Currency { userData.restaurant.currency }
    @Binding var meal: Meal
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("# of Covers".uppercased())) {
                    if meal.hasDailyBreakdown {
                        StreamRow(title: "# of Covers",
                                  detail: String(meal.noOfCovers),
                                  hasLink: false)
                    } else {
                        HStack {
                            Text("# of Covers")
                            Spacer()
                            Text(meal.noOfCovers.formattedGrouped)
                                .foregroundColor(.systemOrange)
                            Stepper("Stepper for amount", value: $meal.noOfCovers, in: 0...9999)
                                .labelsHidden()
                        }
                        
                        Picker(selection: $meal.noOfCoversPeriod, label: Text("Period")) {
                            ForEach(Period.allCases, id: \.id) { period in
                                Text(period.rawValue).tag(period)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
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

                    }
                }
                
                Section(
                    header: Text("Breakdown".uppercased()),
                    footer: Text("You can breakdown # of Covers on a daily basis or provide it for any period.").lineLimit(nil)
                ) {
                    Toggle("Daily Breakdown", isOn: $meal.hasDailyBreakdown.animation())
                    
                    if meal.hasDailyBreakdown {
                        
                        ForEach(DayOfWeek.allCases, id: \.id) { day in
                            CoverForDayRowStepper(meal: self.$meal, day: day)
                        }
                        
                        Button("Reset # of Covers") {
                            self.meal.resetNoOfCovers()
                        }
                    }
                }
            }
            .navigationBarTitle(Text("# of Covers"))
        }
    }
}

struct ShowMealEditorNoOfCovers: View {
    @State private var meal = Meal()
    
    var body: some View {
        MealEditorNoOfCovers(meal: $meal)
    }
}

#if DEBUG
struct MealEditorNoOfCovers_Previews: PreviewProvider {
    static var previews: some View {
        ShowMealEditorNoOfCovers()
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
    }
}
#endif
