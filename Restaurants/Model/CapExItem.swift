//
//  CapExItem.swift
//  Restaurants
//
//  Created by Igor Malyarov on 09.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

struct CapExItem: Identifiable, Codable, Hashable {
    var id = UUID()
    
    var name: String = "New CapEx Name"
    var description: String = "Description of the New CapEx or One-time Expense"
    
    var lifetime: Int = 5
    var amount: Int = Int.random(in: 10...1_000) * 1_000
}

extension CapExItem {
    var depreciationPerMonth: Double { lifetime > 0 ? Double(amount) / Double(lifetime) / 12 : 0 }
}
