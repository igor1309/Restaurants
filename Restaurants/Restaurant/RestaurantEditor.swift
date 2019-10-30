//
//  RestaurantEditor.swift
//
//  Created by Igor Malyarov on 24.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct RestaurantEditor: View {
    @EnvironmentObject var userData: UserData
    @Binding var draft: Restaurant
    var currency: Currency { userData.restaurant.currency }
    var body: some View {
        Group {
//            Section(header: Text("Restaurant".uppercased())) {
//                TextFieldWithReset("Restaurant Name", text: $draft.name)
//
//                Picker(selection: $draft.type, label: Text("Type")
//                ) {
//                    ForEach(RestaurantType.allCases, id: \.rawValue) { type in
//                        Text(type.rawValue).tag(type)
//                    }
//                }
//
//                Picker(selection: $draft.city,
//                       label: TextField("Status", text: $draft.city)) {
//                        ForEach(userData.business.cities, id: \.self) { city in
//                            Text(city).tag(city)
//                        }
//                }
//            }
//
//            Section {
//                TextFieldWithReset("Concept", text: $draft.concept)
//
//                TextFieldWithReset("Description", text: $draft.description)
//
//                TextFieldWithReset("Comment", text: $draft.comment)
//
//                Picker(selection: $draft.status, label: Text("Status")) {
//                    ForEach(Status.allCases, id: \.rawValue) { status in
//                        Text(status.rawValue).tag(status)
//                    }
//                }
//            }
            
            Section(header: Text("Budget".uppercased())) {
//                RowWithStepperInt(title: "Budget", currency: draft.currency, amount: $draft.budget)
                
                Stepper(value: $draft.budget, step: currency == .rub ? 500_000 : 10_000) {
                    Text("Budget")
                    Spacer().frame(minWidth: 10)
                    Text(currency.idd + draft.budget.formattedGrouped)
                        .foregroundColor(.orange)
                }
                
                HStack {
                    Text("Currency")
                    Spacer()
                        .frame(minWidth: 10)
                    CurrencySegmentedControl(selection: $draft.currency)
                }
            }
            
            Section(header: Text("Seating".uppercased())) {
                RowWithStepperInt(title: "Inside Seating", currency: .none, amount: $draft.insideSeating)
                Stepper(value: $draft.insideSeating, step: 5) {
                    Text("Inside Seating")
                    Spacer().frame(minWidth: 1)
                    Text(draft.insideSeating.formattedGrouped)
                        .foregroundColor(.orange)
                }

                RowWithStepperInt(title: "Outside Seating", currency: .none, amount: $draft.outsideSeating)
                Stepper(value: $draft.outsideSeating, step: 5) {
                    Text("Outside Seating")
                    Spacer().frame(minWidth: 1)
                    Text(draft.outsideSeating.formattedGrouped)
                        .foregroundColor(.orange)
                }
            }
            
            Section(header: Text("Area, sq m".uppercased())) {
                RowWithStepperInt(title: "Area", currency: .none, amount: $draft.area)
                RowWithStepperInt(title: "Kitchen Area", currency: .none, amount: $draft.kitchenArea)
                //  MARK: TODO: totalArea = area + kitchenArea!
                //  нет необходимости вводить один из трех параметров
                //  НО КАКОЙ???? как это сделать??
                HStack {
                    Text("Total Area")
                    Spacer()
                    Text((draft.area + draft.kitchenArea).formattedGrouped)
                }
            }
            
            Section(header: Text("Taxes".uppercased())) {
                RowWithStepperPercentage(title: "Corp Income Tax", amount: $draft.taxRate)
            }
        }
    }
}

#if DEBUG
struct RestaurantEditor_Previews: PreviewProvider {
    static var previews: some View {
        let userData = UserData()
        return Group {
            NavigationView {
                Form {
                    RestaurantEditor(draft: .constant(userData.business.restaurants[0]))
                }
            }
        }
        .environment(\.sizeCategory, .extraLarge)
        .preferredColorScheme(.dark)
        .environmentObject(UserData())
    }
}
#endif
