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
    private let darkModeStyle: ChartStyle
    private let formSize: CGSize
    private let dropShadow: Bool
    private let cornerImage: Image

    @State private var touchLocation: CGFloat = -1
    @State private var showLabelValue: Bool = false

    @State private var currentValue: String? = nil {
        didSet {
            if oldValue != self.currentValue && currentValue != nil {
                HapticFeedback.playSelection()
            }
        }
    }

    var isFullWidth: Bool {
        return self.formSize == ChartForm.large
    }

    public init(data: ChartData, title: String, legend: String? = nil, style: ChartStyle = .barChartStyleOrangeLight, formSize: CGSize = ChartForm.medium, dropShadow: Bool = true, cornerImage: Image = Image(systemName: "waveform.path.ecg")) {
        self.data = data
        self.title = title
        self.legend = legend
        self.style = style
        self.darkModeStyle = style.darkModeStyle != nil ? style.darkModeStyle! : .barChartStyleOrangeDark
        self.formSize = formSize
        self.dropShadow = dropShadow
        self.cornerImage = cornerImage
    }

    public var body: some View {
        ZStack {
            Rectangle()
                .fill(self.colorScheme == .dark ? self.darkModeStyle.backgroundColor : self.style.backgroundColor)
                .cornerRadius(20)
                .shadow(color: self.style.dropShadowColor, radius: self.dropShadow ? 8 : 0)
            VStack(alignment: .leading) {
                HStack {
                    if currentValue == nil {
                        Text(self.title)
                            .font(.headline)
                            .foregroundColor(self.colorScheme == .dark ? self.darkModeStyle.textColor : self.style.textColor)
                    } else {
                        Text(currentValue!)
                            .font(.headline)
                            .foregroundColor(self.colorScheme == .dark ? self.darkModeStyle.textColor : self.style.textColor)
                    }
                    if self.formSize == ChartForm.large && self.legend != nil {
                        Text(self.legend!)
                            .font(.callout)
                            .foregroundColor(self.colorScheme == .dark ? self.darkModeStyle.accentColor : self.style.accentColor)
                            .transition(.opacity)
                            .animation(.easeOut)
                    }
                    Spacer()
                    self.cornerImage
                        .imageScale(.large)
                        .foregroundColor(self.colorScheme == .dark ? self.darkModeStyle.legendTextColor : self.style.legendTextColor)
                }.padding()
                BarChartRow(data: data,
                            accentColor: self.colorScheme == .dark ? self.darkModeStyle.accentColor : self.style.accentColor,
                            gradientColor: self.colorScheme == .dark ? self.darkModeStyle.gradientColor : self.style.gradientColor,
                            touchLocation: self.$touchLocation)
                if self.legend != nil && self.formSize == ChartForm.medium && !self.showLabelValue {
                    Text(self.legend!)
                        .font(.headline)
                        .foregroundColor(self.colorScheme == .dark ? self.darkModeStyle.legendTextColor : self.style.legendTextColor)
                        .padding()
                } else if self.data.valuesGiven && currentChartPoint != nil {
                    LabelView(arrowOffset: self.getArrowOffset(touchLocation: self.touchLocation),
                              title: .constant(currentChartPoint!.0))
                        .offset(x: self.getLabelViewOffset(touchLocation: self.touchLocation), y: -6)
                        .foregroundColor(self.colorScheme == .dark ? self.darkModeStyle.legendTextColor : self.style.legendTextColor)
                }
            }
        }.frame(minWidth: self.formSize.width,
                maxWidth: self.isFullWidth ? .infinity : self.formSize.width,
                minHeight: self.formSize.height,
                maxHeight: self.formSize.height)
            .gesture(DragGesture()
                .onChanged { value in
                    self.touchLocation = value.location.x / self.formSize.width
                    self.currentValue = self.currentChartPoint?.formattedValue ?? ""
                    if self.data.valuesGiven, self.formSize == ChartForm.medium {
                        self.showLabelValue = true
                    }
                }
                .onEnded { value in
                    self.currentValue = nil
                    self.showLabelValue = false
                    self.touchLocation = -1
                }
            )
            .gesture(TapGesture()
            )
    }

}

private extension BarChartView {
    func getArrowOffset(touchLocation: CGFloat) -> Binding<CGFloat> {
        let realLoc = (self.touchLocation * self.formSize.width) - 50
        if realLoc < 10 {
            return .constant(realLoc - 10)
        } else if realLoc > self.formSize.width - 110 {
            return .constant((self.formSize.width - 110 - realLoc) * -1)
        } else {
            return .constant(0)
        }
    }

    func getLabelViewOffset(touchLocation: CGFloat) -> CGFloat {
        return min(self.formSize.width - 110, max(10, (self.touchLocation * self.formSize.width) - 50))
    }
    
    var currentChartPoint: ChartPoint? {
        guard !data.points.isEmpty else { return nil }
        let index = max(0, min(data.points.count - 1, Int(floor((touchLocation * formSize.width) / (formSize.width / CGFloat(data.points.count))))))
        return self.data.points[index]
    }
}
