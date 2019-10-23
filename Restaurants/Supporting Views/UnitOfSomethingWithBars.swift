//
//  UnitOfSomethingWithBars.swift
//
//  Created by Igor Malyarov on 05.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct UnitOfSomethingWithBarsSorted: View {
    var data: [String: Double]
    var prefix: String = ""
    
    var rowHeight: CGFloat = 9
    var cornerRadius: CGFloat = 3
    var colorMore: Color = .systemGray2
    var colorLess: Color = .systemGray5
    var fill: Bool = false
    
    var values: [Double] { data.map { $0.value }}
    var valuesCGFloat: [CGFloat] { data.map { CGFloat($0.value) }}
    
    var total: Double {
        values.reduce(0.0, + )
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            if total > 0 {
                ForEach(data.map{$0}.sorted(by: { $0.value > $1.value }), id: \.self.0) { (name, amount) in
                    SalesRowWithBar(bar: CGFloat(amount),
                                    bars: self.valuesCGFloat,
                                    height: self.rowHeight,
                                    cornerRadius: self.cornerRadius,
                                    colorMore: self.colorMore,
                                    colorLess: self.colorLess,
                                    fill: self.fill,
                                    title: name,
                                    detail: self.prefix + amount.formattedGrouped,
                                    subdetail: (amount/self.total).formattedPercentage)
                }
            }
        }
    }
}

struct UnitOfSomethingWithBarsUnsorted: View {
    var data: [String: Double]
    var prefix: String = ""
    
    var rowHeight: CGFloat = 8
    var colorMore: Color = .systemGray2
    var colorLess: Color = .systemGray5
    var fill: Bool = false
    
    var keys: [String] { data.map { $0.key }}
    var values: [Double] { data.map { $0.value }}
    var valuesCGFloat: [CGFloat] { data.map { CGFloat($0.value) }}
    
    var total: Double {
        values.reduce(0.0, + )
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            if total > 0 {
                ForEach(values.indices) { index in
                    SalesRowWithBar(bar: self.valuesCGFloat[index],
                                    bars: self.valuesCGFloat,
                                    height: self.rowHeight,
                                    colorMore: self.colorMore,
                                    colorLess: self.colorLess,
                                    fill: self.fill,
                                    title: self.keys[index],
                                    detail: self.prefix + self.values[index].formattedGrouped,
                                    subdetail: (self.values[index]/self.total).formattedPercentage)
                }
            }
        }
    }
}

#if DEBUG
struct UnitOfSomethingWithBars_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing:24) {
            UnitOfSomethingWithBarsSorted(data: [
                "Food": 24450,
                "Beverages": 27800,
                "Other": 3405
                ],
                                          prefix: Currency.euro.idd)
            
            UnitOfSomethingWithBarsUnsorted(data: [
                "Food": 24450,
                "Beverages": 17800,
                "Other": 3405
            ])
        }
        .padding()
    }
}
#endif
