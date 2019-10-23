//
//  Meal.swift
//
//  Created by Igor Malyarov on 29.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

typealias NumbersForPeriods = (perDay: Double, perWeek: Double, perMonth: Double, perYear: Double)
typealias NumbersForPeriodsInt = (perDay: Int, perWeek: Int, perMonth: Int, perYear: Int)

struct Meal: Identifiable, Codable, Hashable {
    var id = UUID()
    
    var isOffered: Bool = true
    
    var name: String = "New Meal"
    var description: String = "New Meal Description"
    
    var noOfCoversPeriod: Period = .week
    var noOfCovers: Int = 420
    var hasDailyBreakdown: Bool = true {
        didSet {
            if self.hasDailyBreakdown {
                noOfCoversPeriod = .week
            }
        }
    }
    var covers: [DayOfWeek : Int] = [
        .monday : 30,
        .tuesday : 40,
        .wednesday : 50,
        .thursday : 60,
        .friday : 70,
        .saturday : 80,
        .sunday : 90
        ] {
        didSet {
            self.noOfCovers = covers.values.reduce(0, +)
        }
    }
    
    var hasFoodAndBevBreakdown: Bool = true
    //  если нет разбивки на Food Beverages
    //  (то есть hasFoodAndBevBreakdown = false)
    //  тогда coverPrice == foodPrice и coverCost == foodCost
    var foodPrice: Double = 8.40
    var beveragesPrice: Double = 5.50
    var coverPrice: Double {
        hasFoodAndBevBreakdown ? foodPrice + beveragesPrice : foodPrice
    }
    
    var foodCost: Double = 2.10
    var beveragesCost: Double = 1.10
    var coverCost: Double {
        hasFoodAndBevBreakdown ? foodCost + beveragesCost : foodCost
    }
}

//extension Meal: Equatable {
//    static func == (lhs: Meal, rhs: Meal) -> Bool {
//        return
//            lhs.id == rhs.id
//    }
//}
//
extension Meal {
    mutating func resetNoOfCovers() {
        self.covers = [
            .monday : 0,
            .tuesday : 0,
            .wednesday : 0,
            .thursday : 0,
            .friday : 0,
            .saturday : 0,
            .sunday : 0
        ]
    }
}

extension Meal {
    enum FinancialParameter: String {
        case coverPrice, foodPrice, beveragesPrice
        case coverCost, foodCost, beveragesCost
        
        var id: String { return rawValue }
    }
    
    func financial(_ financialParameter: FinancialParameter, for period: Period) -> Double {
        var r: Double
        
        switch financialParameter {
        case .coverPrice:
            r = self.coverPrice
        case .foodPrice:
            r = self.foodPrice
        case .beveragesPrice:
            r = self.beveragesPrice
        case .coverCost:
            r = self.coverCost
        case .foodCost:
            r = self.foodCost
        case .beveragesCost:
            r = self.beveragesCost
        }
        
        var noOfCoversPerDay: Double
        //  downcast to day
        switch noOfCoversPeriod {
        case .day:
            noOfCoversPerDay = Double(noOfCovers) / 1
        case .week:
            noOfCoversPerDay = Double(noOfCovers) / 7
        case .month:
            noOfCoversPerDay = Double(noOfCovers) / 30
        case .year:
            noOfCoversPerDay = Double(noOfCovers) / 365
        }
        
        r = r * noOfCoversPerDay
        
        switch period {
        case .day:
            r = r * 1
        case .week:
            r = r * 7
        case .month:
            r = r * 30
        case .year:
            r = r * 365
        }
        
        return r
    }
    
}


extension Meal {
    var noOfCoversPerDay: Int { noOfCoversPerPeriod().perDay }
    var noOfCoversPerWeek: Int { noOfCoversPerPeriod().perWeek }
    var noOfCoversPerMonth: Int { noOfCoversPerPeriod().perMonth }
    var noOfCoversPerYear: Int { noOfCoversPerPeriod().perYear }
    
    private func noOfCoversPerPeriod() -> NumbersForPeriodsInt {
        if self.isOffered {
            let number = Double(self.noOfCovers)
            let numbers = equivalentNumbersForPeriods(for: number)
            return (Int(numbers.perDay), Int(numbers.perWeek), Int(numbers.perMonth), Int(numbers.perYear))
        } else {
            return (0, 0, 0, 0)
        }
    }
}

extension Meal {
    var revenuePerDay: Double { revenue().perDay }
    var revenuePerWeek: Double { revenue().perWeek }
    var revenuePerMonth: Double { revenue().perMonth }
    var revenuePerYear: Double { revenue().perYear }
    
