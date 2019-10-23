//
//  SeatingCard.swift
//  CardModifier
//
//  Created by Igor Malyarov on 13.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct SeatingCard: View {
    @EnvironmentObject private var userData: UserData
    
    var body: some View {
        NavigationView {
            VStack {
                Card(title: "Seating",
                     subtitle: "Inside and Outside Seating",
                     trunk: SeatingTrunk(restaurant: userData.restaurant),
                     cornerRadius: 8)
                
                Spacer()
            }
                
            .navigationBarTitle("Seating")
        }
    }
}

#if DEBUG
struct SeatingCard_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SeatingCard()
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .contentShape(Rectangle())
    }
}
#endif

