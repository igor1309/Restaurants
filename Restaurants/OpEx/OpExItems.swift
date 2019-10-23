//
//  OpExItems.swift
//
//  Created by Igor Malyarov on 31.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct OpExItems: View {
    @EnvironmentObject private var userData: UserData
    var type: OpExType
    
    var body: some View {
        ForEach(userData.restaurant.opex.opexes
            .filter { $0.type == self.type }) { opEx in
                
                OpExRow(opEx: opEx)
        }
    }
}

#if DEBUG
struct OpExItems_Previews: PreviewProvider {
    static var previews: some View {
        OpExItems(type: .salaryExKitchen)
            .environmentObject(UserData())
    }
}
#endif
