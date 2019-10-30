//
//  ModelView.swift
//  Restaurants
//
//  Created by Igor Malyarov on 18.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct ModelView: View {
    @EnvironmentObject private var userData: UserData
    @State private var showModelSettings = false
    
    let cardWidth: CGFloat = 359
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 8) {
                
                Card(title: "Target",
                     subtitle: "Restaurant Data as entered",
                     trunk: Target(),
                     borderColor: .gray,
                     cornerRadius: 8)
                
                Text("Discounted Model Years")
                    .font(.headline)
                    .padding(.leading)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 0) {
                        
                        hScrollingCard(title: "Model Period",
                                       subtitle: "\(userData.modelYears.count) years, total",
                            trunk: ModelCardTotal(),
                            borderColor: .gray,
                            cornerRadius: 8)
                            .frame(minWidth: cardWidth)
                        
                        ForEach(userData.modelYears) { modelYear in
                            hScrollingCard(title: "Model Year \(modelYear.id.formattedGrouped)",
                                subtitle: "Discount \(modelYear.discount.formattedPercentage). Data per year.",
                                trunk: ModelCard(modelYear: modelYear),
                                borderColor: .gray,
                                cornerRadius: 8)
                                .frame(minWidth: self.cardWidth)
                        }
                    }
                    .padding(.top, 1)
                    .padding(.leading)
                }
                
                Spacer()
            }
            .navigationBarTitle("Model")
                
            .navigationBarItems(trailing:
                TrailingButtonSFSymbol("square.grid.2x2") {
                    self.showModelSettings = true }
                    .sheet(isPresented: self.$showModelSettings,
                           content: { ModelSettings()
                            .environmentObject(self.userData) }))
        }
    }
}

#if DEBUG
struct Model_Previews: PreviewProvider {
    static var previews: some View {
        ModelView()
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
    }
}
#endif
