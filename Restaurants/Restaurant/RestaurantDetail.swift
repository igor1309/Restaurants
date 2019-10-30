//
//  RestaurantDetail.swift
//
//  Created by Igor Malyarov on 17.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct RestaurantDetail : View {
    @EnvironmentObject private var userData: UserData
    
    @State private var showActionSheet = false
    @State private var showCreateActionSheet = false
    @State private var showCreateActionSheetFromSample = false
    @State private var showModal = false
    @State private var modal: ModalType = .restaurantList
    
    var body: some View {
        Form {
            GeneralSummary()
            
            FinancialSummary()
            
            InvestmentSection ()
            
            ReportSection()
            
            KPISection()
        }
            
        .navigationBarTitle(Text(userData.restaurant.name))
            
        .navigationBarItems(
            leading: HStack {
                LeadingButtonSFSymbol("list.bullet") {
                    self.modal = .business
                    self.showModal = true }
                LeadingButtonSFSymbol("list.dash") {
                    self.modal = .restaurantList
                    self.showModal = true }
                    .opacity(0.7)
            },
            trailing: HStack {
                TrailingButtonSFSymbol("plus.square") {
                    self.showCreateActionSheetFromSample = true }
                    .actionSheet(isPresented: $showCreateActionSheetFromSample) {
                        ActionSheet(
                            title: Text("Create"),
                            message: Text("from Samples"),
                            buttons: [
                                .cancel {},
                                .default(Text("New Revenue Stream")) {
                                    self.modal = .createMealOptions
                                    self.showModal = true },
                                .default(Text("New Expense (OpEx)")) {
                                    self.modal = .createOpExOptions
                                    self.showModal = true },
                                .destructive(Text("TBD New Payroll Item")),
                                .default(Text("New CAPEX")) {
                                    self.modal = .createCapExOptions
                                    self.showModal = true },
                                .default(Text("New KPI or Forcast")) {
                                    self.modal = .createKPIOptions
                                    self.showModal = true },
                                .default(Text("New Restaurant")) {
                                    self.modal = .createRestaurantOptions
                                    self.showModal = true }
                            ]
                        )}
                
                TrailingButtonSFSymbol("plus") {
                    self.showCreateActionSheet = true }
                    .actionSheet(isPresented: $showCreateActionSheet) {
                        ActionSheet(
                            title: Text("Create"),
                            message: Text("more data about Restaurant"),
                            buttons: [
                                .cancel {},
                                .default(Text("Create Revenue Stream")) {
                                    self.modal = .createMeal
                                    self.showModal = true },
                                .default(Text("Create Expense (OpEx)")) {
                                    self.modal = .createOpEx
                                    self.showModal = true },
                                .default(Text("Create CAPEX")) {
                                    self.modal = .createCapEx
                                    self.showModal = true },
                                .default(Text("Create KPI or Forcast")) {
                                    self.modal = .createKPI
                                    self.showModal = true },
                                .default(Text("Create Restaurant")) {
                                    self.modal = .createRestaurant
                                    self.showModal = true },
                            ]
                        )}
            }
        )
            
            .sheet(isPresented: self.$showModal) {
                
                if self.modal == .createRestaurant {
                    CreateRestaurantModal()
                        .environmentObject(self.userData)
                } else if self.modal == .createRestaurantOptions {
                    CreateRestaurantWithOptions()
                        .environmentObject(self.userData)
                } else if self.modal == .restaurantList {
                    RestaurantListModal()
                        .environmentObject(self.userData)
                }
                
                if self.modal == .business {
                    BusinessListModal()
                        .environmentObject(self.userData)
                }
                
                if self.modal == .createMeal {
                    CreateMealModal()
                        .environmentObject(self.userData)
                }
                
                if self.modal == .createMealOptions {
                    MealSampleList()
                        .environmentObject(self.userData)
                }
                
                if self.modal == .createOpEx {
                    CreateOpExModal()
                        .environmentObject(self.userData)
                }
                
                if self.modal == .createOpExOptions {
                    OpExSampleList()
                        .environmentObject(self.userData)
                }
                
                if self.modal == .createCapEx {
                    CreateCapExModal()
                        .environmentObject(self.userData)
                }
                
                if self.modal == .createCapExOptions {
                    CapExSampleList()
                        .environmentObject(self.userData)
                }
                
                if self.modal == .createKPI {
                    CreateKPIModal()
                        .environmentObject(self.userData)
                }
                
                if self.modal == .createKPIOptions {
                    KPISampleList()
                        .environmentObject(self.userData)
                }
        }
    }
}

#if DEBUG
struct RestaurantDetail_Previews : PreviewProvider {
    static var previews: some View {
        
        Group {
            NavigationView {
                RestaurantDetail()
            }
            .preferredColorScheme(.dark)
            .environment(\.sizeCategory, .extraLarge)
            
            NavigationView {
                RestaurantDetail()
            }
        }
        .environmentObject(UserData())
    }
}
#endif
