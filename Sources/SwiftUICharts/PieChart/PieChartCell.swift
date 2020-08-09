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
    let accentColor: Color
    let backgroundColor: Color
    let rect: CGRect
    let startDeg: Double
    let endDeg: Double

    @State private var show: Bool = false

    var body: some View {
        path
            .fill()
            .foregroundColor(accentColor)
            .overlay(path.stroke(backgroundColor, lineWidth: 2))
            .scaleEffect(show ? 1 : 0)
            .animation(Animation.spring().delay(Double(index) * 0.04))
            .onAppear {
                self.show = true
            }
    }
}

private extension PieChartCell {
    var radius: CGFloat {
        min(rect.width, rect.height) / 2
    }

    var path: Path {
        var path = Path()
        path.addArc(center: rect.mid, radius: radius, startAngle: Angle(degrees: startDeg),
                    endAngle: Angle(degrees: endDeg), clockwise: false)
        path.addLine(to: rect.mid)
        path.closeSubpath()
        return path
    }
}

private extension CGRect {
    var mid: CGPoint {
        CGPoint(x: midX, y: midY)
    }
}
