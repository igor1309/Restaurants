//
//  sampleRestaurants.swift
//  Restaurants
//
//  Created by Igor Malyarov on 10.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

let sampleRestaurants = [Restaurant(name: "To The Bone Charlottenburg",
                                    projectName: "Giacomo",
                                    type: RestaurantType.fullService,
                                    city: "Berlin",
                                    
                                    concept: "Italian Meat",
                                    description: "First venture with Giacomo, upscaled To The Bone in Charlottenburg",
                                    comment: "ищем помещение",
                                    status: Status.preparation,
                                    
                                    budget: 550_000,
                                    currency: Currency.euro,
                                    
                                    insideSeating: 90,
                                    outsideSeating: 50,
                                    
                                    area: 140,
                                    kitchenArea: 80,
                                    totalArea: 220,
                                    
                                    sales: sampleSales,
                                    opex: sampleOpex,
                                    capex: sampleCapex,
                                    kpi: sampleKPI),
                         Restaurant(name: "Еще один для тестирования",
                                    projectName: "Giacomo",
                                    type: RestaurantType.fineDining,
                                    city: "Frankfurt am Main",
                                    
                                    concept: "Italian Meat",
                                    description: "Второй ресторан с Джакомо",
                                    comment: "чистая фантазия для теста",
                                    status: Status.preparation,
                                    
                                    budget: 500_000,
                                    currency: Currency.euro,
                                    
                                    insideSeating: 80,
                                    outsideSeating: 60,
                                    
                                    area: 120,
                                    kitchenArea:70,
                                    totalArea: 190,
                                    
                                    opex: Opex(opexes: []),
                                    capex: Capex(capexes: []),
                                    kpi: KPI(kpis: [])),
                         
                         Restaurant(name: "Yossi/Mashya Berlin",
                                    projectName: "Израильтяне",
                                    type: RestaurantType.fineDining,
                                    city: "Berlin",
                                    
                                    concept: "Modern Israeli",
                                    description: "израильский ресторан в Берлине",
                                    comment: "мечта",
                                    status: Status.dream,
                                    
                                    budget: 600_000,
                                    currency: Currency.euro,
                                    
                                    insideSeating: 80,
                                    outsideSeating: 60,
                                    
                                    area: 140,
                                    kitchenArea:80,
                                    totalArea: 220,
                                    
                                    opex: Opex(opexes: []),
                                    capex: Capex(capexes: []),
                                    kpi: KPI(kpis: [])),
                         Restaurant(name: "Саперави Аминьевка",
                                    projectName: "Хатуна&Тенгиз",
                                    city: "Moscow",
                                    concept: "Modern Georgian",
                                    status: .preparation,
                                    budget: 30_000_000,
                                    currency: .rub)
]
