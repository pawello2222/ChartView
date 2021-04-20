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
    let gradientColor: GradientColor
    @Binding var touchLocation: CGFloat?

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.clear
                self.row(geometry: geometry)
                    .padding([.top, .leading, .trailing], 10)
            }
        }
    }
}

extension BarChartRow {
    private func row(geometry: GeometryProxy) -> some View {
        HStack(alignment: .bottom, spacing: (geometry.frame(in: .local).width - 22) / CGFloat(values.count * 3)) {
            ForEach(0 ..< values.count, id: \.self) { index in
                self.cell(geometry: geometry, index: index)
            }
        }
    }

    private func cell(geometry: GeometryProxy, index: Int) -> some View {
        BarChartCell(
            index: index,
            value: normalizedValue(index: index),
            width: (geometry.frame(in: .local).width - 22) / (CGFloat(values.count) * 1.5),
            gradientColor: data.points[index].gradientColor ?? gradientColor
        )
        .scaleEffect(isTouchInCell(index: index) ? CGSize(width: 1.4, height: 1.1) : CGSize(width: 1, height: 1),
                     anchor: .bottom)
        .animation(.spring())
    }
}

extension BarChartRow {
    private var values: [Double] {
        data.points.map(\.value)
    }

    private var maxValue: Double {
        guard let max = values.max() else {
            return 1
        }
        return max != 0 ? max : 1
    }

    private func normalizedValue(index: Int) -> Double {
        Double(values[index]) / Double(maxValue)
    }

    private func isTouchInCell(index: Int) -> Bool {
        guard let touchLocation = touchLocation else {
            return false
        }
        return touchLocation > CGFloat(index) / CGFloat(values.count)
            && touchLocation < CGFloat(index + 1) / CGFloat(values.count)
    }
}
