//
//  Restaurant.swift
//
//  Created by Igor Malyarov on 16.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct Restaurant: Identifiable, Codable, Hashable {
    var id = UUID()
    
    var name: String = "название ресторана"
    var projectName: String = "название проекта"
    
    var type: RestaurantType = .fullService
    var city = "город"
    
    var concept: String = "концепция"
    var description: String = "описание"
    var comment: String = "комментарий про ресторан"
    var status: Status = .idea
    
    var budget: Int = 100000
    var currency: Currency = .euro
    
    var insideSeating: Int = 80
    var outsideSeating: Int = 60
    
    var area: Int = 120
    var kitchenArea: Int = 60
    var totalArea: Int = 180
    
    var sales = Sales(meals: [])
    var opex = Opex(opexes: [])
    var capex = Capex(capexes: [])
    var kpi = KPI(kpis: [])
    
    var taxRate: Double = 0.30
    
    var modificationDate: Date = Date()
}

extension Restaurant {
    init(from restaurant: Restaurant) {
        self.name = restaurant.name
        self.projectName = restaurant.projectName
        
        self.type = restaurant.type
        self.city = restaurant.city

        self.concept = restaurant.concept
        self.description = restaurant.description
        self.comment = restaurant.comment
        self.status = restaurant.status

        self.budget = restaurant.budget
        self.currency = restaurant.currency

        self.insideSeating = restaurant.insideSeating
        self.outsideSeating = restaurant.outsideSeating

        self.area = restaurant.area
        self.kitchenArea = restaurant.kitchenArea
        self.totalArea = restaurant.totalArea

        self.sales = restaurant.sales
        self.opex = restaurant.opex
        self.capex = restaurant.capex
        self.kpi = restaurant.kpi

        self.taxRate = restaurant.taxRate
    }
}

extension Restaurant {
    init(projectName: String) {
        self.init()
        self.projectName = projectName
    }
    
    init(name: String, projectName: String) {
        self.init()
        self.name = name
        self.projectName = projectName
    }
}

extension Restaurant {
    var investment: Double { capex.capexes.reduce(0, { $0 + Double($1.amount) }) }
    
    //  MARK: может быть опция — включать kitchen salary в себестоимость или нет
    var grossProfitPerMonth: Double { sales.revenuePerMonth - sales.cogsPerMonth - salaryKitchenPerMonth}
    
    var salaryPerMonth: Double {
        let salary = opex.opexes.filter { $0.type == .salaryKitchen || $0.type == .salaryExKitchen }
        return Double(salary.reduce(0, { $0 + $1.amount }))
    }
    var salaryKitchenPerMonth: Double {
        let salary = opex.opexes.filter { $0.type == .salaryKitchen }
        return Double(salary.reduce(0, { $0 + $1.amount }))
    }
    var salaryExKitchenPerMonth: Double {
        let salary = opex.opexes.filter { $0.type == .salaryExKitchen }
        return Double(salary.reduce(0, { $0 + $1.amount }))
    }
    
    var primeCostPerMonth: Double { sales.foodcostPerMonth + salaryPerMonth }
    
    var opExPerMonth: Double { Double(opex.opexes.reduce(0, { $0 + $1.amount})) }
    
    var capEx: Double { Double(capex.capexes.reduce(0, { $0 + $1.amount})) }
    
    //  https://pos.toasttab.com/blog/restaurant-profit-and-loss-statement
    var occupancyCostsPerMonth: Double {
        let rent = opex.opexes.filter { $0.type == .rent }
        return Double(rent.reduce(0, { $0 + $1.amount }))
    }
    var rentPerMonth: Double { occupancyCostsPerMonth }
    
    var utilitiesPerMonth: Double {
        let utilities = opex.opexes.filter { $0.type == .utilities }
        return Double(utilities.reduce(0, { $0 + $1.amount }))
    }
    
    var marketingPerMonth: Double {
        let marketing = opex.opexes.filter { $0.type == .marketing }
        return Double(marketing.reduce(0, { $0 + $1.amount }))
    }
    
    var otherOpExPerMonth: Double {
        let otherOpEx = opex.opexes.filter { $0.type == .other }
        return Double(otherOpEx.reduce(0, { $0 + $1.amount }))
    }
    
    var depreciationPerMonth: Double { capex.capexes.reduce(0, { $0 + $1.depreciationPerMonth }) }
    
    var ebitPerMonth: Double { sales.revenuePerMonth - sales.foodcostPerMonth - opExPerMonth - depreciationPerMonth }
    
    var ebitdaPerMonth: Double { sales.revenuePerMonth - sales.foodcostPerMonth - opExPerMonth }
    
    var taxPerMonth: Double { if ebitPerMonth > 0 { return ebitPerMonth * taxRate } else { return 0 } }
    
    var profitPerMonth: Double { ebitPerMonth - taxPerMonth }
    
    var cashFlowEstimatePerMonth: Double { profitPerMonth + depreciationPerMonth }
}
