//
//  KPIItem.swift
//
//  Created by Igor Malyarov on 31.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct KPIItem : Identifiable, Codable, Hashable {
    var id = UUID()
    
//    var restaurant: String = "New Resaurant Name"
    
    var name: String = "New KPI or Milestones"
    var description: String = "Description of the New KPI or Milestones"
    
    var dueDate: Date = Date().addDays(180)
}
