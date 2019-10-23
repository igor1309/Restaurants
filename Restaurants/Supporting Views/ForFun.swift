//
//  FoFun.swift
//
//  Created by Igor Malyarov on 16.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ForFun: View {
//    @Environment(\.isPresented) var isPresented //: Binding<Bool>?
    
    //  MARK: - ДОДЕЛАТЬ КАК В AmountInput:
    //  https://stackoverflow.com/questions/57060854/how-keep-a-copy-of-original-binding-value
//    init(amount: Binding<Int>) {
//        self.$amount = amount
//        self.$$copy = State(initialValue: amount.wrappedValue)
//    }
//
    @Binding var amount: Int
    
    var prompt: String
    
    func increase(value: Int, by: Int) -> Int {
        value * 10 + by
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Button Size: " + "\(Int(buttonSize))")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.vertical)
                
                Spacer()
                
                Button(action: {
//                    self.isPresented?.value = false
                }) {
                    Image(systemName: "xmark.circle")
                        .foregroundColor(.secondary)
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            Text("\(prompt)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.systemOrange)
            
            Spacer()
            
            Text("\(amount)")
                .font(.system(size: buttonSize - 40))
                .fontWeight(.thin)
                .multilineTextAlignment(.trailing)
                .allowsTightening(true)
            //  MARK:- как это работает??
            //  UIFontMetrics(forTextStyle: .footnote).default.scaledValue(for: CGFloat(140)
//            Text("UIFontMetrics..scaledValue: ") + Text("\(Int(UIFontMetrics(forTextStyle: .footnote).scaledValue(for: 100)))")

            
            Spacer ()
 /*
            VStack {
                VStack(spacing: 8) {
                    ForEach(0 ... 2) { item in
                        HStack {
                            ForEach(1 ... 3) { number in
                                Button(action: {
                                    self.amount = self.increase(value: self.amount, by: 3 * item + number)
                                }) {
                                    bigNumberButton(face: "\(3 * item + number)", empty: false)
                                }
                            }
                        }
                    }
                    
                    HStack {
                        bigNumberButton(face: "", empty: true)
                        
                        Button(action: {
                            self.amount = self.increase(value: self.amount, by: 0)
                        }) {
                            bigNumberButton(face: "0", empty: false)
                        }
                        
                        Button(action: {
                            self.amount = self.amount / 10
                        }) {
                            bigNumberButton(face: "⌫", empty: false)
                        }
                    }
                }
            }
            .padding(.bottom)
 */
        }
    }
}

struct bigNumberButton : View {
    var face: String
    var empty: Bool
    
    var body: some View {
        return Text(face)
            .font(.largeTitle)
            .fontWeight(.bold)
            .frame(width: buttonSize,
                   height: buttonSize / 2,
                   alignment: .center)
            .background(empty ? Color.clear : Color.purple)
            .foregroundColor(.white)
            .cornerRadius(16)
    }
}

struct showForFun : View {
    @State private var amount = 4545
    
    var body: some View {
        ForFun(amount: $amount, prompt: "введите число")
    }
}

#if DEBUG
struct showForFun_Previews : PreviewProvider {
    static var previews: some View {
        
        showForFun()
        
//        ForEach(["iPhone SE", "iPhone XS Max", "iPhone XS"].identified(by: \.self).reversed()) { deviceName in
//            showForFun()
//                .previewDevice(PreviewDevice(rawValue: deviceName))
//                .previewDisplayName(deviceName)
//        }
    }
}
#endif
