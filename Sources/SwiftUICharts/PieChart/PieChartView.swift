//
//  PieChartView.swift
//  SwiftUICharts
//
//  Created by András Samu on 2019. 06. 12..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

public struct PieChartView: View {
    @Environment(\.colorScheme) private var colorScheme
    private let data: ChartData
    private let title: String
    private let legend: String?
    private let style: ChartStyle
    private let darkStyle: ChartStyle
    private let formSize: CGSize
    private let dropShadow: Bool

    @State private var currentValue: String? = nil {
        didSet {
            if oldValue != currentValue && currentValue != nil {
                HapticFeedback.playSelection()
            }
        }
    }

    private var currentStyle: ChartStyle {
        colorScheme == .dark ? darkStyle : style
    }

    public init(data: ChartData, title: String, legend: String? = nil, style: ChartStyle = .pieChartStyleOne,
                formSize: CGSize = ChartForm.medium, dropShadow: Bool = true) {
        self.data = data
        self.title = title
        self.legend = legend
        self.style = style
        self.darkStyle = style.darkStyle ?? .barChartStyleOrangeDark
        if formSize == ChartForm.large {
            self.formSize = ChartForm.extraLarge
        } else {
            self.formSize = formSize
        }
        self.dropShadow = dropShadow
    }

    public var body: some View {
        ZStack {
            Rectangle()
                .fill(currentStyle.backgroundColor)
                .cornerRadius(20)
                .shadow(color: currentStyle.dropShadowColor, radius: dropShadow ? 10 : 0)
            VStack(alignment: .leading) {
                topView
                PieChartRow(data: data, gradientColor: currentStyle.gradientColor,
                            backgroundColor: currentStyle.backgroundColor, currentValue: $currentValue)
                    .padding(legend != nil ? 0 : 12)
                    .offset(y: legend != nil ? 0 : -10)
                    .id(data)
                legendView
            }
        }
        .frame(width: formSize.width, height: formSize.height)
    }
}

private extension PieChartView {
    var topView: some View {
        HStack {
            if currentValue == nil {
                Text(title)
                    .font(.headline)
                    .foregroundColor(currentStyle.textColor)
            } else {
                Text(currentValue!)
                    .font(.headline)
                    .foregroundColor(currentStyle.textColor)
            }
            Spacer()
            Image(systemName: "chart.pie.fill")
                .imageScale(.large)
                .foregroundColor(currentStyle.legendTextColor)
        }
        .padding()
    }

    @ViewBuilder
    var legendView: some View {
        if legend != nil {
            Text(legend!)
                .font(.headline)
                .foregroundColor(currentStyle.legendTextColor)
                .padding()
        }
    }
}
