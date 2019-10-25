//
//  Report.swift
//  Restaurants
//
//  Created by Igor Malyarov on 24.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

struct Report: Hashable {
    var name: String
    var description: String
    var lines: [ReportLine]
}

extension Report {
    init() {
        self.name = ""
        self.description = ""
        self.lines = []
    }
}

struct ReportLine: Hashable {
    var title: String
    var subtitle: String
    var detail: String
    var subdetail: String
}
