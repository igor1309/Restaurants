//
//  sampleCapex.swift
//  Restaurants
//
//  Created by Igor Malyarov on 09.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

let sampleCapex = Capex(
    capexes: [CapExItem(name: "Selling Price",
                        description: "Asked or estimated price",
                        lifetime: 5,
                        amount: 310000),
              CapExItem(name: "All Additions 1",
                        description: "Furniture, Kitchen",
                        lifetime: 5,
                        amount: 100000),
              CapExItem(name: "All Additions 2",
                        description: "Structural, Renovation, etc",
                        lifetime: 5,
                        amount: 50000),
              CapExItem(name: "Services 1",
                        description: "Real estate agent",
                        lifetime: 3,
                        amount: 0),
              CapExItem(name: "Services 2",
                        description: "graphic designer, web",
                        lifetime: 3,
                        amount: 3000),
              CapExItem(name: "Services 3",
                        description: "PR (openning), etc",
                        lifetime: 3,
                        amount: 5000),
              CapExItem(name: "Bureaucracy 1",
                        description: "notar, estate caution",
                        lifetime: 3,
                        amount: 2000),
              CapExItem(name: "Bureaucracy 2",
                        description: "company registration, etc",
                        lifetime: 3,
                        amount: 2000),
              CapExItem(name: "Rent Deposit",
                        description: "2-3 month rent",
                        lifetime: 2,
                        amount: 20000),
              CapExItem(name: "Max Cumulative Loss",
                        description: "Estimated peak cummulative loss to be finaced by investment",
                        lifetime: 1,
                        amount: 85583),
              CapExItem(name: "Extra Working Capital",
                        description: "\"Buffer\"",
                        lifetime: 1,
                        amount: 50000)
])
