//
//  SalesRowWithBar.swift
//
//  Created by Igor Malyarov on 05.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct SalesRowWithBar: View {
    var bar: CGFloat
    var bars: [CGFloat]
    
    var height: CGFloat = 9
    var cornerRadius: CGFloat = 3
    var colorMore: Color = .systemGray
    var colorLess: Color = .systemYellow
    var fill: Bool = true
    
    var title: String
    var detail: String
    var subdetail: String = ""
    var highlight: Bool = false
    
    var body: some View {
        HStack(alignment: .center) {
            Text(title)
                .font(.subheadline)
                .fontWeight(highlight ? .regular : .light)
                .frame(minWidth: 75, alignment: .leading)
                .layoutPriority(9)
            
            HStack(alignment: .bottom) {
                HorizontalBar(bar: bar,
                              bars: bars,
                              height: height,
                              cornerRadius: cornerRadius,
                              colorMore: colorMore,
                              colorLess: colorLess,
                              fill: fill)
                    .frame(minWidth: 50,
                           idealWidth: 95,
                           maxWidth: 95,
                           alignment: .leading)
            }
            .layoutPriority(9)
            
            Spacer()
            
            Text(detail)
                .font(.footnote)
                .fontWeight(highlight ? .regular : .light)
                .layoutPriority(9)
            
            Text(subdetail)
                .font(.footnote)
                .fontWeight(highlight ? .regular : .light)
                .frame(minWidth: 50, alignment: .trailing)
                .layoutPriority(9)
        }
    }
}

#if DEBUG
struct SalesRowWithBar_Previews: PreviewProvider {
    static var previews: some View {
        var bars: [CGFloat] {
            [CGFloat(30),
             CGFloat(25),
             CGFloat(15)
            ]
        }
        
        return VStack {
            SalesRowWithBar(bar: CGFloat(33),
                            bars: bars,
                            title: "This is a Title",
                            detail: "detail here",
                            subdetail: "subdetail")
            
            SalesRowWithBar(bar: CGFloat(23),
                            bars: bars,
                            height: 4,
                            cornerRadius: 2,
                            colorLess: .systemRed,
                            title: "This is a Title",
                            detail: "detail here",
                            subdetail: "subdetail",
                            highlight: true)
            
            SalesRowWithBar(bar: CGFloat(30),
                            bars: bars,
                            height: 16,
                            cornerRadius: 8,
                            colorMore: .systemBlue,
                            fill: false,
                            title: "Title",
                            detail: "detail",
                            subdetail: "subdetail",
                            highlight: false)
            
            SalesRowWithBar(bar: CGFloat(30),
                            bars: bars,
                            height: 16,
                            cornerRadius: 4,
                            colorMore: .systemPink,
                            fill: false,
                            title: "Title",
                            detail: "detail",
                            subdetail: "subdetail",
                            highlight: false)
        }
    }
}
#endif
