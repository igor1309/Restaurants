//
//  TextFieldWithNameAndCompletion.swift
//
//  Created by Igor Malyarov on 25.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct TextFieldWithNameAndCompletion: View {
    let title: String
    let name: String
    @Binding var textInField: String
    let closure: (Bool) -> Void
    
    var body: some View {
        HStack {
            Text(title).padding(.bottom, 0)
            
            TextField(name, text: $textInField, onEditingChanged: closure)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .lineLimit(nil)
        }
    }
}

struct TextFieldWithNameAndCompletionUsage : View {
    @State private var textInField = "ghghdj jdf"
    
    var body: some View {
        TextFieldWithNameAndCompletion(title: "Title", name: "Title Name:", textInField: $textInField, closure: validate)
    }
    
    func validate(_ flag: Bool) -> Void {
        print(flag)
    }
}



#if DEBUG
struct TextFieldWithNameAndCompletionUsage_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            
            TextFieldWithNameAndCompletionUsage()
                .padding()
            
            TextFieldWithNameAndCompletionUsage()
                .padding()
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
#endif
