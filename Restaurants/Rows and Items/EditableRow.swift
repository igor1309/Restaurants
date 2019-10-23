//
//  EditableRow.swift
//
//  Created by Igor Malyarov on 29.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct EditableRow: View {
    var title: String
    var detail: String
    
    @Binding var amount: Double
    
    var body: some View {
        
        NavigationLink(
            destination: EnterAmount(amount: $amount, prompt: title)
        ) {
            HStack {
                Text(title)
                Spacer()
                Text(detail)
                    .fontWeight(.light)
                    .foregroundColor(.systemOrange)
            }
        }
    }
}

struct EditableRowInt: View {
    var title: String
    var detail: String
    
    @Binding var amount: Int
    
    var body: some View {
        
        NavigationLink(
            destination: EnterAmountInt(amount: $amount, prompt: title)
        ) {
            HStack {
                Text(title)
                Spacer()
                Text(detail)
                    .fontWeight(.light)
            }
        }
    }
}


#if DEBUG
struct EditableRow_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            EditableRow(title: "Foodcost",
                        detail: "23%",
                        amount: .constant(8.90))
                .preferredColorScheme(.dark)
                
                .environment(\.sizeCategory, .extraLarge)
            
            EditableRow(title: "Foodcost",
                        detail: "23%",
                        amount: .constant(8.90))
        }
//        .previewLayout(.sizeThatFits)
    }
}
#endif
