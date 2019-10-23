//
//  RestaurantFinanceOneRow.swift
//
//  Created by Igor Malyarov on 17.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct RestaurantFinanceOneRow : View {
    var title: String
    var subtitle: String = ""
    var currency: Currency    
    var amount: Int = -1
    var color: Color = .primary
    var icon: String = "star.circle.fill"
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Image(systemName: icon)
                .frame(minWidth: 24, alignment: .center)
                .foregroundColor(color)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack(alignment: .firstTextBaseline) {
                    Text(title)
                        .foregroundColor(color)
                
                    if amount != -1 {
                        Spacer()
                        Text("\(currency.id) \(amount)")
                            .font(.callout)
                            .foregroundColor(.systemOrange)
                    }
                }

                if subtitle.isNotEmpty {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
        }
    }
}

#if DEBUG
struct RestaurantFinanceOneRow_Previews : PreviewProvider {
    static var previews: some View {
        Form {
            RestaurantFinanceOneRow(title: "CapEx", currency: .euro, amount: 350000)
            RestaurantFinanceOneRow(title: "CapEx", subtitle: "there could be a subtitle sometimes quite long", currency: .euro, amount: 350000)
        }
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
        .environmentObject(UserData())
    }
}
#endif
