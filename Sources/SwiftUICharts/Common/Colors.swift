//
//  Colors.swift
//  SwiftUICharts
//
//  Created by András Samu on 2019. 07. 19..
//  Copyright © 2019. András Samu. All rights reserved.
//

import Foundation
import SwiftUI

public enum Colors {
    public static let color1 = Color(hexString: "#E2FAE7")
    public static let color1Accent = Color(hexString: "#72BF82")
    public static let color2 = Color(hexString: "#EEF1FF")
    public static let color2Accent = Color(hexString: "#4266E8")
    public static let color3 = Color(hexString: "#FCECEA")
    public static let color3Accent = Color(hexString: "#E1614C")
    public static let OrangeEnd = Color(hexString: "#FF782C")
    public static let OrangeStart = Color(hexString: "#EC2301")
    public static let LegendText = Color(hexString: "#A7A6A8")
    public static let LegendColor = Color(hexString: "#E8E7EA")
    public static let LegendDarkColor = Color(hexString: "#545454")
    public static let IndicatorKnob = Color(hexString: "#FF57A6")
    public static let GradientUpperBlue = Color(hexString: "#C2E8FF")
    public static let GradinetUpperBlue1 = Color(hexString: "#A8E1FF")
    public static let GradientPurple = Color(hexString: "#7B75FF")
    public static let GradientNeonBlue = Color(hexString: "#6FEAFF")
    public static let GradientLowerBlue = Color(hexString: "#F1F9FF")
    public static let DarkPurple = Color(hexString: "#1B205E")
    public static let BorderBlue = Color(hexString: "#4EBCFF")
}

extension Color {
    init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (r, g, b) = (int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (0, 0, 0)
        }
        self.init(red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255)
    }
}
