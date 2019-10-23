//
//  Model.swift
//  Restaurants
//
//  Created by Igor Malyarov on 18.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ModelYear: Identifiable, Codable, Hashable {
    var id: Int
    var discount: Double = 0.30
    
    init(id: Int, discount: Double) {
        self.id = id
        self.discount = discount
    }
}

struct Model {
    var restaurant: Restaurant
    var modelYears: [ModelYear]
}

extension Model {
    var discountedRevenues: [Double] {
        modelYears.map {
            (1 - $0.discount) * restaurant.sales.revenuePerMonth
        }
    }
    var discountedRevenue: Double { discountedRevenues.reduce(0, { $0 + $1 }) }
    
    var discountedEBITs: [Double] {
        modelYears.map {
            (1 - $0.discount) * restaurant.sales.revenuePerMonth - restaurant.sales.foodcostPerMonth - restaurant.opExPerMonth - restaurant.depreciationPerMonth
        }
    }
    var discountedEBIT: Double { discountedEBITs.reduce(0, { $0 + $1 }) }
    
    var discountedTaxs: [Double] {
        modelYears.map {
            ((1 - $0.discount) * restaurant.sales.revenuePerMonth - restaurant.sales.foodcostPerMonth - restaurant.opExPerMonth - restaurant.depreciationPerMonth) * restaurant.taxRate
        }
    }
    var discountedTax: Double { discountedTaxs.reduce(0, { $0 + $1 }) }
    
    var discountedProfits: [Double] {
        modelYears.map {
            ((1 - $0.discount) * restaurant.sales.revenuePerMonth - restaurant.sales.foodcostPerMonth - restaurant.opExPerMonth - restaurant.sales.revenuePerMonth) * (1 - restaurant.taxRate)
        }
    }
    var discountedProfit: Double { discountedProfits.reduce(0, { $0 + $1 }) }
    
    var discountedCashFlowEstimates: [Double] {
        modelYears.map {
            ((1 - $0.discount) * restaurant.sales.revenuePerMonth - restaurant.sales.foodcostPerMonth - restaurant.opExPerMonth - restaurant.sales.revenuePerMonth) * (1 - restaurant.taxRate) + restaurant.depreciationPerMonth
        }
    }
    var discountedCashFlowEstimate: Double { discountedCashFlowEstimates.reduce(0, { $0 + $1 }) }
}
