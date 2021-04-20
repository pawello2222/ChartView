//
//  GradientColor.swift
//  SwiftUICharts
//
//  Created by Pawel on 11/08/2020.
//  Copyright © 2020 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct GradientColor: Hashable {
    public let colors: [Color]

    public init(_ colors: Color...) {
        self.colors = colors
    }

    public var gradient: Gradient {
        Gradient(colors: colors)
    }
}

extension GradientColor {
    public static let orange = GradientColor(Colors.OrangeStart, Colors.OrangeEnd)
    public static let blue = GradientColor(Colors.GradientPurple, Colors.GradientNeonBlue)
    public static let green = GradientColor(Color(hexString: "0BCDF7"), Color(hexString: "A2FEAE"))
    public static let blu = GradientColor(Color(hexString: "0591FF"), Color(hexString: "29D9FE"))
    public static let bluPurpl = GradientColor(Color(hexString: "4ABBFB"), Color(hexString: "8C00FF"))
    public static let purple = GradientColor(Color(hexString: "741DF4"), Color(hexString: "C501B0"))
    public static let prplPink = GradientColor(Color(hexString: "BC05AF"), Color(hexString: "FF1378"))
    public static let prplNeon = GradientColor(Color(hexString: "FE019A"), Color(hexString: "FE0BF4"))
    public static let orngPink = GradientColor(Color(hexString: "FF8E2D"), Color(hexString: "FF4E7A"))
}
