//
//  KPI.swift
//  Restaurants
//
//  Created by Igor Malyarov on 09.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct KPI: Identifiable, Codable, Hashable {
    var id = UUID()
    
    var kpis: [KPIItem] = []
    
    var kpiTermForRedColor: Int = 30 {
        didSet {
            if kpiTermForRedColor < 1 {
                kpiTermForRedColor = 30
            }
            if kpiTermForRedColor >= kpiTermForOrangeColor {
                kpiTermForRedColor = kpiTermForOrangeColor - 1
            }
        }
    }
    
    var kpiTermForOrangeColor: Int = 90 {
        didSet {
            if kpiTermForOrangeColor < 1 {
                kpiTermForOrangeColor = 90
            }
            if kpiTermForRedColor >= kpiTermForOrangeColor {
                kpiTermForOrangeColor = kpiTermForRedColor + 1
            }
        }
    }
}

extension KPI {
    func color(item: KPIItem) -> Color {
        switch Date().daysBetween(item.dueDate) {
        case 0...kpiTermForRedColor:
            return .systemRed
        case (kpiTermForRedColor + 1)...kpiTermForOrangeColor:
            return .systemOrange
        default:
            return .primary
        }
    }
}

extension KPI {
    var urgent: [KPIItem] {
        kpis.filter {
            Date().daysBetween($0.dueDate) <= kpiTermForRedColor
        }
    }
    
    var soon: [KPIItem] {
        kpis.filter {
            kpiTermForRedColor < Date().daysBetween($0.dueDate)
                && Date().daysBetween($0.dueDate) <= kpiTermForOrangeColor
        }
    }
    
    var haveSomeTime: [KPIItem] {
        kpis.filter {
            kpiTermForOrangeColor < Date().daysBetween($0.dueDate)
        }
    }
}

extension KPI {
    func isNameUsed(_ item: KPIItem) -> Bool {
        /// новый элемент еще не помещен в массив и поэтому по id не находится
        let isNewItem = !kpis.contains(where: { $0.id == item.id })
        print("item is new: \(isNewItem)")
        
        if isNewItem {
            return kpis.contains(where: { $0.name == item.name })
        } else {
            return kpis.contains(where: { $0.name == item.name
                && $0.id != item.id
            })
        }
    }
    
    mutating func add(_ item: KPIItem) {
        if !isNameUsed(item) {
            kpis.append(item)
            kpis.sort(by: { $0.dueDate < $1.dueDate })
        }
    }
    
    mutating func update(_ item: KPIItem, with newItem: KPIItem) -> Bool {
        if isNameUsed(newItem) {
            print("name is used")
            return false }
        
        if item == newItem {
            print("items are identical, nothing to update")
            return true }
        
        guard let index = kpis.firstIndex(where: { $0.id == item.id }) else {
            print("index for item not found")
            return false}
        
        kpis[index] = newItem
        kpis.sort(by: { $0.dueDate < $1.dueDate })
        print("item updated successfully")
        return true
    }
    
    mutating func delete(_ item: KPIItem) -> Bool {
        guard let index = kpis.firstIndex(where: { $0.id == item.id }) else { return false }
        
        kpis.remove(at: index)
        return true
    }
    
    mutating func reset() {
        kpis.removeAll()
    }
    
    mutating func replaceWithSampleData() {
        kpis = sampleKPI.kpis
    }
}
