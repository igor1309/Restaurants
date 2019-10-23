//
//  HorizontalBars2.swift
//  ExtensionsBarsAndCards
//
//  Created by Igor Malyarov on 14.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

public struct HorizontalBars2: View {
    public var bars: [CGFloat]
    public var color: Color = .systemBlue
    
    public var height: CGFloat = 8

    public init(bars: [CGFloat],
                color: Color = .systemBlue,
                height: CGFloat = 8) {
    self.bars = bars
    self.color = color
    self.height = height

    }
    public var barsTotal: CGFloat {
        bars.reduce(0.0, + )
    }
    public var cornerRadius: CGFloat { height / 2 }
    
    public var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .center, spacing: 0) {
                ForEach(self.bars, id: \.self) { bar in
                    RoundedRectangle(cornerRadius: self.cornerRadius, style: .continuous)
                        .frame(width: bar / self.barsTotal * geometry.size.width,
                               height: self.height)
                        .foregroundColor(self.color)
                        .opacity(Double(bar / self.barsTotal))
                }
            }
        }
        .frame(height: height)
    }
}

#if DEBUG
struct HorizontalBars2_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HorizontalBars(bars: [30, 45, 25, 65])
                .padding()
            //                .border(Color.pink)
            
            HorizontalBars2(bars: [30, 45, 25, 65],
                            color: .systemPink)
                .padding()
            //                .border(Color.pink)
            
            HorizontalBars3(bars: [30, 45, 25, 65],
                            color: .systemTeal)
                .padding()
            //                .border(Color.pink)
            
        }
    }
}
#endif
