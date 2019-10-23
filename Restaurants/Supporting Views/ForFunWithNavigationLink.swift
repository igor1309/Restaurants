//
//  ForFunWithNavigationLink.swift
//
//  Created by Igor Malyarov on 19.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ForFunWithNavigationLink: View {
    @State var title: String
    @State var value: Int
    
    var body: some View {
        NavigationLink(destination: EnterAmountInt(amount: $value, prompt: "Enter " + title)) {
            HStack {
                Text(title)
                Spacer()
                Text("\(value)")
            }
        }
    }
}

#if DEBUG
struct ForFunWithNavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ForFunWithNavigationLink(title: "Enter Number", value: 1)
                .padding()
        }
    }
}
#endif
