//
//  BarChartView.swift
//  SwiftUICharts
//
//  Created by András Samu on 2019. 06. 12..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

public struct BarChartView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    private let data: ChartData
    private let title: String
    private let legend: String?
    private let style: ChartStyle
    private let darkStyle: ChartStyle
    private let formSize: CGSize
    private let dropShadow: Bool
    private let showLabels: Bool
    private let cornerImage: Image

    @State private var touchLocation: CGFloat?

    @State private var currentValue: String? {
        didSet {
            if oldValue != currentValue && currentValue != nil {
                HapticFeedback.playSelection()
            }
        }
    }

    public init(data: ChartData, title: String, legend: String? = nil, style: ChartStyle = .barChartStyleOrangeLight,
                formSize: CGSize = ChartForm.medium, dropShadow: Bool = true, showLabels: Bool = true,
                cornerImage: Image = Image(systemName: "waveform.path.ecg")) {
        self.data = data
        self.title = title
        self.legend = legend
        self.style = style
        self.darkStyle = style.darkStyle ?? .barChartStyleOrangeDark
        self.formSize = formSize
        self.dropShadow = dropShadow
        self.cornerImage = cornerImage
        self.showLabels = showLabels
    }

    public var body: some View {
        ZStack {
            Rectangle()
                .fill(currentStyle.backgroundColor)
                .cornerRadius(20)
                .shadow(color: currentStyle.dropShadowColor, radius: dropShadow ? 8 : 0)
            VStack(alignment: .leading) {
                topView
                BarChartRow(data: data, accentColor: currentStyle.accentColor,
                            gradientColor: currentStyle.gradientColor, touchLocation: $touchLocation)
//                if self.legend != nil && self.formSize == ChartForm.medium && !self.showLabelValue {
//                    Text(self.legend!)
//                        .font(.headline)
//                        .foregroundColor(self.colorScheme == .dark ? self.darkModeStyle.legendTextColor : self.style.legendTextColor)
//                        .padding()
//                } else if self.data.valuesGiven && currentChartPoint != nil {
//                    LabelView(arrowOffset: self.getArrowOffset(touchLocation: self.touchLocation),
//                              title: .constant(currentChartPoint!.0))
//                        .offset(x: self.getLabelViewOffset(touchLocation: self.touchLocation), y: -6)
//                        .foregroundColor(self.colorScheme == .dark ? self.darkModeStyle.legendTextColor : self.style.legendTextColor)
//                }
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

private extension BarChartView {
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
            if self.formSize == ChartForm.large && self.legend != nil {
                Text(self.legend!)
                    .font(.callout)
                    .foregroundColor(currentStyle.accentColor)
                    .transition(.opacity)
                    .animation(.easeOut)
            }
            Spacer()
            self.cornerImage
                .imageScale(.large)
                .foregroundColor(currentStyle.legendTextColor)
        }
        .padding()
    }
}

private extension BarChartView {
    var currentChartPoint: ChartPoint? {
        guard !data.points.isEmpty, touchLocation != nil else { return nil }
        let index = max(0, min(data.points.count - 1,
                               Int(floor((touchLocation! * formSize.width) / (formSize.width / CGFloat(data.points.count))))))
        return self.data.points[index]
    }

    var currentStyle: ChartStyle {
        colorScheme == .dark ? darkStyle : style
    }

//    var showLabelValue: Bool {
//        touchLocation != nil && data.points.first?.label != nil
//    }

//    func getArrowOffset(touchLocation: CGFloat) -> Binding<CGFloat> {
//        guard touchLocation != nil else { return }
//        let realLoc = (self.touchLocation * self.formSize.width) - 50
//        if realLoc < 10 {
//            return .constant(realLoc - 10)
//        } else if realLoc > self.formSize.width - 110 {
//            return .constant((self.formSize.width - 110 - realLoc) * -1)
//        } else {
//            return .constant(0)
//        }
//    }

//    func getLabelViewOffset(touchLocation: CGFloat) -> CGFloat {
//        return min(self.formSize.width - 110, max(10, (self.touchLocation * self.formSize.width) - 50))
//    }
}
