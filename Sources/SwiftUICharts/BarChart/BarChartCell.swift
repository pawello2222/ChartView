//
//  BarChartCell.swift
//  SwiftUICharts
//
//  Created by András Samu on 2019. 06. 12..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

struct BarChartCell: View {
    let index: Int
    let value: Double
    let width: Float
    let numberOfDataPoints: Int

    var accentColor: Color
    var gradient: Gradient?

    @Binding var touchLocation: CGFloat

    @State var scaleValue: Double = 0

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(
                    LinearGradient(gradient: gradient
                        ?? Gradient(colors: [accentColor, accentColor]), startPoint: .bottom, endPoint: .top)
                )
        }
        .frame(width: CGFloat(cellWidth))
        .scaleEffect(CGSize(width: 1, height: scaleValue), anchor: .bottom)
        .onAppear {
            self.scaleValue = self.value
        }
        .animation(Animation.spring().delay(touchLocation < 0 ? Double(index) * 0.04 : 0))
    }
}

extension BarChartCell {
    var cellWidth: Double {
        Double(width) / (Double(numberOfDataPoints) * 1.5)
    }
}
