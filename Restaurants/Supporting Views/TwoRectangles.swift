//
//  TwoRectangles.swift
//
//  Created by Igor Malyarov on 19.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct TwoRectangles: View {
    var a: Double
    var b: Double
    
    let h: CGFloat = 12
    let cornerRadius: CGFloat = 6
    
    private var geometryV: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 2) {
                RoundedRectangle(cornerRadius: self.cornerRadius)
                    .frame(width: CGFloat(self.a / (self.a + self.b)) * geometry.size.width, height: self.h)
                    .foregroundColor(.systemRed)
                
                RoundedRectangle(cornerRadius: self.cornerRadius)
                    .frame(width: CGFloat(self.b / (self.a + self.b)) * geometry.size.width, height: self.h)
                    .foregroundColor(.systemBlue)
            }
            .padding(.horizontal, 0)
        }
    }
    
    private var geometryH: some View {
        GeometryReader { geometry in
            HStack(alignment: .center, spacing: 0) {
                RoundedRectangle(cornerRadius: self.cornerRadius)
                    .frame(width: CGFloat(self.a / (self.a + self.b)) * geometry.size.width, height: self.h)
                    .foregroundColor(.systemRed)
                
                RoundedRectangle(cornerRadius: self.cornerRadius)
                    .frame(width: CGFloat(self.b / (self.a + self.b)) * geometry.size.width, height: self.h)
                    .foregroundColor(.systemBlue)
            }
            .padding(.vertical, 0)
        }
    }
    
    var body: some View {
        HStack(alignment: .top) {
            VStack {
                geometryV
                // geometryH
            }
        }
    }
}

#if DEBUG
struct TwoRectangles_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            TwoRectangles(a: 200, b: 800)
        }
        .padding()
    }
}
#endif
