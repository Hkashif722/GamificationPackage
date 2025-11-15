//
//  ReusableBarChartView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 31/07/25.
//  Copyright Â© 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

// MARK: - Reusable Bar Chart Component
struct ReusableBarChartView_iOS15<T: BarChartDataPointProtocol>: View {
    let data: [T]
    let configuration: BarChartDataModel.BarChartConfiguration
    
    private var gridLines: [Double] {
        Array(stride(from: configuration.minValue,
                    through: configuration.maxValue,
                    by: configuration.gridLineInterval))
    }
    
    private var optimalYAxisLabels: [Double] {
        // Calculate dynamic Y-axis labels based on data and chart height
        let desiredLabelCount = Int(configuration.chartHeight / 35) // ~35px between labels
        let actualMax = data.map { $0.value }.max() ?? configuration.maxValue
        let range = actualMax - configuration.minValue
        
        // Handle edge case where range is 0 or very small
        guard range > 0 else {
            return [configuration.minValue, actualMax]
        }
        
        // Calculate clean interval with better decimal support
        let rawInterval = range / Double(max(desiredLabelCount - 1, 1))
        
        // Improved magnitude calculation that handles small decimals
        let magnitude = pow(10, floor(log10(rawInterval)))
        let normalized = rawInterval / magnitude
        
        let cleanInterval: Double
        if normalized <= 1 { cleanInterval = magnitude }
        else if normalized <= 2 { cleanInterval = 2 * magnitude }
        else if normalized <= 5 { cleanInterval = 5 * magnitude }
        else { cleanInterval = 10 * magnitude }
        
        // Ensure minimum reasonable interval for very small values
        let finalInterval = max(cleanInterval, 0.01)
        
        // Generate labels starting from a clean value
        let startValue = floor(configuration.minValue / finalInterval) * finalInterval
        let maxLabel = ceil(actualMax / finalInterval) * finalInterval
        
        var labels: [Double] = []
        var currentValue = startValue
        while currentValue <= maxLabel + finalInterval * 0.001 { // Small epsilon for floating point comparison
            labels.append(currentValue)
            currentValue += finalInterval
        }
        
        // Ensure we have at least 2 labels and don't exceed reasonable count
        if labels.count < 2 {
            return [configuration.minValue, actualMax]
        } else if labels.count > 10 {
            // If too many labels, use every other one
            return labels.enumerated().compactMap { index, value in
                index % 2 == 0 ? value : nil
            }
        }
        
        return labels
    }
    
    // Helper function to format label text appropriately
    private func formatLabel(_ value: Double) -> String {
        // Handle large numbers with K suffix
        if value >= 10000 {
            let thousands = value / 1000
            if thousands == floor(thousands) {
                return "\(Int(thousands))K"
            } else {
                return String(format: "%.1fK", thousands)
            }
        } else if value >= 1000 {
            // For numbers between 1000-9999, show with comma or K
            if value == floor(value) {
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                formatter.maximumFractionDigits = 0
                return formatter.string(from: NSNumber(value: value)) ?? "\(Int(value))"
            } else {
                return String(format: "%.1f", value)
            }
        } else if value == floor(value) {
            return "\(Int(value))"
        } else if value < 1 {
            return String(format: "%.2f", value)
        } else if value < 10 {
            return String(format: "%.1f", value)
        } else {
            return String(format: "%.0f", value)
        }
    }
    
    init(data: [T], configuration: BarChartDataModel.BarChartConfiguration = .default) {
        self.data = data
        self.configuration = configuration
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Chart area with Y-axis labels
            HStack(alignment: .bottom, spacing: 0) {
                // Y-axis labels
                VStack(alignment: .trailing, spacing: 0) {
                    ForEach(Array(optimalYAxisLabels.reversed()), id: \.self) { value in
                        Text(formatLabel(value))
                            .font(.caption)
                            .foregroundColor(configuration.labelColor)
                            .frame(height: configuration.chartHeight / CGFloat(optimalYAxisLabels.count - 1), alignment: .bottom)
                    }
                }
                .frame(width: 35) // Increased width to accommodate decimal labels
                
                // Chart area
                GeometryReader { geometry in
                    ZStack(alignment: .bottomLeading) {
                        // Background grid lines
                        if configuration.showGridLines {
                            ForEach(optimalYAxisLabels, id: \.self) { value in
                                let maxDisplayValue = optimalYAxisLabels.max() ?? configuration.maxValue
                                let yPosition = geometry.size.height * (1 - CGFloat((value - configuration.minValue) / (maxDisplayValue - configuration.minValue)))
                                
                                Path { path in
                                    path.move(to: CGPoint(x: 0, y: yPosition))
                                    path.addLine(to: CGPoint(x: geometry.size.width, y: yPosition))
                                }
                                .stroke(configuration.gridLineColor, lineWidth: 0.5)
                            }
                        }
                        
                        // Bars container
                        HStack(alignment: .bottom, spacing: geometry.size.width * configuration.barSpacingRatio) {
                            ForEach(Array(data.enumerated()), id: \.offset) { index, dataPoint in
                                let maxDisplayValue = optimalYAxisLabels.max() ?? configuration.maxValue
                                let barHeight = geometry.size.height * CGFloat((dataPoint.value - configuration.minValue) / (maxDisplayValue - configuration.minValue))
                                let barColor = dataPoint.color ?? configuration.barColor
                                
                                RoundedRectangle(cornerRadius: configuration.cornerRadius)
                                    .fill(barColor)
                                    .frame(
                                        width: geometry.size.width / CGFloat(data.count) * configuration.barWidthRatio,
                                        height: dataPoint.value > configuration.minValue ? max(1, barHeight) : 0
                                    )
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                        .padding(.leading, 5)
                    }
                }
                .frame(height: configuration.chartHeight)
            }
            
            // X-axis labels
            HStack(alignment: .top, spacing: 0) {
                Spacer()
                    .frame(width: 35) // Match the Y-axis label width
                
                GeometryReader { geometry in
                    HStack(alignment: .top, spacing: geometry.size.width * configuration.barSpacingRatio) {
                        ForEach(Array(data.enumerated()), id: \.offset) { index, dataPoint in
                            Text(dataPoint.label)
                                .font(.caption)
                                .foregroundColor(configuration.labelColor)
                                .frame(width: geometry.size.width / CGFloat(data.count) * configuration.barWidthRatio)
                                .multilineTextAlignment(.center)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding(.leading, 8)
                }
                .frame(height: 40)
            }
            .padding(.top, 8)
        }
        .padding(.trailing, 10)
    }
}

#Preview {
    ReusableBarChartView_iOS15(data: BarChartDataModel.monthlyDataPreview)
}
