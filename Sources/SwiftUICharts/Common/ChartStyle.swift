//
//  ChartStyle.swift
//  SwiftUICharts
//
//  Created by Pawel on 09/08/2020.
//  Copyright © 2020 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public class ChartStyle {
    public var backgroundColor: Color
    public var accentColor: Color
    public var gradientColor: GradientColor
    public var textColor: Color
    public var legendTextColor: Color
    public var dropShadowColor: Color
    public weak var darkStyle: ChartStyle?

    public init(
        backgroundColor: Color,
        accentColor: Color,
        secondGradientColor: Color,
        textColor: Color,
        legendTextColor: Color,
        dropShadowColor: Color
    ) {
        self.backgroundColor = backgroundColor
        self.accentColor = accentColor
        gradientColor = GradientColor(accentColor, secondGradientColor)
        self.textColor = textColor
        self.legendTextColor = legendTextColor
        self.dropShadowColor = dropShadowColor
    }

    public init(
        backgroundColor: Color,
        accentColor: Color,
        gradientColor: GradientColor,
        textColor: Color,
        legendTextColor: Color,
        dropShadowColor: Color
    ) {
        self.backgroundColor = backgroundColor
        self.accentColor = accentColor
        self.gradientColor = gradientColor
        self.textColor = textColor
        self.legendTextColor = legendTextColor
        self.dropShadowColor = dropShadowColor
    }

    public init() {
        backgroundColor = .white
        accentColor = Colors.OrangeStart
        gradientColor = .orange
        legendTextColor = .gray
        textColor = .black
        dropShadowColor = .gray
    }
}

extension ChartStyle {
    public static let lineChartStyleOne = ChartStyle(
        backgroundColor: .white,
        accentColor: Colors.OrangeStart,
        secondGradientColor: Colors.OrangeEnd,
        textColor: .black,
        legendTextColor: .gray,
        dropShadowColor: .gray
    )

    public static let barChartStyleOrangeLight = ChartStyle(
        backgroundColor: .white,
        accentColor: Colors.OrangeStart,
        secondGradientColor: Colors.OrangeEnd,
        textColor: .black,
        legendTextColor: .gray,
        dropShadowColor: .gray
    )

    public static let barChartStyleOrangeDark = ChartStyle(
        backgroundColor: .black,
        accentColor: Colors.OrangeStart,
        secondGradientColor: Colors.OrangeEnd,
        textColor: .white,
        legendTextColor: .gray,
        dropShadowColor: .gray
    )

    public static let barChartStyleNeonBlueLight = ChartStyle(
        backgroundColor: .white,
        accentColor: Colors.GradientNeonBlue,
        secondGradientColor: Colors.GradientPurple,
        textColor: .black,
        legendTextColor: .gray,
        dropShadowColor: .gray
    )

    public static let barChartStyleNeonBlueDark = ChartStyle(
        backgroundColor: .black,
        accentColor: Colors.GradientNeonBlue,
        secondGradientColor: Colors.GradientPurple,
        textColor: .white,
        legendTextColor: .gray,
        dropShadowColor: .gray
    )

    public static let barChartMidnightGreenDark = ChartStyle(
        backgroundColor: Color(hexString: "#36534D"), // 3B5147, 313D34
        accentColor: Color(hexString: "#FFD603"),
        secondGradientColor: Color(hexString: "#FFCA04"),
        textColor: .white,
        legendTextColor: Color(hexString: "#D2E5E1"),
        dropShadowColor: .gray
    )

    public static let barChartMidnightGreenLight = ChartStyle(
        backgroundColor: .white,
        accentColor: Color(hexString: "#84A094"), // 84A094 , 698378
        secondGradientColor: Color(hexString: "#50675D"),
        textColor: .black,
        legendTextColor: .gray,
        dropShadowColor: .gray
    )

    public static let pieChartStyleOne = ChartStyle(
        backgroundColor: .white,
        accentColor: Colors.OrangeEnd,
        secondGradientColor: Colors.OrangeStart,
        textColor: .black,
        legendTextColor: .gray,
        dropShadowColor: .gray
    )

    public static let lineViewDarkMode = ChartStyle(
        backgroundColor: .black,
        accentColor: Colors.OrangeStart,
        secondGradientColor: Colors.OrangeEnd,
        textColor: .white,
        legendTextColor: .white,
        dropShadowColor: .gray
    )
}
