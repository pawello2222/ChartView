//
//  PieChartCell.swift
//  SwiftUICharts
//
//  Created by András Samu on 2019. 06. 12..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

struct PieChartCell: View {
    let index: Int
    let rect: CGRect
    let startDeg: Double
    let endDeg: Double
    let gradientColor: GradientColor
    let backgroundColor: Color

    @State private var show: Bool = false

    var body: some View {
        path
            .fill(LinearGradient(gradient: gradientColor.gradient, startPoint: .bottom, endPoint: .top))
            .overlay(path.stroke(backgroundColor, lineWidth: 2))
            .scaleEffect(show ? 1 : 0)
            .animation(Animation.spring().delay(Double(index) * 0.04), value: show)
            .onAppear {
                self.show = true
            }
    }
}

extension PieChartCell {
    private var radius: CGFloat {
        min(rect.width, rect.height) / 2
    }

    private var path: Path {
        var path = Path()
        path.addArc(center: rect.mid, radius: radius, startAngle: Angle(degrees: startDeg),
                    endAngle: Angle(degrees: endDeg), clockwise: false)
        path.addLine(to: rect.mid)
        path.closeSubpath()
        return path
    }
}

extension CGRect {
    fileprivate var mid: CGPoint {
        CGPoint(x: midX, y: midY)
    }
}
