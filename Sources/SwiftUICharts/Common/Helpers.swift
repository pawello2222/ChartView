//
//  Helpers.swift
//  SwiftUICharts
//
//  Created by Pawel on 09/08/2020.
//  Copyright © 2020 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

class HapticFeedback {
    #if os(watchOS)
    // watchOS implementation
    static func playSelection() {
        WKInterfaceDevice.current().play(.click)
    }

    #else
    // iOS implementation
    let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
    static func playSelection() {
        UISelectionFeedbackGenerator().selectionChanged()
    }
    #endif
}
