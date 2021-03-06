//
//  PieChartRow.swift
//  SwiftUICharts
//
//  Created by András Samu on 2019. 06. 12..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

struct PieChartRow: View {
    let data: ChartData
    let gradientColor: GradientColor
    let backgroundColor: Color
    @Binding var currentChartPoint: ChartPoint?

    @State private var currentIndex: Int? = nil {
        didSet {
            if oldValue != currentIndex {
                currentChartPoint = currentIndex != nil ? data.points[currentIndex!] : nil
            }
        }
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.clear
                ForEach(0 ..< self.slices.count, id: \.self) { index in
                    self.sliceView(geometry: geometry, index: index)
                }
            }
            .gesture(DragGesture()
                .onChanged { value in
                    let rect = geometry.frame(in: .local)
                    let isTouchInPie = self.isPointInCircle(point: value.location, circleRect: rect)
                    if isTouchInPie {
                        let touchDegree = self.degree(for: value.location, inCircleRect: rect)
                        self.currentIndex = self.slices.firstIndex { $0.startDeg < touchDegree && $0.endDeg > touchDegree } ?? nil
                    } else {
                        self.currentIndex = nil
                    }
                }
                .onEnded { _ in
                    self.currentIndex = nil
                }
            )
        }
    }

    func sliceView(geometry: GeometryProxy, index: Int) -> some View {
        PieChartCell(
            index: index,
            rect: geometry.frame(in: .local),
            startDeg: slices[index].startDeg,
            endDeg: slices[index].endDeg,
            gradientColor: data.points[index].gradientColor ?? gradientColor,
            backgroundColor: backgroundColor
        )
        .scaleEffect(currentIndex == index ? 1.12 : 1)
        .animation(Animation.spring())
    }
}

extension PieChartRow {
    private var values: [Double] {
        data.points.map(\.value)
    }

    private var maxValue: Double {
        values.reduce(0, +)
    }

    private var slices: [PieSlice] {
        var lastEndDeg: Double = 0
        return values.map { value in
            let normalized = Double(value) / Double(maxValue)
            let startDeg = lastEndDeg
            let endDeg = lastEndDeg + (normalized * 360)
            lastEndDeg = endDeg
            return PieSlice(startDeg: startDeg, endDeg: endDeg, value: value, normalizedValue: normalized)
        }
    }
}

extension PieChartRow {
    private struct PieSlice {
        let startDeg: Double
        let endDeg: Double
        let value: Double
        let normalizedValue: Double
    }
}

extension PieChartRow {
    private func isPointInCircle(point: CGPoint, circleRect: CGRect) -> Bool {
        let r = min(circleRect.width, circleRect.height) / 2
        let center = CGPoint(x: circleRect.midX, y: circleRect.midY)
        let dx = point.x - center.x
        let dy = point.y - center.y
        let distance = sqrt(dx * dx + dy * dy)
        return distance <= r
    }

    private func degree(for point: CGPoint, inCircleRect circleRect: CGRect) -> Double {
        let center = CGPoint(x: circleRect.midX, y: circleRect.midY)
        let dx = point.x - center.x
        let dy = point.y - center.y
        let acuteDegree = Double(atan(dy / dx)) * (180 / .pi)

        let isInBottomRight = dx >= 0 && dy >= 0
        let isInBottomLeft = dx <= 0 && dy >= 0
        let isInTopLeft = dx <= 0 && dy <= 0
        let isInTopRight = dx >= 0 && dy <= 0

        if isInBottomRight {
            return acuteDegree
        } else if isInBottomLeft {
            return 180 - abs(acuteDegree)
        } else if isInTopLeft {
            return 180 + abs(acuteDegree)
        } else if isInTopRight {
            return 360 - abs(acuteDegree)
        }

        return 0
    }
}
