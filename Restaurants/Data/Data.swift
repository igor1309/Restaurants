//
//  Data.swift
//
//  Created by Igor Malyarov on 29.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI


let w = (UIScreen.main.bounds.width - 2 * 2 * 16) / 3 * 2


//  MARK:- добавить механизм добавления городов в список, загрузки из UserDefaults и сохранение с проверкой на уникальность значения
//  при первичной загрузке если пусто выдать cities = ["Moscow", "Berlin", "Frankfurt am Main"]
let cities = ["Moscow", "Berlin", "Frankfurt am Main"]

let businessData = loadBusinessData()

let modelYearData = loadModelYearData()
let currentRestaurantData = loadCurrentRestaurantData()
let restaurantData = loadRestaurantData()

func loadBusinessData() -> Business {
    guard let data: Business = loadFromDocDir("business.json") else {
        return Business(restaurants: sampleRestaurants)
    }
    
    if data.restaurants.isEmpty {
        return Business(restaurants: [sampleRestaurants[0]])
    } else {
        return data
    }
}

func loadModelYearData() -> [ModelYear] {
    guard let data: [ModelYear] = loadFromDocDir("modelYears.json") else {
        return [
            ModelYear(id: 1, discount: 0.20),
            ModelYear(id: 2, discount: 0.10),
            ModelYear(id: 3, discount: 0.5)//,
            //            ModelYear(id: 4, discount: 0.00)
        ]
    }
    
    return data
}

func loadCurrentRestaurantData() -> Restaurant {
    guard let data: Restaurant = loadFromDocDir("restaurant.json") else {
        return sampleRestaurants[0]
    }
    
    return data
}

func loadRestaurantData() -> [Restaurant] {
    guard let data: [Restaurant] = loadFromDocDir("restaurants.json") else {
        return sampleRestaurants
    }
    
    return data
}
