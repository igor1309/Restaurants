//
//  ReportSection.swift
//  Restaurants
//
//  Created by Igor Malyarov on 24.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ReportView: View {
    var report: Report
    
    var body: some View {
        NavigationView {
            ScrollView {
                ReportCard(report: report).padding(.top)
            }
            .navigationBarTitle(Text(report.name), displayMode: report.name.count <= 18 ? .large : .inline)
        }
    }
}

struct ReportSection: View {
    @EnvironmentObject var userData: UserData
    @State private var showActionReport = false
    @State private var showModal = false
    @State private var modal: ModalType = .report
    @State private var report: Report = Report(name: "", description: "", lines: [])
    
    var body: some View {
        Section(header: Text("Reports".uppercased())) {
            Text("Reports")
                .foregroundColor(.accentColor)
                .contextMenu {
                    ForEach(userData.restaurant.reports, id: \.self) { report in
                        Button(action: {
                            self.report = report
                            self.modal = .report
                            self.showModal = true
                        }) {
                            HStack {
                                Text(report.name)
                                Image(systemName: "list.dash")
                            }
                        }
                    }}
                .sheet(isPresented: self.$showModal) {
                    if self.modal == .report {
                        ReportView(report: self.report)
                    }}
        }
    }
}

struct ReportSection_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                ReportSection()
            }
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
