//
//  ChartForm.swift
//  SwiftUICharts
//
//  Created by Pawel on 09/08/2020.
//  Copyright © 2020 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct ChartForm {
    #if os(watchOS)
    public static let small = CGSize(width: 120, height: 90)
    public static let medium = CGSize(width: 120, height: 160)
    public static let large = CGSize(width: 180, height: 90)
    public static let extraLarge = CGSize(width: 180, height: 90)
    public static let detail = CGSize(width: 180, height: 160)
    #else
    public static let small = CGSize(width: 180, height: 120)
    public static let medium = CGSize(width: 180, height: 240)
    public static let large = CGSize(width: 360, height: 120)
    public static let extraLarge = CGSize(width: 360, height: 240)
    public static let detail = CGSize(width: 180, height: 120)
    #endif
}
