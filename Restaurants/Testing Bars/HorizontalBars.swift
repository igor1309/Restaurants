//
//  HorizontalBars.swift
//
//  Created by Igor Malyarov on 04.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

public struct HorizontalBars: View {
    public var bars: [CGFloat]
    public var color: Color
    public var height: CGFloat
    public var verticalSpacing: CGFloat
    
    public init(bars: [CGFloat],
                color: Color = .systemBlue,
                height: CGFloat = 8,
                verticalSpacing: CGFloat = 2) {
        self.bars = bars
        self.color = color
        self.height = height
        self.verticalSpacing = verticalSpacing
    }
    
    var barsMax: CGFloat {
        bars.max() ?? 1
    }
    var cornerRadius: CGFloat { height / 2 }
    
    public var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: self.verticalSpacing) {
                ForEach(self.bars, id: \.self) { bar in
                    RoundedRectangle(cornerRadius: self.cornerRadius, style: .continuous)
                        .frame(width: bar / self.barsMax * geometry.size.width,
                               height: self.height)
                        .foregroundColor(self.color)
                        .opacity(Double(bar / self.barsMax))
                }
            }
        }
        .frame(height: height * CGFloat(bars.count) + verticalSpacing * CGFloat(bars.count - 1))
    }
}

#if DEBUG
struct HorizontalBars_Previews: PreviewProvider {
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
