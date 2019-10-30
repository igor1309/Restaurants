//
//  SettingsStore.swift
//  RestaurantParts
//
//  Created by Igor Malyarov on 08.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation
import CoreHaptics

var hapticsAvailable: Bool { CHHapticEngine.capabilitiesForHardware().supportsHaptics }

final class SettingsStore: ObservableObject {
    @Published var selectedTab: Int = UserDefaults.standard.integer(forKey: "selectedTab") {
        didSet {
            UserDefaults.standard.set(selectedTab, forKey: "selectedTab")
        }
    }
}
