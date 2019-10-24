//
//  PandLRow.swift
//  CardModifier
//
//  Created by Igor Malyarov on 04.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct PandLRow: View {
    var title: String
    var subtitle: String = ""
    var detail: String
    var subdetail: String = ""
//    var highlight: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack(alignment: .firstTextBaseline) {
                Text(title.isEmpty ? "——————" : title)
                    .font(.subheadline)
                    .opacity(title.isEmpty ? 0.2 : 1.0)
                
                Spacer()
                
                Text(detail)
                    .font(.footnote)
//                    .fontWeight(highlight ? .regular : .light)
            }
            
            if subtitle.isNotEmpty || subdetail.isNotEmpty {
                HStack(alignment: .firstTextBaseline) {
                    Text(subtitle)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineSpacing(0)
                    
                    Spacer()
                    
                    Text(subdetail)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    //  .underline(highlight, color: myColor)
                }
            }
        }
        .padding(.bottom, 3)
    }
}

#if DEBUG
struct PandLRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                PandLRow(title: "Title, highlight: true",
                         subtitle: "Subtitle",
                         detail: "detail",
                         subdetail: "subdetail"
//                    ,
//                         highlight: true
                )
                
                PandLRow(title: "Title: highlight: false",
                         subtitle: "Subtitle",
                         detail: "detail",
                         subdetail: "subdetail"
//                    ,
//                         highlight: false
                )

                PandLRow(title: "",
                         subtitle: "",
                         detail: "",
                         subdetail: ""
//                    ,
//                         highlight: false
                )

                PandLRow(title: "Title and no Subtitle",
                         subtitle: "",
                         detail: "no subdetail",
                         subdetail: ""
//                    ,
//                         highlight: false
                )
            }
            .listStyle(GroupedListStyle())
        }
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
#endif
