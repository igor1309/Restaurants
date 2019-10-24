//
//  Card.swift
//
//  Created by Igor Malyarov on 04.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CardView: ViewModifier {
    var borderColor: Color = .systemGray
    var cornerRadius: CGFloat = 16
    
    func body(content: Content) -> some View {
        content
            .padding()
            .overlay(RoundedRectangle(cornerRadius: cornerRadius,
                                      style: .continuous)
                .stroke()
                .opacity(0.3)
                .foregroundColor(borderColor))
        
    }
}

struct Card<Content: View>: View {
    var title: String
    var subtitle: String
    var trunk: Content
    
    var borderColor: Color = .systemGray
    var cornerRadius: CGFloat = 16
    
    init(title: String, subtitle: String, trunk: Content, borderColor: Color = .systemGray, cornerRadius: CGFloat = 16) {
        self.title = title
        self.subtitle = subtitle
        self.trunk = trunk
        self.borderColor = borderColor
        self.cornerRadius = cornerRadius
    }
    
    //    init(title: String, subtitle: String, trunk: Content, cornerRadius: CGFloat) {
    //        self.title = title
    //        self.subtitle = subtitle
    //        self.trunk = trunk
    //        self.borderColor = .systemGray
    //        self.cornerRadius = cornerRadius
    //    }
    //
    //    init(title: String, subtitle: String, trunk: Content) {
    //        self.title = title
    //        self.subtitle = subtitle
    //        self.trunk = trunk
    //        self.borderColor = .systemGray
    //        self.cornerRadius = 16
    //    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.headline)
                .foregroundColor(.systemTeal)
            
            Text(subtitle)
                .font(.footnote)
                .foregroundColor(Color.secondary)
            
            trunk
                .padding(.top, 6)
        }
        .modifier(CardView(borderColor: borderColor,
                           cornerRadius: cornerRadius))
            .padding([.horizontal, .bottom])
    }
}

#if DEBUG
struct Card_Previews: PreviewProvider {
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
        return
            Group {
                NavigationView {
                    Card(title: "This is a title",
                         subtitle: "This is a long or not so long subtitle",
                         trunk: trunk,
                         borderColor: .systemPurple,
                         cornerRadius: 32
                    )
                }
                
                NavigationView {
                    Card(title: "This is a title",
                         subtitle: "This is a long or not so long subtitle",
                         trunk: Text("And here goes the trunk. Could be quite big thing of its own."),
                         borderColor: .orange,
                         cornerRadius: 8
                    )
                }
            }
            .environment(\.colorScheme, .dark)
        //        .environment(\.sizeCategory, .extraLarge)
    }
}
#endif
