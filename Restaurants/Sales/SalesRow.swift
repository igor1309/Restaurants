//
//  SalesRow.swift
//  CardModifier
//
//  Created by Igor Malyarov on 04.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct SalesRow: View {
    var title: String
    var detail: String
    var subdetail: String = ""
    var highlight: Bool = false
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(title)
                .font(.subheadline)
                .fontWeight(highlight ? .regular : .light)
            
            Spacer()
            
            Text(detail)
                .font(.footnote)
                .fontWeight(highlight ? .regular : .light)
            
            Text(subdetail)
                .font(.footnote)
                .fontWeight(highlight ? .regular : .light)
                .frame(minWidth: 50, alignment: .trailing)
        }
    }
}

#if DEBUG
struct SalesRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VStack {
                SalesRow(title: "Title // row with highlight",
                         detail: "detail",
                         subdetail: "subdetail",
                         highlight: true)
                
                SalesRow(title: "Title",
                         detail: "detail",
                         subdetail: "subdetail",
                         highlight: false)
            }
        }
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
#endif
