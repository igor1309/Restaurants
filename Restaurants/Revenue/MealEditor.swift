//
//  MealEditor.swift
//
//  Created by Igor Malyarov on 02.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct MealEditor: View {
    @EnvironmentObject var userData: UserData
    @Binding var draft: Meal
    @Binding var isNameUsed: Bool
    
    var body: some View {
        Group {
            Section(header: Text("Name, Decription, Status".uppercased())) {
                TextFieldWithReset("Name", text: $draft.name)
                    .alert(isPresented: $isNameUsed) {
                        Alert(title: Text("Duplicate name"),
                              message: Text("Name '\(draft.name)' is already taken, plese enter a different one."),
                              dismissButton: .default(Text("Ok")))}
                
                TextFieldWithReset("Decription", text: $draft.description)
                
                Toggle("Revenue Stream is Active", isOn: $draft.isOffered.animation())
            }
            
            if draft.isOffered {
                MealEditorSummarySection(meal: $draft)
                
                MealEditorCover(meal: $draft)
            }
        }
    }
}

#if DEBUG
struct MealEditor_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MealEditor(draft: .constant(Meal()), isNameUsed: .constant(false))
                .navigationBarTitle("Meal")
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
    }
}
#endif
