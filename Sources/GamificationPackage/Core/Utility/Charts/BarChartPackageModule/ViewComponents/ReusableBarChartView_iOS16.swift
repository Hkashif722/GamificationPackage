//
//  BarChartBarStyle.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 11/11/25.
//  Copyright Â© 2025 EnthrallTech. All rights reserved.
//


import SwiftUI
import Charts

// MARK: - Modular Bar Chart View
@available(iOS 16, *)
struct ReusableBarChartView_iOS16<T: BarChartDataPointProtocol>: View {
    
    let data: [T]
    let configuration: BarChartDataModel.BarChartConfiguration
    let barWidth: CGFloat
    let showAnnotations: Bool
    let annotationFont: Font
    let horizontalPadding: CGFloat
    let bottomPadding: CGFloat
    let xScalePadding: CGFloat
    let verticalLineOffset: CGFloat
    let colorProvider: ((T) -> Color)?
    
    init(
        data: [T],
        configuration: BarChartDataModel.BarChartConfiguration = .default,
        barWidth: CGFloat = 40,
        showAnnotations: Bool = true,
        annotationFont: Font = .caption,
        horizontalPadding: CGFloat = 30,
        bottomPadding: CGFloat = 40,
        xScalePadding: CGFloat = 10,
        verticalLineOffset: CGFloat = 0,
        colorProvider: ((T) -> Color)? = nil
    ) {
        self.data = data
        self.configuration = configuration
        self.barWidth = barWidth
        self.showAnnotations = showAnnotations
        self.annotationFont = annotationFont
        self.horizontalPadding = horizontalPadding
        self.bottomPadding = bottomPadding
        self.xScalePadding = xScalePadding
        self.verticalLineOffset = verticalLineOffset
        self.colorProvider = colorProvider
    }
    
    var body: some View {
        Chart(data, id: \.label) { dataPoint in
            BarMarkComponent(
                dataPoint: dataPoint,
                barWidth: barWidth,
                showAnnotations: showAnnotations,
                annotationFont: annotationFont,
                configuration: configuration,
                colorProvider: colorProvider
            )
        }
        .chartXScale(range: .plotDimension(padding: xScalePadding))
        .chartPlotStyle { plotArea in
            plotArea.background {
                BackgroundComponent(
                    configuration: configuration,
                    verticalLineOffset: verticalLineOffset
                )
            }
        }
        .chartYAxis {
            makeYAxis(
                values: yAxisValues,
                configuration: configuration
            )
        }
        .chartXAxis {
            makeXAxis(
                labels: data.map { $0.label },
                configuration: configuration
            )
        }
        .frame(height: configuration.chartHeight)
        .padding(.horizontal, horizontalPadding)
        .padding(.bottom, bottomPadding)
    }
    
    private var yAxisValues: [Double] {
        Array(stride(
            from: configuration.minValue,
            through: configuration.maxValue,
            by: configuration.gridLineInterval
        ))
    }
}
    
@available(iOS 16, *)
extension ReusableBarChartView_iOS16 {
    
    private struct BarMarkComponent<DataPoint: BarChartDataPointProtocol>: ChartContent {
        let dataPoint: DataPoint
        let barWidth: CGFloat
        let showAnnotations: Bool
        let annotationFont: Font
        let configuration: BarChartDataModel.BarChartConfiguration
        let colorProvider: ((DataPoint) -> Color)?
        
        var body: some ChartContent {
            BarMark(
                x: .value("Label", dataPoint.label),
                y: .value("Value", dataPoint.value),
                width: .fixed(barWidth)
            )
            .foregroundStyle(barColor)
            .cornerRadius(configuration.cornerRadius)
            .annotation(position: .top) {
                if showAnnotations {
                    Text("\(dataPoint.value.formatted())")
                        .font(annotationFont)
                        .bold()
                        .foregroundColor(barColor)
                }
            }
        }
        
        private var barColor: Color {
            dataPoint.color ?? colorProvider?(dataPoint) ?? configuration.barColor
        }
    }
    
    // Use @AxisContentBuilder instead of conforming to AxisContent
    @AxisContentBuilder
    private func makeYAxis(values: [Double], configuration: BarChartDataModel.BarChartConfiguration) -> some AxisContent {
        AxisMarks(position: .leading, values: values) { value in
            AxisValueLabel {
                if let number = value.as(Double.self) {
                    Text(number.formatted())
                        .foregroundColor(configuration.labelColor)
                        .font(.caption2)
                }
            }
            
            if configuration.showGridLines {
                AxisGridLine(centered: true)
                    .foregroundStyle(configuration.gridLineColor)
            }
        }
    }
    
