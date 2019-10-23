//
//  TextFieldWithName.swift
//
//  Created by Igor Malyarov on 13.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct TextFieldWithName : View {
    let title: String
    let name: String
    @Binding var textInField: String
    
    init(name: String, textInField: Binding<String>) {
        self.title = name
        self.name = name
        self._textInField = textInField
    }
    
    init(title: String, name: String, textInField: Binding<String>) {
        self.title = title
        self.name = name
        self._textInField = textInField
    }
    
    var body: some View {
        HStack {
            Text(title).padding(.bottom, 0)
            
            TextField(name, text: $textInField)
                ///.textFieldStyle(RoundedBorderTextFieldStyle())
                .lineLimit(nil)
        }
    }
}

struct TextFieldWithNameUsage : View {
    @State private var textInField = "ghghdj jdf"
    
    var body: some View {
        TextFieldWithName(name: "Name:", textInField: $textInField)
    }
}



#if DEBUG
struct TextFieldWithNameUsage_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            
            TextFieldWithNameUsage()
                .padding()
            
            TextFieldWithNameUsage()
                .padding()
                .preferredColorScheme(.dark)
        }
//        .previewLayout(.sizeThatFits)
    }
}
#endif
