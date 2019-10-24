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
    @State private var isHighlighted = false
    @State private var showActionReport = false
    @State private var showModal = false
    @State private var modal: ModalType = .report
    @State private var report: Report = Report(name: "", description: "", lines: [])
    
    var body: some View {
        Section(header: Text("Reports".uppercased()),
                footer: Text("Hold for contex menu.")) {
                    RestaurantFinanceOneRow(title: isHighlighted ? "Hold for contex menu" : "Reports", subtitle: "P&L, Cash Flow, Expenses", currency: .none, color: isHighlighted ? .red : .systemOrange, icon: "text.append")
                        .contentShape(Rectangle())
                        .onTapGesture {
                            let generator = UIImpactFeedbackGenerator(style: .medium)
                            generator.impactOccurred()
                            withAnimation {
                                self.isHighlighted = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    self.isHighlighted = false
                                }
                            }}
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
