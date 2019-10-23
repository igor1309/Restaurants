//
//  SectionDeleteThis.swift
//  Restaurants
//
//  Created by Igor Malyarov on 23.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct SectionDeleteThis: View {
    var item: String
    var action: () -> Void
    @State private var showActionSheet = false
    
    var body: some View {
        
        EmptyView()
        
//      MARK: ПРОБЛЕМА:
//      MARK: УДАЛЕНИЕ ЧЕРЕЗ Detail вызывает ошибку
//      MARK: Modifying state during view update, this will cause undefined behavior.
//      MARK: поэтому удаление уведено (пока) в контекстные меню
        
        
        
//        Section(header: Text("Delete".uppercased()).padding(.top, 32),
//                footer: Text("This operation cannot be undone.")) {
//
//                    Button("Delete this \(item)") { self.showActionSheet = true }
//                        .foregroundColor(.systemRed)
//                        .actionSheet(isPresented: $showActionSheet) {
//                            ActionSheet(
//                                title: Text("Delete \(item)".uppercased()),
//                                message: Text("Are you sure you want to delete this \(item)?\nYou can't undo this action."),
//                                buttons: [
//                                    .cancel(),
//                                    .destructive(Text("Yes, delete it")) { self.action() }])}
//        }
    }
}

struct SectionDeleteThis_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                SectionDeleteThis(item: "TEST ITEM") {}
            }
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
