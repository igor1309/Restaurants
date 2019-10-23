//
//  sampleKPI.swift
//  Restaurants
//
//  Created by Igor Malyarov on 09.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

let sampleKPI = KPI(
    kpis: [KPIItem(name: "Запуск бранча",
                   description: "Определиться с критерием успешности",
                   dueDate: Date().addDays(28)),
           KPIItem(name: "Sign the Rent Contract",
                   description: "Find a place!",
                   dueDate: Date().addDays(32)),
           KPIItem(name: "Возврат инвестиций",
                   description: "Доля Джакомо зависит от срока",
                   dueDate: Date().addWeeks(Int(52 * 2.5)))]
)
