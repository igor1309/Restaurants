//
//  KPIRow.swift
//
//  Created by Igor Malyarov on 31.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct KPIRow : View {
    @EnvironmentObject private var userData: UserData
    var kpi: KPIItem
    @State private var showAlert = false
    @State private var showModal = false
    @State private var modal: ModalType = .detail

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            BasicRow(title: kpi.name, detail: kpi.dueDate.toString(), color: userData.restaurant.kpi.color(item: kpi))
            
            Text(kpi.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .contentShape(Rectangle())
        .onTapGesture { self.showModal = true }
        .sheet(isPresented: $showModal) {
            KPIDetail(kpi: self.kpi, isNew: false)
                .environmentObject(self.userData) }
                .contextMenu {
                    Button(action: {
                        self.modal = .detail
                        self.showModal = true
                    }) {
                        HStack {
                            Text("Show/Edit \("KPI")")
                            Image(systemName: "aspectratio")
                        }
                    }
                    Button(action: {
                        self.duplicate(self.kpi)
                    }) {
                        HStack {
                            Text("Duplicate \("KPI")")
                            Image(systemName: "plus.square.on.square")
                        }
                    }
                    Button(action: {
                        self.showAlert = true
                    }) {
                        HStack {
                            Text("Delete \("KPI")")
                            Image(systemName: "trash.circle")
                        }
                    }
                    .actionSheet(isPresented: $showAlert) {
                        ActionSheet(title: Text("Delete this \("KPI?")".uppercased()),
                                    message: Text("You can't undo this action."),
                                    buttons: [
                                        .cancel(),
                                        .destructive(Text("Yes, delete it")) { self.delete() } ])}}
        }
        
        func duplicate(_ kpi: KPIItem) {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            
            withAnimation {
                userData.restaurant.kpi.add(kpi)
            }
        }
        
        func delete() {
            let generator = UIImpactFeedbackGenerator(style: .medium)
            
            withAnimation {
                if userData.restaurant.kpi.delete(kpi) {
                    generator.impactOccurred()
                }
            }
}
}


#if DEBUG
struct KPIRow_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView {
            List(sampleKPI.kpis.indices) { index in
                KPIRow(kpi: sampleKPI.kpis[index])
            }
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
            .environmentObject(UserData())
        }
    }
}
#endif
