//
//  PieChartView.swift
//  SwiftUICharts
//
//  Created by András Samu on 2019. 06. 12..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

public struct PieChartView: View {
    public let data: ChartData
    public let title: String
    public let legend: String?
    public let style: ChartStyle
    public let formSize: CGSize
    public let dropShadow: Bool

    @State private var currentValue: String? = nil {
        didSet {
            if oldValue != currentValue && currentValue != nil {
                HapticFeedback.playSelection()
            }
        }
    }

    public init(data: ChartData, title: String, legend: String? = nil, style: ChartStyle = .pieChartStyleOne,
                formSize: CGSize = ChartForm.medium, dropShadow: Bool = true) {
        self.data = data
        self.title = title
        self.legend = legend
        self.style = style
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
                .fill(style.backgroundColor)
                .cornerRadius(20)
                .shadow(color: style.dropShadowColor, radius: dropShadow ? 10 : 0)
            VStack(alignment: .leading) {
                HStack {
                    if currentValue == nil {
                        Text(title)
                            .font(.headline)
                            .foregroundColor(style.textColor)
                    } else {
                        Text(currentValue!)
                            .font(.headline)
                            .foregroundColor(style.textColor)
                    }
                    Spacer()
                    Image(systemName: "chart.pie.fill")
                        .imageScale(.large)
                        .foregroundColor(style.legendTextColor)
                }
                .padding()
                PieChartRow(data: data, accentColor: style.accentColor, backgroundColor: style.backgroundColor,
                            currentValue: $currentValue)
                    .foregroundColor(style.accentColor)
                    .padding(legend != nil ? 0 : 12)
                    .offset(y: legend != nil ? 0 : -10)
                    .id(data)
                if legend != nil {
                    Text(legend!)
                        .font(.headline)
                        .foregroundColor(style.legendTextColor)
                        .padding()
                }
            }
        }
        .frame(width: formSize.width, height: formSize.height)
    }
}
