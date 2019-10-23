//
//  StreamRow.swift
//
//  Created by Igor Malyarov on 13.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct StreamRow : View {
    var title: String
    var detail: String
    var hasLink: Bool
    
    var body: some View {
        return HStack {
            Text(title)
            
            Spacer()
            
            if hasLink {
                Text(detail)
                    .fontWeight(.light)
            } else {
                Text(detail)
                    .fontWeight(.light)
                    .padding(.trailing)
            }
        }
    }
}


#if DEBUG
struct StreamRow_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            StreamRow(title: "Foodcost", detail: "23%", hasLink: false)
                                .preferredColorScheme(.dark)

                .environment(\.sizeCategory, .extraLarge)
            
            StreamRow(title: "Foodcost", detail: "23%", hasLink: false)
        }
        .previewLayout(.sizeThatFits)
    }
}
#endif
