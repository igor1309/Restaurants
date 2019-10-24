//
//  ReportCard.swift
//  Restaurants
//
//  Created by Igor Malyarov on 24.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ReportCard: View {
    @EnvironmentObject var userData: UserData
    var report: Report
    
    var body: some View {
        Card(title: report.name,
             subtitle: report.description,
             trunk: Group {
                ForEach(report.lines, id: \.self) { line in
                    PandLRow(title: line.title,
                             subtitle: line.subtitle,
                             detail: line.detail,
                             subdetail: line.subdetail)
                        .lineLimit(3)
                }},
             borderColor: .gray,
             cornerRadius: 8)
    }
}


struct ReportCard_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VStack {
                ReportCard(report: UserData().restaurant.cashEarningsReport)
                Spacer()
            }
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
