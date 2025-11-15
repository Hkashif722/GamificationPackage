//
//  BarChartDataPointProtocol.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 31/07/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//


import SwiftUI

internal protocol BarChartDataPointProtocol {
    var label: String { get }
    var value: Double { get }
    var color: Color? { get }
}
