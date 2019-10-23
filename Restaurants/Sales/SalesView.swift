//
//  SalesView.swift
//  CardModifier
//
//  Created by Igor Malyarov on 13.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct SalesView: View {
    @EnvironmentObject private var userData: UserData
    var restaurant: Restaurant { userData.restaurant }
    @State private var period: Period = .week
    @State private var showPeriodSelector = false
    
    var body: some View {
        NavigationView {
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    //  TODO: make an option to choose weekly, monthly or yearly
                    Text("per " + period.id.capitalized)
                        .font(.headline)
                        .padding()
                        .onTapGesture { self.showPeriodSelector = true }
                    
                    Card(title: "# of Covers",
                         subtitle: "Number of Covers per week",
                         trunk: NoOfCovers(),
                         cornerRadius: 8)
                    
                    Card(title: "Sales v.4",
                         subtitle: "Revenue by Type and Meal per week",
                         trunk: SalesCard4(period: period),
                         cornerRadius: 8)
                    
                    UnitEconomics()
                        .padding(.top)
                }
                
                Spacer()
            }
            .navigationBarTitle("Sales")
                
            .navigationBarItems(trailing:
                Picker(selection: $period, label: Text("Period")) {
                    ForEach(Period.allCases, id: \.rawValue) { period in
                        Text(period.rawValue).tag(period)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            )
                
                .actionSheet(isPresented: $showPeriodSelector) {
                    ActionSheet(title: Text("Period"),
                                message: Text("Select period for sales report"),
                                buttons: [
                                    .cancel(),
                                    .default(Text("Day")) { self.period = .day },
                                    .default(Text("Week")) { self.period = .week },
                                    .default(Text("Month")) { self.period = .month },
                                    .default(Text("Year")) { self.period = .year } ])}
        }
    }
}

#if DEBUG
struct SalesView_Previews: PreviewProvider {
    static var previews: some View {
        SalesView()
            .environmentObject(UserData())
    }
}
#endif
