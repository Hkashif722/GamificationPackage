//
//  GamificationMissionTypeDataModel.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 10/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationMissionTypeDataModel {
    
    enum MissionTypeProgressEnum: String, CaseIterable, Identifiable {
        case miniMission =  "MINI MISSIONS"
        case mission = "MISSIONS"
        case bossMission = "BOSS MISSIONS"
        
        var id: String { self.rawValue }
        
        var getGradientColors: [Color] {
            switch self {
            case .miniMission:
                return [Color.orange,Color.orange, Color.yellow]
            case .mission:
                return [Color.orange, Color.purple.opacity(1.5)]
            case .bossMission:
                return [Color.cyan, Color.blue]
            }
        }
    }
}
