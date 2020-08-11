//
//  GradientColor.swift
//  SwiftUICharts
//
//  Created by Pawel on 11/08/2020.
//  Copyright © 2020 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct GradientColor: Hashable {
    public let start: Color
    public let end: Color

    public init(color: Color) {
        self.start = color
        self.end = color
    }

    public init(start: Color, end: Color) {
        self.start = start
        self.end = end
    }

    public var gradient: Gradient {
        Gradient(colors: [start, end])
    }
}

public extension GradientColor {
    static let orange = GradientColor(start: Colors.OrangeStart, end: Colors.OrangeEnd)
    static let blue = GradientColor(start: Colors.GradientPurple, end: Colors.GradientNeonBlue)
    static let green = GradientColor(start: Color(hexString: "0BCDF7"), end: Color(hexString: "A2FEAE"))
    static let blu = GradientColor(start: Color(hexString: "0591FF"), end: Color(hexString: "29D9FE"))
    static let bluPurpl = GradientColor(start: Color(hexString: "4ABBFB"), end: Color(hexString: "8C00FF"))
    static let purple = GradientColor(start: Color(hexString: "741DF4"), end: Color(hexString: "C501B0"))
    static let prplPink = GradientColor(start: Color(hexString: "BC05AF"), end: Color(hexString: "FF1378"))
    static let prplNeon = GradientColor(start: Color(hexString: "FE019A"), end: Color(hexString: "FE0BF4"))
    static let orngPink = GradientColor(start: Color(hexString: "FF8E2D"), end: Color(hexString: "FF4E7A"))
}
