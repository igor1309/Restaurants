//
//  OpExItem.swift
//  Meal
//
//  Created by Igor Malyarov on 31.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct OpExItem: Identifiable, Codable, Hashable {
    var id = UUID()
    
//    var restaurant: String = "New Resaurant Name"
    
    var name: String = "New OpEx Name"
    var description: String = "Description of the New OpEx"
    
    var type: OpExType = .salaryExKitchen
    var amount: Int = 12_000
}

enum OpExType: String, Identifiable, CaseIterable, Codable, Hashable {
    case salaryExKitchen = "Salary: ex Kitchen"
    case salaryKitchen = "Salary: Kitchen Staff"
    case rent = "Rent"
    case utilities = "Utilities"
    case marketing = "Marketing"
    case other = "Other Expenses"
//    case new = "New Expenses Type"
    
    var id: String {
        return rawValue
    }
}

extension OpExItem {
    
}
