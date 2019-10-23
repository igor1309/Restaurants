//
//  EnterAmountIntInt.swift
//
//  Created by Igor Malyarov on 29.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct EnterAmountInt: View {
    @Environment(\.presentationMode) var presentation
    //  MARK:- сделать возможность Cancel - чтобы отменить ввод
//    @State private var copy: Int
    @Binding var amount: Int
    
    var prompt: String
    var isInNavigation: Bool
    
    @State private var strAmount: String
    
    init(amount: Binding<Int>, prompt: String) {
        self._amount = amount
//        self._copy = State(initialValue: amount.wrappedValue)
        self.prompt = prompt
        self._strAmount = State(initialValue: String(amount.wrappedValue))
        self.isInNavigation = true
    }
    
    init(amount: Binding<Int>, prompt: String, isInNavigation: Bool) {
        self._amount = amount
//        self._copy = State(initialValue: amount.wrappedValue)
        self.prompt = prompt
        self._strAmount = State(initialValue: String(amount.wrappedValue))
        self.isInNavigation = isInNavigation
    }
    
//    private var supportingPartWithPrompt: some View {
//        Group {
//            HStack {
//                Text("Button Size: " + "\(Int(buttonSize))")
//                    .font(.caption)
//                    .foregroundColor(.secondary)
//                    .padding([.vertical, .leading])
//
//                Text("amount: " + String(amount))
//                    .font(.caption)
//                    .foregroundColor(.secondary)
//
//                Spacer()
//
//                if !isInNavigation {
//                    Button("Done") {
//                        self.presentation.wrappedValue.dismiss()
//                    }
//                    .padding(.horizontal)
//                }
//            }
//            if !isInNavigation {
//                Spacer()
//
//                Text("\(prompt)")
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .foregroundColor(.systemOrange)
//            }
//        }
//    }
    
    var body: some View {
        
        VStack {
            EnterAmountHead(buttonSizeAsString: "\(Int(buttonSize))",
                amountAsString: String(amount),
                isInNavigation: isInNavigation,
                prompt: prompt)
            
//            supportingPartWithPrompt
            
            Spacer()
            
            // MARK:- как сделать группировку по разрядам??
            Text(strAmount)
                .font(.system(size: buttonSize - 40))
                .fontWeight(.thin)
                .lineLimit(nil)
                .multilineTextAlignment(.trailing)
                .allowsTightening(true)
            //  MARK:- как это работает??
            //  UIFontMetrics(forTextStyle: .footnote).default.scaledValue(for: CGFloat(140)
            //            Text("UIFontMetrics..scaledValue: ") + Text("\(Int(UIFontMetrics(forTextStyle: .footnote).scaledValue(for: 100)))")
            
            
            Spacer ()
            
            VStack {
                VStack(spacing: 8) {
                    HStack{
                        Button(action: {
                            self.strAmount = "0"
                            self.amount = 0
                        }) {
                            numberButton(face: "C")
                        }
                        
                        numberButton(face: "")
                        numberButton(face: "")
                    }
                    
                    ForEach(0 ..< 3) { item in
                        HStack {
                            ForEach(1 ..< 4) { number in
                                Button(action: {
                                    if self.strAmount == "0" {
                                        self.strAmount = String(3 * item + number)
                                    } else {
                                        self.strAmount.append(String(3 * item + number))
                                    }
                                    self.amount = Int(self.strAmount)!
                                }) {
                                    numberButton(face: "\(3 * item + number)")
                                }
                            }
                        }
                    }
                    
                    HStack {
                        Button(action: {
                            if self.strAmount != "0" {
                                self.strAmount.append("0")
                                self.amount = Int(self.strAmount)!
                            }
                        }) {
                            numberButton(face: "0")
                        }
                        
                        numberButton(face: "")
                        
                        Button(action: {
                            if self.strAmount.count == 1 {
                                self.strAmount = "0"
                                self.amount = 0
                            } else {
                                self.strAmount = String(self.strAmount.dropLast(1))
                                self.amount = Int(self.strAmount)!
                            }
                        }) {
                            numberButton(face: "⌫")
                        }
                    }
                }
            }
            .padding(.bottom)
                
            .navigationBarTitle(prompt)
//            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                trailing: TrailingButton("Done") {
                    self.presentation.wrappedValue.dismiss()
                }
                .foregroundColor(.accentColor))
        }
    }
}

struct showEnterAmountInt: View {
    @State private var amount = 2345
    
    var body: some View {
        Group {
            NavigationView {
                EnterAmountInt(amount: $amount, prompt: "введите число")
            }
            
            EnterAmountInt(amount: $amount, prompt: "введите число", isInNavigation: false)
        }
    }
}

#if DEBUG
struct showEnterAmountInt_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            showEnterAmountInt()
        }
        //        ForEach(["iPhone SE", "iPhone XS Max", "iPhone XS"].identified(by: \.self).reversed()) { deviceName in
        //            showForFun()
        //                .previewDevice(PreviewDevice(rawValue: deviceName))
        //                .previewDisplayName(deviceName)
        //        }
    }
}
#endif
