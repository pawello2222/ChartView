//
//  PieChartView.swift
//  SwiftUICharts
//
//  Created by András Samu on 2019. 06. 12..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

public struct PieChartView<ImageContent>: View where ImageContent: View {
    @Environment(\.colorScheme) private var colorScheme
    private let data: ChartData
    private let title: String
    private let legend: String?
    private let style: ChartStyle
    private let darkStyle: ChartStyle
    private let formSize: CGSize
    private let dropShadow: Bool
    private let cornerImage: () -> ImageContent

    @State private var currentChartPoint: ChartPoint? = nil {
        didSet {
            if oldValue != currentChartPoint && currentChartPoint != nil {
                HapticFeedback.playSelection()
            }
        }
    }

    private var currentStyle: ChartStyle {
        colorScheme == .dark ? darkStyle : style
    }

    public init(data: ChartData, title: String, legend: String? = nil, style: ChartStyle = .pieChartStyleOne,
                formSize: CGSize = ChartForm.medium, dropShadow: Bool = true,
                cornerImage: @escaping () -> ImageContent)
    {
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
        self.cornerImage = cornerImage
    }

    public var body: some View {
        ZStack {
            Rectangle()
                .fill(currentStyle.backgroundColor)
                .cornerRadius(20)
                .shadow(color: currentStyle.dropShadowColor, radius: dropShadow ? 8 : 0)
            VStack(alignment: .leading) {
                topView
                PieChartRow(data: data, gradientColor: currentStyle.gradientColor,
                            backgroundColor: currentStyle.backgroundColor, currentChartPoint: $currentChartPoint)
                    .padding(.bottom, 10)
                    .id(data)
                ZStack {
                    HStack {
                        legendView
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        labelView
                    }
                }
            }
        }
        .frame(width: formSize.width, height: formSize.height)
    }
}

public extension PieChartView where ImageContent == EmptyView {
    init(data: ChartData, title: String, legend: String? = nil, style: ChartStyle = .pieChartStyleOne,
         formSize: CGSize = ChartForm.medium, dropShadow: Bool = true)
    {
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
        self.cornerImage = { EmptyView() }
    }
}

private extension PieChartView {
    var topView: some View {
        HStack {
            if currentChartPoint == nil {
                Text(title)
                    .font(.headline)
                    .foregroundColor(currentStyle.textColor)
            } else {
                Text(currentChartPoint!.formattedValue)
                    .font(.headline)
                    .foregroundColor(currentStyle.textColor)
            }
            Spacer()
            self.cornerImage()
                .foregroundColor(currentStyle.legendTextColor)
        }
        .padding([.top, .leading, .trailing])
    }

    @ViewBuilder
    var legendView: some View {
        if legend != nil {
            Text(legend!)
                .font(.headline)
                .foregroundColor(currentStyle.legendTextColor)
                .opacity(currentChartPoint == nil ? 1 : 0.1)
                .padding([.bottom, .leading, .trailing])
        }
    }

    @ViewBuilder
    var labelView: some View {
        if legend != nil && currentChartPoint?.label != nil {
            LabelView(showArrow: false, arrowOffset: 0, title: currentChartPoint!.label ?? "")
                .offset(x: -10, y: -6)
                .foregroundColor(currentStyle.legendTextColor)
        }
    }
}
