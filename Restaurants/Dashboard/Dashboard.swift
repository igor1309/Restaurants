//
//  Dashboard.swift
//
//  Created by Igor Malyarov on 14.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct Dashboard: View {
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            
            NavigationView {
                RestaurantDetail()
            }
            .tabItem {
                Image(systemName: "square.stack.3d.up")
                //  square.stack.3d.up.fill square.stack.3d.up
                //  rectangle.stack
                //  doc.text.magnifyingglass
                //  list.bullet.below.rectangle
                Text("Restaurant")
            }
            .tag(0)
            
            ModelView()
                .tabItem {
                    Image(systemName: "perspective")
                    Text("Model")
            }
            .tag(1)
            
            SalesView()
                .tabItem {
                    Image(systemName: "square.and.line.vertical.and.square.fill") // square.and.line.vertical.and.square.fill
                    Text("Sales")
            }
            .tag(2)
            
            Finance()
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text("Finance")
            }
            .tag(3)
            
            SeatingCard()
                .tabItem {
                    Image(systemName: "rectangle.3.offgrid")
                    Text("Seating")
            }
            .tag(4)
        }
        .edgesIgnoringSafeArea(.top)
    }
}

#if DEBUG
struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard()
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
    }
}
#endif
