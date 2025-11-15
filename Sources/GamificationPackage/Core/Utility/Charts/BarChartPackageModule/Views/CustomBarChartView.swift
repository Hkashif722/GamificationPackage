//
//  CustomBarChartView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 11/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

internal struct CustomBarChartView<T: BarChartDataPointProtocol>: View {
    let data: [T]
    let configuration: BarChartDataModel.BarChartConfiguration
    
    init(data: [T], configuration: BarChartDataModel.BarChartConfiguration = .default) {
        self.data = data
        self.configuration = configuration
    }
    
    var body: some View {
        barChartView
    }
    
    @ViewBuilder
    private var barChartView: some View {
        if #available(iOS 16.0, *) {
            ReusableBarChartView_iOS16(
                data: data,
                configuration: configuration
            )
        } else {
            ReusableBarChartView_iOS15(
                data: data,
                configuration: configuration
            )
        }
    }
}

#Preview {
    CustomBarChartView(data: BarChartDataModel.monthlyDataPreview)
}