    @AxisContentBuilder
    private func makeXAxis(labels: [String], configuration: BarChartDataModel.BarChartConfiguration) -> some AxisContent {
        AxisMarks(values: labels) { value in
            AxisValueLabel {
                if let name = value.as(String.self) {
                    Text(name)
                        .foregroundColor(configuration.labelColor)
                        .font(.caption)
                }
            }
        }
    }
    
    private struct BackgroundComponent: View {
        let configuration: BarChartDataModel.BarChartConfiguration
        let verticalLineOffset: CGFloat
        
        var body: some View {
            if configuration.showGridLines {
                GeometryReader { _ in
                    Canvas { context, size in
                        var path = Path()
                        path.move(to: CGPoint(x: 0, y: verticalLineOffset))
                        path.addLine(to: CGPoint(x: 0, y: size.height + verticalLineOffset))
                        context.stroke(
                            path,
                            with: .color(configuration.gridLineColor),
                            lineWidth: 1
                        )
                    }
                }
            }
        }
    }
}




// MARK: - Usage Examples
@available(iOS 16, *)
struct ModularBarChartExampleView: View {
    
    let monthlyData = BarChartDataModel.monthlyDataPreview
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                // Example 1: Default configuration
                VStack(alignment: .leading) {
                    Text("Default Configuration")
                        .font(.headline)
                    
                    ReusableBarChartView_iOS16(data: monthlyData)
                }
                
                // Example 2: Custom BarChartConfiguration
                VStack(alignment: .leading) {
                    Text("Custom Configuration")
                        .font(.headline)
                    
                    let config = BarChartDataModel.BarChartConfiguration(
                        maxValue: 100,
                        minValue: 0,
                        barColor: .blue,
                        gridLineColor: .blue.opacity(0.2),
                        labelColor: .blue,
                        chartHeight: 250,
                        cornerRadius: 8,
                        showGridLines: true,
                        gridLineInterval: 25
                    )
                    
                    ReusableBarChartView_iOS16(
                        data: monthlyData,
                        configuration: config,
                        barWidth: 45
                    )
                }
                
                // Example 3: With color provider
                VStack(alignment: .leading) {
                    Text("Dynamic Colors")
                        .font(.headline)
                    
                    ReusableBarChartView_iOS16(
                        data: monthlyData,
                        barWidth: 50
                    ) { dataPoint in
                        dataPoint.value > 80 ? .green : .orange
                    }
                }
                
                // Example 4: Without annotations
                VStack(alignment: .leading) {
                    Text("No Annotations")
                        .font(.headline)
                    
                    ReusableBarChartView_iOS16(
                        data: monthlyData,
                        showAnnotations: false
                    )
                }
                
                // Example 5: No grid lines
                VStack(alignment: .leading) {
                    Text("No Grid Lines")
                        .font(.headline)
                    
                    let config = BarChartDataModel.BarChartConfiguration(
                        maxValue: 100,
                        barColor: Color(hex: "#7f60db"),
                        showGridLines: false
                    )
                    
                    ReusableBarChartView_iOS16(
                        data: monthlyData,
                        configuration: config
                    )
                }
                
                // Example 6: Full customization
                VStack(alignment: .leading) {
                    Text("Full Customization")
                        .font(.headline)
                    
                    let config = BarChartDataModel.BarChartConfiguration(
                        maxValue: 100,
                        minValue: 0,
                        barColor: .purple,
                        gridLineColor: .purple.opacity(0.3),
                        labelColor: .purple,
                        chartHeight: 300,
                        cornerRadius: 12,
                        showGridLines: true,
                        gridLineInterval: 20
                    )
                    
                    ReusableBarChartView_iOS16(
                        data: monthlyData,
                        configuration: config,
                        barWidth: 45,
                        showAnnotations: true,
                        annotationFont: .caption.bold(),
                        horizontalPadding: 20,
                        bottomPadding: 30
                    ) { dataPoint in
                        let percentage = dataPoint.value / config.maxValue
                        if percentage > 0.85 {
                            return .green
                        } else if percentage > 0.70 {
                            return .yellow
                        } else {
                            return .red
                        }
                    }
                }
            }
            .padding()
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    ModularBarChartExampleView()
}
