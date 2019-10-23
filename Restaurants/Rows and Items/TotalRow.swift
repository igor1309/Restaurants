//
//  TotalRow.swift
//
//  Created by Igor Malyarov on 31.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct TotalRow: View {
    var title: String
    var detail: String
    var color: Color = .primary
    
    var body: some View {
        BasicRow(title: title, detail: detail, color: color)
            .font(.subheadline)
    }
}

#if DEBUG
struct TotalRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                TotalRow(title: "Title as title", detail: "€ 62 523")
                TotalRow(title: "Title as title", detail: "€ 62 523")
            }
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
#endif
