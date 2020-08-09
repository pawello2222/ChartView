//
//  PieChartRow.swift
//  SwiftUICharts
//
//  Created by András Samu on 2019. 06. 12..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

extension PieChartView {
    public struct PieChartRow: View {
        public var data: ChartData
        var backgroundColor: Color
        var accentColor: Color
        var values: [Double] {
            data.points.map(\.value)
        }

        var maxValue: Double {
            values.reduce(0, +)
        }

        var slices: [PieSlice] {
            var tempSlices: [PieSlice] = []
            var lastEndDeg: Double = 0
            for slice in values {
                let normalized: Double = Double(slice) / Double(maxValue)
                let startDeg = lastEndDeg
                let endDeg = lastEndDeg + (normalized * 360)
                lastEndDeg = endDeg
                tempSlices.append(PieSlice(startDeg: startDeg, endDeg: endDeg, value: slice, normalizedValue: normalized))
            }
            return tempSlices
        }

        @Binding var showValue: Bool
        @Binding var currentValue: String

        @State private var currentTouchedIndex: Int? = nil {
            didSet {
                if oldValue != currentTouchedIndex {
                    showValue = currentTouchedIndex != nil
                    currentValue = showValue ? data.points[currentTouchedIndex!].formattedValue : ""
                }
            }
        }

        public var body: some View {
            GeometryReader { geometry in
                ZStack {
                    ForEach(0 ..< self.slices.count) { i in
                        PieChartCell(index: i, accentColor: self.data.points[i].color, backgroundColor: self.backgroundColor, rect: geometry.frame(in: .local), startDeg: self.slices[i].startDeg, endDeg: self.slices[i].endDeg)
                            .scaleEffect(self.currentTouchedIndex == i ? 1.1 : 1)
                            .animation(Animation.spring())
                    }
                }
                .gesture(DragGesture()
                    .onChanged { value in
                        let rect = geometry.frame(in: .local)
                        let isTouchInPie = self.isPointInCircle(point: value.location, circleRect: rect)
                        if isTouchInPie {
                            let touchDegree = self.degree(for: value.location, inCircleRect: rect)
                            self.currentTouchedIndex = self.slices.firstIndex { $0.startDeg < touchDegree && $0.endDeg > touchDegree } ?? nil
                        } else {
                            self.currentTouchedIndex = nil
                        }
                    }
                    .onEnded { value in
                        self.currentTouchedIndex = nil
                    })
            }
        }
    }
}

extension PieChartView.PieChartRow {
    struct PieSlice: Identifiable {
        var id = UUID()
        var startDeg: Double
        var endDeg: Double
        var value: Double
        var normalizedValue: Double
    }
}

extension PieChartView.PieChartRow {
    func isPointInCircle(point: CGPoint, circleRect: CGRect) -> Bool {
        let r = min(circleRect.width, circleRect.height) / 2
        let center = CGPoint(x: circleRect.midX, y: circleRect.midY)
        let dx = point.x - center.x
        let dy = point.y - center.y
        let distance = sqrt(dx * dx + dy * dy)
        return distance <= r
    }

    func degree(for point: CGPoint, inCircleRect circleRect: CGRect) -> Double {
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
