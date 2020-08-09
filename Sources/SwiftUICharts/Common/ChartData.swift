//
//  ChartData.swift
//  SwiftUICharts
//
//  Created by Pawel on 09/08/2020.
//  Copyright © 2020 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct ChartData: Hashable {
    let points: [ChartPoint]

    public init(points: [ChartPoint]) {
        self.points = points
    }
}

public struct ChartPoint: Hashable {
    let label: String?
    let value: Double
    let formattedValue: String
    let color: Color?

    public init(label: String? = nil, value: Double, formattedValue: String, color: Color? = nil) {
        self.label = label
        self.value = value
        self.formattedValue = formattedValue
        self.color = color
    }
}
