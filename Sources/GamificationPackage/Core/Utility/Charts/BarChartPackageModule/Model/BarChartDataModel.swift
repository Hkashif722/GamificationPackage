//
//  BarChartDataModel.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 31/07/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct BarChartDataModel {

    
    
    // MARK: - Configuration
    struct BarChartConfiguration {
        let maxValue: Double
        let minValue: Double
        let barColor: Color
        let gridLineColor: Color
        let labelColor: Color
        let chartHeight: CGFloat
        let barWidthRatio: CGFloat
        let barSpacingRatio: CGFloat
        let cornerRadius: CGFloat
        let showGridLines: Bool
        let gridLineInterval: Double
        
        init(
            maxValue: Double = 100,
            minValue: Double = 0,
            barColor: Color = Color(hex: "#7f60db"),
            gridLineColor: Color = Color.gray.opacity(0.3),
            labelColor: Color = Color.gray,
            chartHeight: CGFloat = 200,
            barWidthRatio: CGFloat = 0.9,
            barSpacingRatio: CGFloat = 0.009,
            cornerRadius: CGFloat = 2,
            showGridLines: Bool = true,
            gridLineInterval: Double = 20
        ) {
            self.maxValue = maxValue
            self.minValue = minValue
            self.barColor = barColor
            self.gridLineColor = gridLineColor
            self.labelColor = labelColor
            self.chartHeight = chartHeight
            self.barWidthRatio = barWidthRatio
            self.barSpacingRatio = barSpacingRatio
            self.cornerRadius = cornerRadius
            self.showGridLines = showGridLines
            self.gridLineInterval = gridLineInterval
        }
        
        static let `default` = BarChartConfiguration()
    }
    
}

extension BarChartDataModel {
    
    struct BarChartDataPoint: BarChartDataPointProtocol {
        let label: String
        let value: Double
        let color: Color?
        
        // Backward compatible initializer
        init(label: String, value: Double) {
            self.label = label
            self.value = value
            self.color = nil
        }
        
        // Full initializer with color
        init(label: String, value: Double, color: Color?) {
            self.label = label
            self.value = value
            self.color = color
        }
    }
    
    static let monthlyDataPreview = [
        BarChartDataPoint(label: "जनवरी", value: 72),
        BarChartDataPoint(label: "फरवरी", value: 85),
        BarChartDataPoint(label: "मार्च", value: 85),
        BarChartDataPoint(label: "अप्रैल", value: 72),
        BarChartDataPoint(label: "मई", value: 85),
        BarChartDataPoint(label: "जून", value: 85),
        BarChartDataPoint(label: "जुलाई", value: 85),
        BarChartDataPoint(label: "अगस्त", value: 72),
        BarChartDataPoint(label: "सितंबर", value: 85),
        BarChartDataPoint(label: "अक्टूबर", value: 72),
        BarChartDataPoint(label: "नवंबर", value: 72),
        BarChartDataPoint(label: "दिसंबर", value: 72)
    ]
    
    // Example matching the screenshot with different colored bars
    static let houseDataPreview = [
        BarChartDataPoint(label: "Red House", value: 48200, color: .red),
        BarChartDataPoint(label: "Green House", value: 59200, color: .green),
        BarChartDataPoint(label: "Blue House", value: 25200, color: .blue),
        BarChartDataPoint(label: "Yellow House", value: 42200, color: .yellow)
    ]
}
