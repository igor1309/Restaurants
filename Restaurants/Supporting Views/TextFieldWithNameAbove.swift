//
//  TextFieldWithNameAbove.swift
//
//  Created by Igor Malyarov on 14.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct TextFieldWithNameAbove : View {
    let name: String
    @Binding var textInField: String
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(name).padding(.bottom, 0)
                
                Spacer()
                
                Button(action: {
                    self.textInField = self.randomString(length: 15)
                }) {
                    Text("fill sample data")
                        .font(.caption)
                }
            }
            TextField(name, text: $textInField)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
                .lineLimit(nil)
                .padding(.leading)
        }
    }
}

struct showTextFieldWithNameAbove : View {
    @State private var textInField = "ghghdj jdf"
    
    var body: some View {
        TextFieldWithNameAbove(name: "Name:", textInField: $textInField)
    }
}

#if DEBUG
struct TextFieldWithNameAbove_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            showTextFieldWithNameAbove()
                .padding()
            
            ZStack {
                Color
                    .black
                    .frame(width: 414, height: 126)
                    .background(Color.black)
                
                showTextFieldWithNameAbove()
                    .padding()
                                    .preferredColorScheme(.dark)

            }
        }
        .previewLayout(.sizeThatFits)
    }
}
#endif

//#if DEBUG
//struct Testing_Previews : PreviewProvider {
//    static var previews: some View {
//        Group {
//
//            TextFieldUsage()
//                .padding()
//
//            ZStack {
//                Color
//                    .black
//                    .frame(width: 414, height: 63)
//                    .background(Color.black)
//
//                TextFieldUsage()
//                    .padding()
//                                    .preferredColorScheme(.dark)

//            }
//        }
//        .previewLayout(.sizeThatFits)
//    }
//}
//#endif
