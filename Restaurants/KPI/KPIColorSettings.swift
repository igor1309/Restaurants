//
//  KPIColorSettings.swift
//  Restaurants
//
//  Created by Igor Malyarov on 09.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct KPIColorSettings: View {
    @EnvironmentObject private var userData: UserData
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Periods for KPI Colors".uppercased()),
                        footer: Text("Red Period should be shorter than Orange.").font(.footnote)
                ) {
                    Stepper("Red if in \(userData.restaurant.kpi.kpiTermForRedColor) day\(userData.restaurant.kpi.kpiTermForRedColor == 1 ? "" : "s")", value: $userData.restaurant.kpi.kpiTermForRedColor)
                    .foregroundColor(.systemRed)
                    
                    Stepper("Orange if in \(userData.restaurant.kpi.kpiTermForRedColor + 1) to \(userData.restaurant.kpi.kpiTermForOrangeColor) days", value: $userData.restaurant.kpi.kpiTermForOrangeColor)
                    .foregroundColor(.systemOrange)
                }
            }
            .navigationBarTitle("KPI Colors")
        }
    }
}
struct KPIColorSettings_Previews: PreviewProvider {
    static var previews: some View {
        KPIColorSettings()
            .environment(\.colorScheme, .dark)
            .environmentObject(UserData())
    }
}
