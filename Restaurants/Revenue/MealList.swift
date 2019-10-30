//
//  MealList.swift
//
//  Created by Igor Malyarov on 30.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct MealList: View {
    @EnvironmentObject var userData: UserData
    @State private var showModal = false
    @State private var modal: ModalType = .options
    
    var currency: Currency { userData.restaurant.currency }
    var sales: Sales { userData.restaurant.sales }
    
    var body: some View {
        List {
            Section(header:
                VStack {
                    SuperTotalRow(title: "Revenue, per month",
                                  detail: currency.idd + sales.revenuePerMonth.formattedGrouped,
                                  color: .systemGreen)
                    BasicRow(title: "Revenue, per week",
                             detail: currency.idd + sales.revenuePerWeek.formattedGrouped,
                             color: .systemGreen)
            }) {
                ForEach(sales.meals.filter { $0.isOffered }, id: \.self) { meal in
                    MealRow(meal: meal)
                }
            }
            
            Section(header: Text("Not Offered".uppercased())) {
                ForEach(sales.meals.filter { !$0.isOffered }, id: \.self) { meal in
                    MealRow(meal: meal)
                }
            }
        }
        .listStyle(GroupedListStyle())
            
        .navigationBarTitle(Text("Revenue Stream"))
            
        .navigationBarItems(
            trailing: HStack {
                TrailingButtonSFSymbol("plus.square") {
                    self.modal = .options
                    self.showModal = true
                }
                TrailingButtonSFSymbol("plus") {
                    self.modal = .new
                    self.showModal = true }})
            
            .sheet(isPresented: self.$showModal) {
                if self.modal == .new {
                    CreateMealModal()
                        .environmentObject(self.userData)
                }
                
                if self.modal == .options {
                    MealSampleList()
                        .environmentObject(self.userData) }}
    }
}

#if DEBUG
struct MealList_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView { MealList() }
            .environmentObject(UserData())
            .preferredColorScheme(.dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
#endif
