//
//  UserData.swift
//
//  Created by Igor Malyarov on 29.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

final class UserData: ObservableObject {
    @Published var restaurant = businessData.restaurants[0] {
        didSet {
            if business.update(original, with: restaurant) {
                print("restaurant in 'business' updated successfully")
            } else {
                print("error saving restaurant")
            }
        }
    }
    
    var original: Restaurant = businessData.restaurants[0]
    
    var business: Business = businessData {
        didSet {
            // save data to local JSON
            saveJSON(data: business, filename: "business.json")
        }
    }
    
    @Published var modelYears: [ModelYear] = modelYearData {
        didSet {
            // save data to local JSON
            saveJSON(data: modelYears, filename: "modelYears.json")
        }
    }
}

extension UserData {
    func selectRestaurant(_ new: Restaurant) {
        /// switch to new restaurant and make a copy to be able to update later
        /// не менять порядок!!! `original` должен меняться первым!!!
        original = new
        restaurant = new
    }
    
    func deleteRestaurant(_ restToDelete: Restaurant) -> Bool {
        original = business.restaurants[0]
        restaurant = business.restaurants[0]
        if business.delete(restToDelete) {
            return true
        } else {
            return false
        }
    }
}
