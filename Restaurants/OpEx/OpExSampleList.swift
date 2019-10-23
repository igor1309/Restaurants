//
//  OpExSampleList.swift
//  Restaurants
//
//  Created by Igor Malyarov on 09.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct OpExSampleList: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        NavigationView {
            List {
                ForEach(sampleOpex.types, id: \.self) { type in
                    
                    Section(header: Text(type.id.uppercased())
                        .foregroundColor(.primary)) {
                            
                            ForEach(sampleOpex.opexes
                                .filter({ $0.type == type })
                                .sorted(by: { $0.amount > $1.amount }), id: \.self) { opEx in
                                    
                                    OpExSampleRow(opEx: opEx)
                            }
                    }
                }
            }
            .listStyle(GroupedListStyle())
                
            .navigationBarTitle("Select Sample")
                
            .navigationBarItems(trailing: TrailingButtonSFSymbol("checkmark") {
                self.presentation.wrappedValue.dismiss()
            })
        }
    }
}

struct OpExSampleList_Previews: PreviewProvider {
    static var previews: some View {
        OpExSampleList()
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
    }
}
