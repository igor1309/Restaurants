//
//  Business.swift
//  Restaurants
//
//  Created by Igor Malyarov on 10.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

struct Business: Identifiable, Codable, Hashable {
    var id = UUID()
    
    var restaurants: [Restaurant]
}

extension Business {
    var projectNames: [String] {
        restaurants.map { $0.projectName }.removingDuplicates()
    }
    var cities: [String] {
        restaurants.map { $0.city }.removingDuplicates()
    }
}

extension Business {
    func isNameUsed(_ item: Restaurant) -> Bool {
        /// новый элемент еще не помещен в массив и поэтому по id не находится
        let isNewItem = !restaurants.contains(where: { $0.id == item.id })
        print("item \(isNewItem ? "is new" : "from array")")
        
        if isNewItem {
            return restaurants.contains(where: { $0.name == item.name })
        } else {
            return restaurants.contains(where: { $0.name == item.name
                && $0.id != item.id
            })
        }
    }
    
    mutating func add(_ item: Restaurant) {
        if !isNameUsed(item) {
            restaurants.insert(item, at: 0)
        }
    }
    
    mutating func update(_ item: Restaurant, with newItem: Restaurant) -> Bool {
        if isNameUsed(newItem) {
            print("name is used")
            return false }
        
        if item == newItem {
            print("items are identical, nothing to update")
            return true }
        
        guard let index = restaurants.firstIndex(where: { $0.id == item.id }) else {
            print("index for item not found")
            return false}
        
        restaurants[index] = Restaurant(from: newItem)
        restaurants.sort(by: { $0.modificationDate > $1.modificationDate })
        print("item in array updated successfully")
        
        return true
    }
    
    mutating func delete(_ item: Restaurant) -> Bool {
        /// массив ресторанов не должен оставаться пустым, иначе крашнется
        /// поскольку основным вью у меня является ресторан, а не список ресторанов
        if restaurants.count == 1 {
            add(sampleRestaurants[0])
        }
        
        guard let index = restaurants.firstIndex(where: { $0.id == item.id }) else { return false }
        
        restaurants.remove(at: index)
        return true
    }
}
