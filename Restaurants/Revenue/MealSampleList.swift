//
//  MealSampleList.swift
//  Restaurants
//
//  Created by Igor Malyarov on 10.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct MealSampleList: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Sample".uppercased()),
                        footer: Text("Use this samples to create your Revenue Streams.")) {
                            
                            ForEach(sampleSales.meals, id: \.self) { meal in
                                MealSampleRow(meal: meal)
                            }
                }
            }
            .listStyle(GroupedListStyle())
                
            .navigationBarTitle("Select Sample")
                
            .navigationBarItems(trailing: TrailingButtonSFSymbol("checkmark") {
                self.presentation.wrappedValue.dismiss() })
        }
    }
}

struct MealSampleList_Previews: PreviewProvider {
    static var previews: some View {
        MealSampleList()
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
    }
}
