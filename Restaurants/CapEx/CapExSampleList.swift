//
//  CapExSampleList.swift
//  Restaurants
//
//  Created by Igor Malyarov on 09.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CapExSampleList: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        NavigationView {
            List {
                ForEach(sampleCapex.lifetimes, id: \.self) { lifetime in
                    
                    Section(header: Text("Lifetime: \(lifetime.formattedGrouped)".uppercased())
                        .foregroundColor(.primary)) {
                            
                            ForEach(sampleCapex.capexes
                                .filter({ $0.lifetime == lifetime })
                                .sorted(by: { $0.amount > $1.amount }), id: \.self) { capEx in
                                    
                                    CapExSampleRow(capEx: capEx)
                            }
                    }
                }
            }
            .listStyle(GroupedListStyle())
                
            .navigationBarTitle("Select Sample")
                
            .navigationBarItems(trailing:
                TrailingButtonSFSymbol("checkmark") {
                    self.presentation.wrappedValue.dismiss() })
        }
    }
}

struct CapExSampleList_Previews: PreviewProvider {
    static var previews: some View {
        CapExSampleList()
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
    }
}
