//
//  Status.swift
//  Restaurants
//
//  Created by Igor Malyarov on 10.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

enum Status: String, CaseIterable, Codable, Hashable {
    case dream = "it's just the dream"
    case idea = "idea. why not?"
    case talks = "talking with partners to be"
    case preparation = "preparation"
    case running = "running"
    case dead = "dead project"
    
    var id: String {
        return rawValue
    }
}
