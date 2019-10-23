//
//  numberButton.swift
//
//  Created by Igor Malyarov on 07.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct numberButton: View {
    var face: String
    
    var body: some View {
        Text(face)
            .font(.largeTitle)
            .fontWeight(.bold)
            .frame(width: buttonSize,
                   height: buttonSize / 2,
                   alignment: .center)
            .background(face == "" ? Color.clear : Color.purple)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

#if DEBUG
struct numberButton_Previews: PreviewProvider {
    static var previews: some View {
        numberButton(face: "9")
    }
}
#endif
