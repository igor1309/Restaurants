//
//  EnterAmountHead.swift
//  Restaurants
//
//  Created by Igor Malyarov on 07.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct EnterAmountHead: View {
    @Environment(\.presentationMode) var presentation
    var buttonSizeAsString: String
    var amountAsString: String
    var isInNavigation: Bool
    var prompt: String
    
    var body: some View {
        Group {
            HStack {
                Text("Button Size: " + buttonSizeAsString)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding([.vertical, .leading])
                
                Text("amount: " + amountAsString)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                if !isInNavigation {
                    Button("Done") {
                        self.presentation.wrappedValue.dismiss()
                    }
                    .padding(.horizontal)
                }
            }
            if !isInNavigation {
                Spacer()
                
                Text("\(prompt)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.systemOrange)
            }
        }
    }
}

#if DEBUG
struct EnterAmountHead_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EnterAmountHead(buttonSizeAsString: "144",
                            amountAsString: String(45762),
                            isInNavigation: false,
                            prompt: "Enter amount")

            EnterAmountHead(buttonSizeAsString: "144",
                            amountAsString: String(45762),
                            isInNavigation: true,
                            prompt: "Enter amount")
        }
    }
}
#endif
