//
//  BarChartRow.swift
//  SwiftUICharts
//
//  Created by András Samu on 2019. 06. 12..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

struct BarChartRow: View {
    let data: ChartData
    let accentColor: Color
    let gradientColor: GradientColor?
    @Binding var touchLocation: CGFloat

    var body: some View {
        GeometryReader { geometry in
            self.row(geometry: geometry)
                .padding([.top, .leading, .trailing], 10)
        }
    }
}

private extension BarChartRow {
    func row(geometry: GeometryProxy) -> some View {
        HStack(alignment: .bottom, spacing: (geometry.frame(in: .local).width - 22) / CGFloat(values.count * 3)) {
            ForEach(0 ..< values.count, id: \.self) { index in
                self.cell(geometry: geometry, index: index)
            }
        }
    }

    func cell(geometry: GeometryProxy, index: Int) -> some View {
        BarChartCell(index: index,
                     value: self.normalizedValue(index: index),
                     width: geometry.frame(in: .local).width - 22,
                     numberOfDataPoints: values.count,
                     accentColor: self.accentColor,
                     gradientColor: self.gradientColor,
                     touchLocation: self.$touchLocation)
            .scaleEffect(self.touchLocation > CGFloat(index) / CGFloat(values.count) && self.touchLocation < CGFloat(index + 1) / CGFloat(values.count) ? CGSize(width: 1.4, height: 1.1) : CGSize(width: 1, height: 1), anchor: .bottom)
            .animation(.spring())
    }
}

private extension BarChartRow {
    var values: [Double] {
        data.points.map(\.value)
    }

    var maxValue: Double {
        guard let max = values.max() else {
            return 1
        }
        return max != 0 ? max : 1
    }

    func normalizedValue(index: Int) -> Double {
        return Double(values[index]) / Double(maxValue)
    }
}
