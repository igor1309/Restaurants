//
//  Finance.swift
//
//  Created by Igor Malyarov on 04.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct Finance: View {
    @EnvironmentObject var userData: UserData
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    
                    ForEach(userData.restaurant.reports, id: \.self) {
                        report in
                        ReportCard(report: report)
                    }
                    
                    NavigationLink(destination: MealList()) {
                        Text("Revenue Streams")
                            .foregroundColor(.systemBlue)
                    }
                }
                Spacer()
            }
            .padding(.top)
            .navigationBarTitle("Finance")
        }
    }
}

#if DEBUG
struct Finance_Previews: PreviewProvider {
    static var previews: some View {
        Finance()
            .environmentObject(UserData())
            .preferredColorScheme(.dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
#endif
