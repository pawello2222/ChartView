//
//  BarChartRow.swift
//  SwiftUICharts
//
//  Created by András Samu on 2019. 06. 12..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

struct BarChartRow: View {
    let data: [Double]
    let accentColor: Color
    let gradientColor: GradientColor?
    @Binding var touchLocation: CGFloat

    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .bottom, spacing: (geometry.frame(in: .local).width - 22) / CGFloat(self.data.count * 3)) {
                ForEach(0 ..< self.data.count, id: \.self) { i in
                    BarChartCell(index: i,
                                 value: self.normalizedValue(index: i),
                                 width: Float(geometry.frame(in: .local).width - 22),
                                 numberOfDataPoints: self.data.count,
                                 accentColor: self.accentColor,
                                 gradientColor: self.gradientColor,
                                 touchLocation: self.$touchLocation)
                        .scaleEffect(self.touchLocation > CGFloat(i) / CGFloat(self.data.count) && self.touchLocation < CGFloat(i + 1) / CGFloat(self.data.count) ? CGSize(width: 1.4, height: 1.1) : CGSize(width: 1, height: 1), anchor: .bottom)
                        .animation(.spring())
                }
            }
            .padding([.top, .leading, .trailing], 10)
        }
    }
}

private extension BarChartRow {
    var maxValue: Double {
        guard let max = data.max() else {
            return 1
        }
        return max != 0 ? max : 1
    }

    func normalizedValue(index: Int) -> Double {
        return Double(self.data[index]) / Double(self.maxValue)
    }
}
