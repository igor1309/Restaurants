//
//  CapExBlock.swift
//
//  Created by Igor Malyarov on 31.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CapExBlock: View {
    @EnvironmentObject private var userData: UserData
    var sign: (Int, Int) -> Bool
    
    var body: some View {
        ForEach(userData.restaurant.capex.capexes) { capEx in
                if self.sign(capEx.lifetime, 1) {
                    CapExRow(capEx: capEx)
                }
        }
    }
}

#if DEBUG
struct CapExBlock_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                CapExBlock(sign: >)
                    .environmentObject(UserData())
            }
        }
    }
}
#endif
