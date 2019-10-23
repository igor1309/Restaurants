//
//  Opex.swift
//  Restaurants
//
//  Created by Igor Malyarov on 09.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

struct Opex: Identifiable, Codable, Hashable {
    var id = UUID()
    
    var opexes: [OpExItem] = []
}

extension Opex {
    var types: [OpExType] { OpExType.allCases }
}

extension Opex {
    func isNameUsed(_ item: OpExItem) -> Bool {
        /// новый элемент еще не помещен в массив и поэтому по id не находится
        let isNewItem = !opexes.contains(where: { $0.id == item.id })
        print("item is new: \(isNewItem)")
        
        if isNewItem {
            return opexes.contains(where: { $0.name == item.name })
        } else {
            return opexes.contains(where: { $0.name == item.name
                && $0.id != item.id
            })
        }
    }
    
    mutating func add(_ item: OpExItem) {
        if !isNameUsed(item) {
            opexes.append(item)
            opexes.sort(by: { $0.amount > $1.amount })
        }
    }
    
    mutating func update(_ item: OpExItem, with newItem: OpExItem) -> Bool {
        if isNameUsed(newItem) {
            print("name is used")
            return false }
        
        if item == newItem {
            print("items are identical, nothing to update")
            return true }
        
        guard let index = opexes.firstIndex(where: { $0.id == item.id }) else {
            print("index for item not found")
            return false}
        
        opexes[index] = newItem
        opexes.sort(by: { $0.amount > $1.amount })
        print("item updated successfully")
        return true
    }
    
    mutating func delete(_ item: OpExItem) -> Bool {
        guard let index = opexes.firstIndex(where: { $0.id == item.id }) else { return false }
        
        opexes.remove(at: index)
        return true
    }
    
    mutating func reset() {
        opexes.removeAll()
    }
    
    mutating func replaceWithSampleData() {
        opexes = sampleOpex.opexes
    }
}
