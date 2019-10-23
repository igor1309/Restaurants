//
//  Sales.swift
//  Restaurants
//
//  Created by Igor Malyarov on 09.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

struct Sales: Identifiable, Codable, Hashable {
    var id = UUID()
    
    var meals: [Meal] = []
}

extension Sales {
    var revenuePerWeek: Double {
        let offered = meals.filter({ $0.isOffered })
        return offered.reduce(0, { $0 + $1.financial(.coverPrice, for: .week) })
    }
    
    var revenuePerMonth: Double {
        let offered = meals.filter({ $0.isOffered })
        return offered.reduce(0, { $0 + $1.financial(.coverPrice, for: .month) })
    }
    
    var cogsPerMonth: Double {
        let offered = meals.filter({ $0.isOffered })
        return offered.reduce(0, { $0 + $1.financial(.coverCost, for: .month) })
    }
    
    var foodcostPerMonth: Double { cogsPerMonth }
    
    var noOfRevenueStreams: Int { meals.count }
    var noOfActiveRevenueStreams: Int { meals.filter { $0.isOffered == true }.count }
}

extension Sales {
    func isNameUsed(_ item: Meal) -> Bool {
        /// новый элемент еще не помещен в массив и поэтому по id не находится
        let isNewItem = !meals.contains(where: { $0.id == item.id })
        print("item is new: \(isNewItem)")
        
        if isNewItem {
            return meals.contains(where: { $0.name == item.name })
        } else {
            return meals.contains(where: { $0.name == item.name
                && $0.id != item.id
            })
        }
    }
    
    mutating func add(_ meal: Meal) {
        if !isNameUsed(meal) {
            meals.append(meal)
            meals.sort(by: { $0.revenuePerMonth > $1.revenuePerMonth })
        }
    }
    
    mutating func update(_ item: Meal, with newItem: Meal) -> Bool {
        if isNameUsed(newItem) {
            print("name is used")
            return false }
        
        if item == newItem {
            print("items are identical, nothing to update")
            return true }
        
        guard let index = meals.firstIndex(where: { $0.id == item.id }) else {
            print("index for item not found")
            return false}
        
        meals[index] = newItem
        meals.sort(by: { $0.revenuePerMonth > $1.revenuePerMonth })
        print("item updated successfully")
        return true
    }
    
    mutating func toggleOffered(_ meal: Meal) -> Bool {
        guard let index = meals.firstIndex(where: { $0.id == meal.id }) else { return false }
        
        meals[index].isOffered.toggle()
        return true
    }
    
    mutating func delete(_ meal: Meal) -> Bool {
        guard let index = meals.firstIndex(where: { $0.id == meal.id }) else { return false }
        
        meals.remove(at: index)
        return true
    }
    
    mutating func reset() {
        meals.removeAll()
    }
    
    mutating func replaceWithSampleData() {
        meals = sampleSales.meals
    }
}
