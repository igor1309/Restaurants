//
//  RestaurantFinanceRow.swift
//
//  Created by Igor Malyarov on 17.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct RestaurantFinanceRow : View {
    var title: String
    var subtitle: String
    var currency: Currency
    var amount: Int
    var color: Color = .primary
    var icon: String = "star.circle.fill"
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .frame(minWidth: 24, alignment: .center)
                .foregroundColor(color)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.light)
                    .foregroundColor(color)
                
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text("\(currency.id) \(amount)")
                .font(.subheadline)
                .fontWeight(.light)
        }
    }
}

#if DEBUG
struct RestaurantFinanceRow_Previews : PreviewProvider {
    static var previews: some View {
        RestaurantFinanceRow(title: "CapEx", subtitle: "Overall Budget", currency: .euro, amount: 350000)
        
    }
}
#endif
