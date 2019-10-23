//
//  RestaurantType.swift
//  Restaurants
//
//  Created by Igor Malyarov on 10.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

enum RestaurantType: String, CaseIterable, Codable, Hashable {
    case fineDining = "Fine Dining"
    case fullService = "Full Service Restaurant Dining"
    case counterService = "Counter Service"
    case fastFood = "Fast Food"
    case tableService = "Table Service, Hotel/Club"
    case banquet = "Banquet"
    
    var id: String {
        return rawValue
    }
}
