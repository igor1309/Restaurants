//
//  CapEx.swift
//
//  Created by Igor Malyarov on 31.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

struct Capex: Identifiable, Codable, Hashable {
    var id = UUID()
    
    var capexes: [CapExItem] = []
}

extension Capex {
    var lifetimes: [Int] {
        capexes.map({ $0.lifetime }).removingDuplicates().sorted(by: >)
    }
}

extension Capex {
    func isNameUsed(_ item: CapExItem) -> Bool {
        /// новый элемент еще не помещен в массив и поэтому по id не находится
        let isNewItem = !capexes.contains(where: { $0.id == item.id })
        print("item is new: \(isNewItem)")
        
        if isNewItem {
            return capexes.contains(where: { $0.name == item.name })
        } else {
            return capexes.contains(where: { $0.name == item.name
                && $0.id != item.id
            })
        }
    }
    
    mutating func add(_ item: CapExItem) {
        if !isNameUsed(item) {
            capexes.append(item)
            capexes.sort(by: { $0.amount > $1.amount })
        }
    }
    
    mutating func update(_ item: CapExItem, with newItem: CapExItem) -> Bool {
        if isNameUsed(newItem) {
            print("name is used")
            return false }
        
        if item == newItem {
            print("items are identical, nothing to update")
            return true }
        
        guard let index = capexes.firstIndex(where: { $0.id == item.id }) else {
            print("index for item not found")
            return false}
        
        capexes[index] = newItem
        capexes.sort(by: { $0.amount > $1.amount })
        print("item updated successfully")
        return true
    }
    
    mutating func delete(_ item: CapExItem) -> Bool {
        guard let index = capexes.firstIndex(where: { $0.id == item.id }) else { return false }
        
        capexes.remove(at: index)
        return true
    }
    
    mutating func reset() {
        capexes.removeAll()
    }
    
    mutating func replaceWithSampleData() {
        capexes = sampleCapex.capexes
    }
}
