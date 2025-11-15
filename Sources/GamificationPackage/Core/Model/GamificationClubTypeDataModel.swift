//
//  GamificationClubTypeDataModel.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 03/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import Foundation
import SwiftUI


struct GamificationClubTypeDataModel {
    
    enum ClubType: String, CaseIterable, Identifiable {
        var id: String { rawValue }
        case knight
        case king
        case queens
        case master
        case grandMaster
        
        
        
        
        //MARK: Club Level View [All 5 Club]
        var getGamificationClublevelSticker: String {
            switch self {
                
            case .knight:
                return "gm_knight_clan"
            case .king:
                return "gm_king_clan"
            case .queens:
                return "gm_queen_clan"
            case .master:
                return "gm_master_ clan"
            case .grandMaster:
                return "gm_grand_master_ clan"
            }
        }
        
        var getGamificationClubLevelStickerBackground: String {
            
            switch self {
                
            case .knight:
                return "bg_knight_level_club"
            case .king:
                return "bg_king_level_club"
            case .queens:
                return "bg_queen_level_club"
            case .master:
                return "bg_master_level_club"
            case .grandMaster:
                return "bg_grand_master_level_club"
            }
        }
        
    }
    
}


