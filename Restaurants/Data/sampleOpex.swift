//
//  sampleOpex.swift
//  Restaurants
//
//  Created by Igor Malyarov on 09.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

let sampleOpex = Opex(
    opexes: [OpExItem(name: "Salary: ex Kitchen",
                      description: "Incl. Payroll Expenses",
                      type: .salaryExKitchen,
                      amount: 22915),
             OpExItem(name: "Salary: Kitchen",
                      description: "Incl. Payroll Expenses",
                      type: .salaryKitchen,
                      amount: 24504),
             OpExItem(name: "Rent",
                      description: "Electricity + Gas",
                      type: .rent,
                      amount: 7958),
             OpExItem(name: "Electricity + Gas",
                      description: "Monthly",
                      type: .utilities,
                      amount: 1500),
             OpExItem(name: "Office+Pr",
                      description: "Accountant, Social, Payrolls, Staff managment",
                      type: .salaryExKitchen,
                      amount: 2000),
             OpExItem(name: "Ensurrance",
                      description: "Monthly",
                      type: .other,
                      amount: 200),
             OpExItem(name: "Bank",
                      description: "Monthly",
                      type: .other,
                      amount: 250),
             OpExItem(name: "Trash",
                      description: "Monthly",
                      type: .utilities,
                      amount: 400),
             OpExItem(name: "Cleaning",
                      description: "Monthly",
                      type: .other,
                      amount: 200),
             OpExItem(name: "Tax Office",
                      description: "Monthly",
                      type: .other,
                      amount: 500),
             OpExItem(name: "Toilet papers",
                      description: "Ille service",
                      type: .other,
                      amount: 150),
             OpExItem(name: "Telephone+Internet",
                      description: "Monthly",
                      type: .other,
                      amount: 100),
             OpExItem(name: "Decor",
                      description: "Fiori",
                      type: .other,
                      amount: 150),
             OpExItem(name: "Booking service",
                      description: "Booking service",
                      type: .marketing,
                      amount: 450),
             OpExItem(name: "Other Expenses",
                      description: "Extra, ~2% of Revenue",
                      type: .other,
                      amount: 3330)
])