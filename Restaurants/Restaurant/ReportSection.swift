//
//  ReportSection.swift
//  Restaurants
//
//  Created by Igor Malyarov on 24.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ReportSection: View {
    @EnvironmentObject var userData: UserData
    @State private var showActionReport = false
    @State private var showModal = false
    @State private var modal: ModalType = .report
    @State private var report = Report()
    
    var body: some View {
        Section(header: Text("Reports".uppercased()),
                footer: Text("Hold for contex menu.")) {
                    
                    RowIconAmount(title:    "Reports",
                                  subtitle: "P&L, Cash Flow, Expenses",
                                  currency: .none,
                                  color:    .systemOrange,
                                  icon:     "text.append")
                        .onTapGesture {
                            if hapticsAvailable {
                                let generator = UIImpactFeedbackGenerator(style: .medium)
                                generator.impactOccurred()
                            }
                            self.modal = .allReports
                            self.showModal = true }
                        .contextMenu {
                            ForEach(userData.restaurant.reports, id: \.self) { report in
                                Button(action: {
                                    self.report = report
                                    self.modal = .report
                                    self.showModal = true
                                }) {
                                    HStack {
                                        Text(report.name)
                                        Image(systemName: "doc.plaintext")
                                    }
                                }
                            }}
                        .sheet(isPresented: self.$showModal) {
                            if self.modal == .report {
                                ReportView(report: self.report)
                            }
                            if self.modal == .allReports {
                                Finance()
                                    .environmentObject(self.userData)
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
