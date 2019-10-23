//
//  SeatingRow.swift
//
//  Created by Igor Malyarov on 06.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct SeatingRow: View {
    var significantRow: Bool = false
    var subRow: Bool = false
    var title: String
    var detail: String = ""
    var subdetail: String = ""
    var highlight: Bool = true
    
    let width: CGFloat = 44
    
    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .fontWeight(highlight ? .regular : .light)
                .foregroundColor(significantRow ? .systemTeal : (highlight ? .primary : .secondary))
                .padding(.leading, significantRow ? 0 : (subRow ? 64 : 32))
            
            Spacer()
            
            Text(detail)
                .font(significantRow ? .subheadline : .footnote)
                .fontWeight(highlight ? .regular : .light)
            .frame(maxWidth: width, alignment: .trailing)
            
            Text(subdetail)
                .font(significantRow ? .subheadline : .footnote)
                .fontWeight(highlight ? .regular : .light)
                .frame(minWidth: width, maxWidth: width, alignment: .trailing)
        }
        .foregroundColor(highlight ? .primary : .secondary)
    }
}

#if DEBUG
struct SeatingRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 4) {
                SeatingRow(significantRow: true,
                           title: "This is a significantRow Title",
                           detail: "detail",
                           subdetail: "sub")
                
                SeatingRow(
                    title: "This is a no HLT Row Title",
                    detail: "detail",
                    subdetail: "subdtl",
                    highlight: false)
                
                SeatingRow(
                    title: "This is a Row Title",
                    detail: "detail",
                    subdetail: "subdtl")
                
                SeatingRow(
                    subRow: true,
                    title: "This is a subRow Title",
                    detail: "detail",
                    subdetail: "subdtl")
            }
            .padding()
        }
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
#endif
