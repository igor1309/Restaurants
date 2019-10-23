//
//  SuperTotalRow.swift
//
//  Created by Igor Malyarov on 31.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct SuperTotalRow: View {
    var title: String
    var detail: String
    var color: Color = .primary
    
    var body: some View {
        BasicRow(title: title, detail: detail, color: color)
            .font(.headline)
    }
}

#if DEBUG
struct SuperTotalRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                SuperTotalRow(title: "Title as title", detail: "€ 62 523")
                
                SuperTotalRow(title: "Title as title", detail: "€ 62 523")
                    .environment(\.sizeCategory, .extraExtraLarge)
            }
        }
        .environmentObject(UserData())
        .preferredColorScheme(.dark)
    }
}
#endif
