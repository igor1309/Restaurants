//
//  ReportView.swift
//  Restaurants
//
//  Created by Igor Malyarov on 24.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ReportView: View {
    var report: Report
    
    var body: some View {
        NavigationView {
            ScrollView {
                ReportCard(report: report).padding(.top)
            }
            .navigationBarTitle(Text(report.name), displayMode: report.name.count <= 18 ? .large : .inline)
        }
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView(report: UserData().restaurant.profitAndLossReport)
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
