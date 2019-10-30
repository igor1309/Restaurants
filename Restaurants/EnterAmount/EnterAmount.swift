//
//  EnterAmount.swift
//
//  Created by Igor Malyarov on 16.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

let buttonSize = (UIScreen.main.bounds.width - CGFloat(2 * 16 + 2 * 8)) / 3

struct TestEnterAmountModally: View {
    @State private var amount = 0.0
    @State private var show = false
    
    var body: some View {
        Button("Edit amount \(amount)",
            action: {
                self.show = true
        })
            .foregroundColor(.systemBlue)
            .sheet(isPresented: self.$show,
                   onDismiss: { print("modal dismissed; \(self.show)") },
                   content: {
                    EnterAmount(amount: self.$amount, prompt: "жду число", isInNavigation: false)
            })
    }
}

struct EnterAmount: View {
    @Environment(\.presentationMode) var presentation
    //  MARK:- сделать возможность Cancel - чтобы отменить ввод
    //    @State private var copy: Double
    @Binding var amount: Double
    
    var prompt: String
    var isInNavigation: Bool
    
    @State private var hasDecimal: Bool
    @State private var strAmount: String
    
    init(amount: Binding<Double>, prompt: String) {
        self._amount = amount
        //        self._copy = State(initialValue: amount.wrappedValue)
        self.prompt = prompt
        self._strAmount = State(initialValue: String(amount.wrappedValue))
        self._hasDecimal = State(initialValue: amount.wrappedValue.truncatingRemainder(dividingBy: 1) > 0)
        self.isInNavigation = true
    }
    
    init(amount: Binding<Double>, prompt: String, isInNavigation: Bool) {
        self._amount = amount
        //        self._copy = State(initialValue: amount.wrappedValue)
        self.prompt = prompt
        self._strAmount = State(initialValue: String(amount.wrappedValue))
        self._hasDecimal = State(initialValue: amount.wrappedValue.truncatingRemainder(dividingBy: 1) > 0)
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
    //                Text("hasDecimal: " + String(hasDecimal))
    //                    .font(.caption)
    //                    .foregroundColor(.secondary)
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
    //                    }                    .padding(.horizontal)
    //                }
    //            }
    //
    //            if !isInNavigation {
    //                Spacer()
    //
    //            Text("\(prompt)")
    //                .font(.largeTitle)
    //                .fontWeight(.bold)
    //                .foregroundColor(.systemOrange)
    //            }
    //        }
    //    }
    
    func handleButtonAction(face: String) {
        switch face {
        case "C":
            strAmount = "0"
            amount = 0.0
            hasDecimal = false
        case "0"..."9":
            if strAmount == "0" {
                strAmount = face
            } else {
                strAmount.append(face)
            }
            amount = Double(strAmount)!
        case ".":
            if hasDecimal {
                print("decimal is already here")
            } else {
                strAmount.append(".")
                hasDecimal = true
            }
        case "⌫":
            if strAmount.count == 1 {
                strAmount = "0"
                amount = 0
            } else {
                if strAmount.last == "." {
                    hasDecimal = false
                }
                strAmount = String(strAmount.dropLast(1))
                amount = Double(strAmount)!
            }
        default:
            return
        }
    }
    
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
                // MARK:- fix this!!!
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
                            self.handleButtonAction(face: "C")
                            //                            self.strAmount = "0"
                            //                            self.amount = 0.0
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
                                    self.handleButtonAction(face: "\(3 * item + number)")
                                    //                                    if self.strAmount == "0" {
                                    //                                        self.strAmount = String(3 * item + number)
                                    //                                    } else {
                                    //                                        self.strAmount.append(String(3 * item + number))
                                    //                                    }
                                    //                                    self.amount = Double(self.strAmount)!
                                }) {
                                    numberButton(face: "\(3 * item + number)")
                                }
                            }
                        }
                    }
                    
                    HStack {
                        Button(action: {
                            self.handleButtonAction(face: "0")
                            //                            if self.strAmount != "0" {
                            //                                self.strAmount.append("0")
                            //                                self.amount = Double(self.strAmount)!
                            //                            }
                        }) {
                            numberButton(face: "0")
                        }
                        
                        Button(action: {
                            self.handleButtonAction(face: ".")
                            //                            if self.hasDecimal {
                            //                                print("decimal is here")
                            //                            } else {
                            //                                self.strAmount.append(".")
                            //                                self.hasDecimal = true
                            //                            }
                        }) {
                            numberButton(face: ".")
                        }
                        
                        Button(action: {
                            self.handleButtonAction(face: "⌫")
                            //                            if self.strAmount.count == 1 {
                            //                                self.strAmount = "0"
                            //                                self.amount = 0
                            //                            } else {
                            //                                if self.strAmount.last == "." {
                            //                                    self.hasDecimal = false
                            //                                }
                            //                                self.strAmount = String(self.strAmount.dropLast(1))
                            //                                self.amount = Double(self.strAmount)!
                            //                            }
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

struct showEnterAmount: View {
    @State private var amount = 4545.4
    @State private var amountInt = 6767
    
    var body: some View {
        Group {
            //            NavigationView {
            //                EnterAmount(amount: Double(amountInt),
            //                            prompt: "введите число")
            //            }
            
            NavigationView {
                EnterAmount(amount: $amount,
                            prompt: "введите число")
            }
            
            EnterAmount(amount: $amount,
                        prompt: "введите число",
                        isInNavigation: false)
        }
    }
}

#if DEBUG
struct showEnterAmount_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            //            TestEnterAmountModally()
            
            showEnterAmount()
        }
    }
    //        ForEach(["iPhone SE", "iPhone XS Max", "iPhone XS"].identified(by: \.self).reversed()) { deviceName in
    //            showForFun()
    //                .previewDevice(PreviewDevice(rawValue: deviceName))
    //                .previewDisplayName(deviceName)
    //        }
}
#endif
