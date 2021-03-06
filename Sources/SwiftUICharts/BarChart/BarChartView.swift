//
//  BarChartView.swift
//  SwiftUICharts
//
//  Created by András Samu on 2019. 06. 12..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

public struct BarChartView<ImageContent>: View where ImageContent: View {
    @Environment(\.colorScheme) private var colorScheme
    private let data: ChartData
    private let title: String
    private let legend: String?
    private let style: ChartStyle
    private let darkStyle: ChartStyle
    private let formSize: CGSize
    private let dropShadow: Bool
    private let cornerImage: () -> ImageContent

    @State private var touchLocation: CGFloat?

    @State private var currentValue: String? {
        didSet {
            if oldValue != currentValue && currentValue != nil {
                HapticFeedback.playSelection()
            }
        }
    }

    private var currentChartPoint: ChartPoint? {
        guard !data.points.isEmpty, touchLocation != nil else {
            return nil
        }
        let index = max(
            0,
            min(
                data.points.count - 1,
                Int(floor((touchLocation! * formSize.width) / (formSize.width / CGFloat(data.points.count))))
            )
        )
        return data.points[index]
    }

    private var currentStyle: ChartStyle {
        colorScheme == .dark ? darkStyle : style
    }

    public init(
        data: ChartData,
        title: String,
        legend: String? = nil,
        style: ChartStyle = .barChartStyleOrangeLight,
        formSize: CGSize = ChartForm.medium,
        dropShadow: Bool = true,
        cornerImage: @escaping () -> ImageContent
    ) {
        self.data = data
        self.title = title
        self.legend = legend
        self.style = style
        darkStyle = style.darkStyle ?? .barChartStyleOrangeDark
        self.formSize = formSize
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
                BarChartRow(data: data, gradientColor: currentStyle.gradientColor, touchLocation: $touchLocation)
                    .id(data)
                ZStack(alignment: .leading) {
                    legendView
                    labelView
                }
            }
        }
        .frame(width: formSize.width, height: formSize.height)
        .gesture(DragGesture()
            .onChanged { touch in
                self.touchLocation = touch.location.x / self.formSize.width
                self.currentValue = self.currentChartPoint?.formattedValue ?? ""
            }
            .onEnded { _ in
                self.touchLocation = nil
                self.currentValue = nil
            }
        )
    }
}

extension BarChartView where ImageContent == EmptyView {
    public init(
        data: ChartData,
        title: String,
        legend: String? = nil,
        style: ChartStyle = .barChartStyleOrangeLight,
        formSize: CGSize = ChartForm.medium,
        dropShadow: Bool = true
    ) {
        self.data = data
        self.title = title
        self.legend = legend
        self.style = style
        darkStyle = style.darkStyle ?? .barChartStyleOrangeDark
        self.formSize = formSize
        self.dropShadow = dropShadow
        cornerImage = { EmptyView() }
    }
}

extension BarChartView {
    private var topView: some View {
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
            self.cornerImage()
                .foregroundColor(currentStyle.legendTextColor)
        }
        .padding()
    }

    @ViewBuilder
    private var legendView: some View {
        if legend != nil {
            Text(legend!)
                .font(.headline)
                .foregroundColor(currentStyle.legendTextColor)
                .opacity(currentChartPoint == nil ? 1 : 0.1)
                .padding()
        }
    }

    @ViewBuilder
    private var labelView: some View {
        if legend != nil && currentChartPoint != nil {
            LabelView(showArrow: true, arrowOffset: arrowOffset, title: currentChartPoint!.label ?? "")
                .offset(x: labelViewOffset, y: -6)
                .foregroundColor(currentStyle.legendTextColor)
        }
    }
}

extension BarChartView {
    private var arrowOffset: CGFloat {
        guard let touchLocation = touchLocation else {
            return 0
        }

        let realLoc = (touchLocation * formSize.width) - 50
        if realLoc < 10 {
            return realLoc - 10
        } else if realLoc > formSize.width - 110 {
            return (formSize.width - 110 - realLoc) * -1
        } else {
            return 0
        }
    }

    private var labelViewOffset: CGFloat {
        guard let touchLocation = touchLocation else {
            return 0
        }
        return min(formSize.width - 110, max(10, (touchLocation * formSize.width) - 50))
    }
}
