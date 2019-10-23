//
//  Finance.swift
//
//  Created by Igor Malyarov on 04.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct Finance: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    
                    CashFlowCard()
                    
                    ProfitAndLoss4Parts()
                    
                    ProfitAndLossStatement()
                    
                    ProfitAndLossExtras()
                    
                    OpExCard()
                    
                    NavigationLink(destination: MealList()) {
                        Text("Revenue Streams")
                            .foregroundColor(.systemBlue)
                    }
                }
                Spacer()
            }
            .navigationBarTitle("Finance")
        }
    }
}

#if DEBUG
struct Finance_Previews: PreviewProvider {
    static var previews: some View {
        Finance()
            .environment(\.sizeCategory, .extraLarge)
            .preferredColorScheme(.dark)
            .environmentObject(UserData())
    }
}
#endif
