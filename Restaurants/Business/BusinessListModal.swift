//
//  BusinessListModal.swift
//  Restaurants
//
//  Created by Igor Malyarov on 10.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct BusinessListModal: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject private var userData: UserData
    @State private var showModal = false
    @State private var modal: ModalType = .options
    
    var body: some View {
        NavigationView {
            List {
                ForEach(userData.business.projectNames, id: \.self) { projectName in
                    Section(header: Text(projectName.uppercased()).foregroundColor(.systemIndigo)) {
                        
                        ForEach(self.userData.business.restaurants
                            .filter { $0.projectName == projectName }
                        ) { restaurant in
                            
                            RestaurantRow(restaurant: restaurant)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    self.userData.selectRestaurant(restaurant)
                                    self.presentation.wrappedValue.dismiss()
                                    let generator = UINotificationFeedbackGenerator()
                                    generator.notificationOccurred(.success) }
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
                
                .navigationBarTitle(Text("Restaurants"))//, displayMode: .inline)
                
                .navigationBarItems(
                    trailing: HStack {
                        TrailingButtonSFSymbol("plus.square") {
                            self.modal = .options
                            self.showModal = true
                        }
                        TrailingButtonSFSymbol("plus") {
                            self.modal = .new
                            self.showModal = true }}
                        .sheet(isPresented: self.$showModal) {
                            if self.modal == .new {
                                CreateRestaurantModal()
                                    .environmentObject(self.userData)
                            }
                            if self.modal == .options {
                                CreateRestaurantWithOptions()
                                    .environmentObject(self.userData) }})
        }
    }
}

struct BusinessListModal_Previews: PreviewProvider {
    static var previews: some View {
        BusinessListModal()
            .environmentObject(UserData())
            .environment(\.sizeCategory, .extraLarge)
            .preferredColorScheme(.dark)
    }
}
