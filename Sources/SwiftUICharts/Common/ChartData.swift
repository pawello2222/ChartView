//
//  ChartData.swift
//  SwiftUICharts
//
//  Created by Pawel on 09/08/2020.
//  Copyright © 2020 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public typealias ChartPoint = (label: String, value: Double, formattedValue: String, color: Color)

public class ChartData: ObservableObject, Identifiable {
    @Published var points: [ChartPoint]
    var valuesGiven: Bool = true
    var ID = UUID()

    public init(points: [ChartPoint]) {
        self.points = points
    }
}

//public extension ChartData {
//    struct ChartPoint {
//        let label: String?
//        let value: Double
//        let formattedValue: String
//        let color: Color?
//    }
//}
