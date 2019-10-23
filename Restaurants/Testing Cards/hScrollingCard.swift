//
//  hScrollingCard.swift
//  ExtensionsBarsAndCards
//
//  Created by Igor Malyarov on 14.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

//  Same to Card put wuth different padding to fit ScrollView
public struct hScrollingCard<Content: View>: View {
    public var title: String
    public var subtitle: String
    public var trunk: Content
    
    public var borderColor: Color = .systemGray
    public var cornerRadius: CGFloat = 16
    
    public init(title: String, subtitle: String, trunk: Content, borderColor: Color, cornerRadius: CGFloat) {
        self.title = title
        self.subtitle = subtitle
        self.trunk = trunk
        self.borderColor = borderColor
        self.cornerRadius = cornerRadius
    }
    
    public init(title: String, subtitle: String, trunk: Content, cornerRadius: CGFloat) {
        self.title = title
        self.subtitle = subtitle
        self.trunk = trunk
        self.borderColor = .systemGray
        self.cornerRadius = cornerRadius
    }
    
    public init(title: String, subtitle: String, trunk: Content) {
        self.title = title
        self.subtitle = subtitle
        self.trunk = trunk
        self.borderColor = .systemGray
        self.cornerRadius = 16
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            
            Text(subtitle)
                .font(.footnote)
                .foregroundColor(Color.secondary)
            
            trunk
                .padding(.top, 6)
        }
        .contentShape(Rectangle())
        .modifier(CardView(borderColor: borderColor,
                           cornerRadius: cornerRadius))
            .padding(.vertical, 1)
            
            .padding(.trailing)
    }
}


#if DEBUG
struct hScrollingCard_Previews: PreviewProvider {
    static var previews: some View {
        let trunk: some View = VStack(alignment: .leading) {
            ForEach(0 ..< 5) { item in
                VStack(alignment: .leading) {
                    Text("Hello Worldd gsf hfgh ssgfgj ghj gj hfghg ggh")
                    HStack {
                        Text("Hello World")
                            .font(.subheadline)
                        Spacer()
                        Text("Hello World").foregroundColor(Color.orange)
                    }
                }
                .padding(.bottom, 3)
            }
        }
        return Group {
            hScrollingCard(title: "This is a title",
                           subtitle: "This is a long or not so long subtitle",
                           trunk: trunk,
                           borderColor: .systemPurple,
                           cornerRadius: 32
            )
                .border(Color.pink)
            
            hScrollingCard(title: "This is a title",
                           subtitle: "This is a long or not so long subtitle",
                           trunk: Text("And here goes the trunk. Could be quite big thing of its own."),
                           borderColor: .orange,
                           cornerRadius: 8
            )
        }
    }
}
#endif
