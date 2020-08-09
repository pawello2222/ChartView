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
    let width: CGFloat
    let accentColor: Color
    let gradientColor: GradientColor?

    @State var scaleValue: Double = 0

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(
                    LinearGradient(gradient: gradientColor?.getGradient()
                        ?? Gradient(colors: [accentColor, accentColor]), startPoint: .bottom, endPoint: .top)
                )
        }
        .frame(width: width)
        .scaleEffect(CGSize(width: 1, height: scaleValue), anchor: .bottom)
        .animation(Animation.spring().delay(Double(index) * 0.04))
        .onAppear {
            self.scaleValue = self.value
        }
    }
}
