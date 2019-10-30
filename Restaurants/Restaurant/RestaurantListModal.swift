//
//  RestaurantListModal.swift
//  Restaurants
//
//  Created by Igor Malyarov on 28.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct RestaurantListModal: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject private var userData: UserData
    
    @State private var showModal = false
    
    func move(from source: IndexSet, to destination: Int) {
        if let first = source.first {
            userData.business.restaurants.swapAt(first, destination)
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                HStack {
                    Image(systemName: "plus.rectangle.fill")
                    Text("Create Restaurant")
                }
                .foregroundColor(.accentColor)
                .contentShape(Rectangle())
                .onTapGesture {
                    //  MARK: CREATE RESTAURANT HERE
                    print("CREATE RESTAURANT HERE")
                    self.showModal = true
                }
                ForEach(userData.business.restaurants) { restaurant in
                    RestaurantRow(restaurant: restaurant)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.userData.restaurant = restaurant
                            self.presentation.wrappedValue.dismiss()
                            let generator = UINotificationFeedbackGenerator()
                            generator.notificationOccurred(.success) }
                }
                .onMove(perform: move)
            }
            .navigationBarTitle("Restaurants")
            .navigationBarItems(
                leading: EditButton(),
                trailing: TrailingButton("Close") {
                    self.presentation.wrappedValue.dismiss() })
                
                .sheet(isPresented: $showModal) {
                    Text("Create Restaurant View here")
            }
        }
    }
}

struct RestaurantListModal_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantListModal()
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
    }
}
