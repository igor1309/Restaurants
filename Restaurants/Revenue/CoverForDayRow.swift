//
//  CoversForDayRow.swift
//
//  Created by Igor Malyarov on 29.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CoverForDayRowStepper: View {
    @EnvironmentObject private var userData: UserData
    @Binding var meal: Meal
    var day: DayOfWeek
    @State private var amount: Int
    
    init(meal: Binding<Meal>, day: DayOfWeek) {
        self._meal = meal
        self.day = day
        self._amount = State(initialValue: meal.wrappedValue.covers[day] ?? 0)
    }
    
    var body: some View {
        let aaa = Binding(get: {
            return self.$amount.wrappedValue
        }, set: {
            self.meal.covers[self.day] = $0
            self.amount = $0
        })
        
        return HStack {
            Text(day.id)
            Spacer()
            Text(amount.formattedGrouped)
                .foregroundColor(.systemOrange)
            Stepper("Stepper for amount", value: aaa, in: 0...999)
                .labelsHidden()
        }
    }
}

struct CoverForDayRow: View {
    @EnvironmentObject private var userData: UserData
    @Binding var meal: Meal
    var day: DayOfWeek
    @State private var amount: Int
    
    init(meal: Binding<Meal>, day: DayOfWeek) {
        self._meal = meal
        self.day = day
        self._amount = State(initialValue: meal.wrappedValue.covers[day] ?? 0)
        //        //        self.mealIndex = userData.restaurant.sales.meals.firstIndex(where: { $0.id == meal.id })!
    }
    
    var body: some View {
        
        let aaa = Binding(get: {
            return self.$amount.wrappedValue
        }, set: {
            self.meal.covers[self.day] = $0
            self.amount = $0
        })
        
        return EditableRowInt(title: day.id, detail: String(aaa.wrappedValue), amount: aaa)
        //        .onReceive(Publisher, perform: T##(Publisher.Output) -> Void)
    }
}

#if DEBUG
struct CoverForDayRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                CoverForDayRowStepper(meal: .constant(Meal()), day: .saturday)
                CoverForDayRow(meal: .constant(Meal()), day: .friday)
            }
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
    }
}
#endif
