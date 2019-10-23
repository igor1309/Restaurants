//
//  BasicRow.swift
//  Restaurants
//
//  Created by Igor Malyarov on 22.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI


/// basic and very adaptive row, could be used in any context
/// like in Section header -- NO FONT!!!
struct BasicRow: View {
    var title: String
    var detail: String
    var color: Color = .primary
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(verbatim: title)
            Spacer()
            Text(detail)
        }
        .foregroundColor(color)
    }
}

struct BasicRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                Section(header: BasicRow(title: "Header: Salary, ex Kitchen".uppercased(), detail: 32_555.formattedGrouped), footer: BasicRow(title: "Footer: Salary, ex Kitchen", detail: 32_555.formattedGrouped)) { BasicRow(title: "Row: Salary, ex Kitchen", detail: 32_555.formattedGrouped)
                }
            }.listStyle(GroupedListStyle())
        }
        .environment(\.sizeCategory, .extraLarge)
        .preferredColorScheme(.dark)
    }
}
