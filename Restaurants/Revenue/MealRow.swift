//
//  MealRow.swift
//
//  Created by Igor Malyarov on 06.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct MealRow: View {
    @EnvironmentObject var userData: UserData
    var currency: Currency { userData.restaurant.currency }
    var meal: Meal
    @State private var showAlert = false
    @State private var showModal = false
    @State private var modal: ModalType = .detail
    
    var body: some View {
        ListRow2(title: meal.name,
                 subtitle: meal.description,
                 extra: meal.isOffered ? currency.idd + meal.coverPrice.formattedGroupedWithDecimals + " × " + (meal.hasDailyBreakdown ? meal.covers.values.reduce(0, +) : meal.noOfCovers).formattedGrouped + " covers per " + meal.noOfCoversPeriod.id + ", cost " + String(format: "%.0f%%", meal.foodPrice > 0 ? meal.foodCost / meal.foodPrice * 100.0 : 0.0) : "",
                 detail: meal.isOffered ? currency.idd + meal.revenuePerMonth.formattedGrouped : "OFF",
                 active: meal.isOffered)
            .contentShape(Rectangle())
            .onTapGesture {
                self.modal = .detail
                self.showModal = true }
            .sheet(isPresented: $showModal) {
                MealDetail(meal: self.meal, isNew: false)
                    .environmentObject(self.userData) }
            .contextMenu {
                Button(action: {
                    self.toggleOffered(self.meal)
                }) {
                    HStack {
                        Text("\(meal.isOffered ? "Deactivate" : "Activate") \("Revenue Stream")")
                        Image(systemName: meal.isOffered ? "xmark.circle" : "checkmark.circle")
                    }
                }
                Button(action: {
                    self.modal = .detail
                    self.showModal = true
                }) {
                    HStack {
                        Text("Show/Edit \("Revenue Stream")")
                        Image(systemName: "aspectratio")
                    }
                }
                Button(action: {
                    self.duplicate(self.meal)
                }) {
                    HStack {
                        Text("Duplicate \("Revenue Stream")")
                        Image(systemName: "plus.square.on.square")
                    }
                }
                Button(action: {
                    self.showAlert = true
                }) {
                    HStack {
                        Text("Delete \("Revenue Stream")")
                        Image(systemName: "trash.circle")
                    }
                }
                .actionSheet(isPresented: $showAlert) {
                    ActionSheet(title: Text("Delete this \("Revenue Stream?")".uppercased()),
                                message: Text("You can't undo this action."),
                                buttons: [
                                    .cancel(),
                                    .destructive(Text("Yes, delete it")) { self.delete() } ])}}
    }
    
    func duplicate(_ meal: Meal) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        withAnimation {
            userData.restaurant.sales.add(meal)
        }
    }
    
    func toggleOffered(_ meal: Meal) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        
//        withAnimation {
            if userData.restaurant.sales.toggleOffered(meal) {
                generator.impactOccurred()
            }
//        }
    }
    
    func delete() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        
        withAnimation {
            if userData.restaurant.sales.delete(meal) {
                generator.impactOccurred()
            }
        }
    }
}

#if DEBUG
struct MealRow_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView {
            List(sampleSales.meals) { meal in
                MealRow(meal: meal)
            }
            .navigationBarTitle("ListRow2")
        }
        .environmentObject(UserData())
        .preferredColorScheme(.dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
#endif
