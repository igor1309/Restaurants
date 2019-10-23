//
//  sampleSales.swift
//  Restaurants
//
//  Created by Igor Malyarov on 09.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

let sampleSales = Sales(meals: [Meal(isOffered: true,
                                     name: "Lunch",
                                     description: "Lunch description",
                                     noOfCoversPeriod: .week,
                                     noOfCovers: 225,
                                     hasDailyBreakdown: true,
                                     covers: [
                                        .monday: 45,
                                        .tuesday: 45,
                                        .wednesday: 45,
                                        .thursday: 45,
                                        .friday: 45,
                                        .saturday: 0,
                                        .sunday: 0],
                                     hasFoodAndBevBreakdown: true,
                                     foodPrice: 10,
                                     beveragesPrice: 5,
                                     foodCost: 2.5,
                                     beveragesCost: 1.0),
                                Meal(isOffered: true,
                                     name: "Brunch",
                                     description: "Weekends",
                                     noOfCoversPeriod: .week,
                                     noOfCovers: 160,
                                     hasDailyBreakdown: true,
                                     covers: [
                                        .monday: 0,
                                        .tuesday: 0,
                                        .wednesday: 0,
                                        .thursday: 0,
                                        .friday: 0,
                                        .saturday: 80,
                                        .sunday: 80],
                                     hasFoodAndBevBreakdown: true,
                                     foodPrice: 12,
                                     beveragesPrice: 9,
                                     foodCost: 3,
                                     beveragesCost: 1.8),
                                Meal(isOffered: true,
                                     name: "Dinner",
                                     description: "Dinner description",
                                     noOfCoversPeriod: .week,
                                     noOfCovers: 490,
                                     hasDailyBreakdown: true,
                                     covers: [
                                        .monday: 50,
                                        .tuesday: 50,
                                        .wednesday: 70,
                                        .thursday: 70,
                                        .friday: 100,
                                        .saturday: 100,
                                        .sunday: 50],
                                     hasFoodAndBevBreakdown: true,
                                     foodPrice: 40,
                                     beveragesPrice: 25,
                                     foodCost: 10,
                                     beveragesCost: 5),
                                Meal(isOffered: false,
                                     name: "Back Room Privee",
                                     description: "from 500€ Private meeting",
                                     noOfCoversPeriod: .week,
                                     noOfCovers: 0,
                                     hasDailyBreakdown: false,
                                     covers: [:],
                                     hasFoodAndBevBreakdown: false,
                                     foodPrice: 0,
                                     beveragesPrice: 0,
                                     foodCost: 0,
                                     beveragesCost: 0),
                                Meal(isOffered: false,
                                     name: "60 m2",
                                     description: "from 500€ Business Events",
                                     noOfCoversPeriod: .week,
                                     noOfCovers: 0,
                                     hasDailyBreakdown: false,
                                     covers: [:],
                                     hasFoodAndBevBreakdown: false,
                                     foodPrice: 0,
                                     beveragesPrice: 0,
                                     foodCost: 0,
                                     beveragesCost: 0),
                                Meal(isOffered: false,
                                     name: "13 m2 office",
                                     description: "from 2000€ Private Banqueting",
                                     noOfCoversPeriod: .week,
                                     noOfCovers: 0,
                                     hasDailyBreakdown: false,
                                     covers: [:],
                                     hasFoodAndBevBreakdown: false,
                                     foodPrice: 0,
                                     beveragesPrice: 0,
                                     foodCost: 0,
                                     beveragesCost: 0),
                                Meal(isOffered: false,
                                     name: "Private garden",
                                     description: "up to 120 people Enlarge restaurant sitting area",
                                     noOfCoversPeriod: .week,
                                     noOfCovers: 0,
                                     hasDailyBreakdown: false,
                                     covers: [:],
                                     hasFoodAndBevBreakdown: false,
                                     foodPrice: 0,
                                     beveragesPrice: 0,
                                     foodCost: 0,
                                     beveragesCost: 0),
                                Meal(isOffered: false,
                                     name: "Private garden+",
                                     description: "up to 300 people Private events in the whole restaurant",
                                     noOfCoversPeriod: .week,
                                     noOfCovers: 0,
                                     hasDailyBreakdown: false,
                                     covers: [:],
                                     hasFoodAndBevBreakdown: false,
                                     foodPrice: 0,
                                     beveragesPrice: 0,
                                     foodCost: 0,
                                     beveragesCost: 0),
                                Meal(isOffered: false,
                                     name: "Side Kitchen",
                                     description: "Meat & Food lab\nIce cream shop may-september\nStreet food joint",
                                     noOfCoversPeriod: .week,
                                     noOfCovers: 0,
                                     hasDailyBreakdown: false,
                                     covers: [:],
                                     hasFoodAndBevBreakdown: false,
                                     foodPrice: 0,
                                     beveragesPrice: 0,
                                     foodCost: 0,
                                     beveragesCost: 0)
    ]
)