    private func revenue() -> NumbersForPeriods {
        if self.isOffered {
            let revenue = self.coverPrice * Double(self.noOfCovers)
            return equivalentNumbersForPeriods(for: revenue)
        } else {
            return (0.0, 0.0, 0.0, 0.0)
        }
    }
}

extension Meal {
    var foodRevenuePerDay: Double { foodRevenue().perDay }
    var foodRevenuePerWeek: Double { foodRevenue().perWeek }
    var foodRevenuePerMonth: Double { foodRevenue().perMonth }
    var foodRevenuePerYear: Double { foodRevenue().perYear }
    
    private func foodRevenue() -> NumbersForPeriods {
        if self.isOffered {
            let foodRevenue = self.foodPrice * Double(self.noOfCovers)
            return equivalentNumbersForPeriods(for: foodRevenue)
        } else {
            return (0.0, 0.0, 0.0, 0.0)
        }
    }
}

extension Meal {
    var beveragesRevenuePerDay: Double { beveragesRevenue().perDay }
    var beveragesRevenuePerWeek: Double { beveragesRevenue().perWeek }
    var beveragesRevenuePerMonth: Double { beveragesRevenue().perMonth }
    var beveragesRevenuePerYear: Double { beveragesRevenue().perYear }
    
    private func beveragesRevenue() -> NumbersForPeriods {
        if self.isOffered {
            let beveragesRevenue = self.beveragesPrice * Double(self.noOfCovers)
            return equivalentNumbersForPeriods(for: beveragesRevenue)
        } else {
            return (0.0, 0.0, 0.0, 0.0)
        }
    }
}

extension Meal {
    var coverCostPerDay: Double { coverCostNumbers().perDay }
    var coverCostPerWeek: Double { coverCostNumbers().perWeek }
    var coverCostPerMonth: Double { coverCostNumbers().perMonth }
    var coverCostPerYear: Double { coverCostNumbers().perYear }
    
    private func coverCostNumbers() -> NumbersForPeriods {
        if self.isOffered {
            let coverCost = self.coverCost * Double(self.noOfCovers)
            return equivalentNumbersForPeriods(for: coverCost)
        } else {
            return (0.0, 0.0, 0.0, 0.0)
        }
    }
}

extension Meal {
    var foodCostPerDay: Double { foodCostNumbers().perDay }
    var foodCostPerWeek: Double { foodCostNumbers().perWeek }
    var foodCostPerMonth: Double { foodCostNumbers().perMonth }
    var foodCostPerYear: Double { foodCostNumbers().perYear }
    
    private func foodCostNumbers() -> NumbersForPeriods {
        if self.isOffered {
            let foodCost = self.foodCost * Double(self.noOfCovers)
            return equivalentNumbersForPeriods(for: foodCost)
        } else {
            return (0.0, 0.0, 0.0, 0.0)
        }
    }
}

extension Meal {
    var beveragesCostPerDay: Double { beveragesCostNumbers().perDay }
    var beveragesCostPerWeek: Double { beveragesCostNumbers().perWeek }
    var beveragesCostPerMonth: Double { beveragesCostNumbers().perMonth }
    var beveragesCostPerYear: Double { beveragesCostNumbers().perYear }
    
    private func beveragesCostNumbers() -> NumbersForPeriods {
        if self.isOffered {
            let beveragesCost = self.beveragesCost * Double(self.noOfCovers)
            return equivalentNumbersForPeriods(for: beveragesCost)
        } else {
            return (0.0, 0.0, 0.0, 0.0)
        }
    }
}

extension Meal {
    private func equivalentNumbersForPeriods(for number: Double) -> NumbersForPeriods {
        var day: Double
        var week: Double
        var month: Double
        var year: Double
        
        switch self.noOfCoversPeriod {
        case .day:
            day = number
            week = number * 7
            month = number * 30
            year = number * 365
        case .week:
            day = number / 7
            week = number
            month = number / 7 * 30
            year = number / 7 * 365
        case .month:
            day = number / 30
            week = number / 30 * 7
            month = number
            year = number / 30 * 365
        case .year:
            day = number / 365
            week = number / 365 * 7
            month = number / 365 * 30
            year = number * 365
        }
        
        return (day, week, month, year)
    }
}

extension Meal {
    func weeklyRevenue() -> Double {
        var revenue: Double = self.coverPrice * Double(self.noOfCovers)
        
        switch self.noOfCoversPeriod {
        case .day:
            revenue = 7.0 * revenue
        case .week:
            revenue = revenue * 1
        case .month:
            revenue = revenue / 30 * 7
        case .year:
            revenue = revenue / 365 * 7
        }
        
        return revenue
    }
}
