//
//  ExtensionColor.swift
//
//  Created by Igor Malyarov on 24.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

extension Color {
    init(_ hex: UInt32, opacity:Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

let testColor = Color(0xC23B64)


struct ExtensionColor: View {
    var body: some View {
        VStack {
            Text("testColor")
                .foregroundColor(.pink)
            
            Text("testColor")
                .foregroundColor(testColor)
            
            Rectangle()
                .frame(width:150, height: 75)
                .foregroundColor(testColor)
        }
    }
}

#if DEBUG
struct ExtensionColor_Previews: PreviewProvider {
    static var previews: some View {
        ExtensionColor()
    }
}
#endif
