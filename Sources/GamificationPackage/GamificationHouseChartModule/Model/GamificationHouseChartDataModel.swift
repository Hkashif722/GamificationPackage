//
//  GamificationHouseChartDataModel.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 11/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import Foundation
import SwiftUI

struct GamificationHouseChartDataModel {
    
    struct HouseScoreModel: Identifiable, BarChartDataPointProtocol {
        
        let id = UUID()
        let name: String
        let score: Int
        let barColor: Color
        
        var label: String { name }
        var value: Double { Double(score) }
        var color: Color? { barColor }
        
        static let houses: [HouseScoreModel] = [
            HouseScoreModel(name: "Red House",    score: 48200, barColor: .red),
            HouseScoreModel(name: "Green House",  score: 59200, barColor: .green),
            HouseScoreModel(name: "Blue House",   score: 25200, barColor: .blue),
            HouseScoreModel(name: "Yellow House", score: 42200, barColor: .yellow)
           ]
        
        static var chartConfiguration: BarChartDataModel.BarChartConfiguration {
            BarChartDataModel.BarChartConfiguration(
                maxValue: 70000,
                minValue: 0,
                gridLineColor: .white,
                labelColor: .white,
                cornerRadius: 12,
                gridLineInterval: 10000
            )
        }
    }
    
    
}
