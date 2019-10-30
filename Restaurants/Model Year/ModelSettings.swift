//
//  ModelSettings.swift
//  Restaurants
//
//  Created by Igor Malyarov on 25.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct ModelSettings: View {
    @EnvironmentObject private var userData: UserData
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        NavigationView {
            Form {
                Section(footer:
                    //  MARK: FINISH THIS NOTE
                Text("Use discount rates to estimate results for the first three years.")) {
                    EmptyView()
                }
                
                ForEach(userData.modelYears.indices) { index in
                    Section(header: Text("Model Year \(index + 1)".uppercased())
                    ) {
                        Stepper(self.userData.modelYears[index].discount.formattedPercentage,
                                value: self.$userData.modelYears[index].discount,
                                in: 0...1,
                                step: 0.05)
                    }
                }
            }
                
            .navigationBarTitle("Model Settings")
                
            .navigationBarItems(trailing: TrailingButton("Done") {
                self.presentation.wrappedValue.dismiss() })
        }
    }
}

struct ModelSettings_Previews: PreviewProvider {
    static var previews: some View {
        ModelSettings()
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
    }
}
