//
//  GamificationClubTypeDataModel.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 03/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import Foundation
import SwiftUI


@MainActor
final class GamificationClubTypeDataModel: ObservableObject {
    
    static let shared = GamificationClubTypeDataModel()
    private init() {}
    
    // Current type for UI
    @Published var clubType: ClubType = .knight
    
    // Loaded ranges from API
    @Published var ranges: [GamificationDashboardDataModel.GamificationLevelResponseModel] = []
    
    
    @Published var userProfileDetail: GamificationDashboardDataModel.UserProfileResponseModel?
    
    
    // MARK: - Configure Club Type Based on Points
    func configure(points: Int) {
        
        // 1. Find matched range
        guard let matched = ranges.first(where: { points >= $0.minPoint && points <= $0.maxPoint }) else {
            return
        }
        
        // 2. Normalize string: "Grand Master" → "grandmaster"
        let key = matched.description
            .replacingOccurrences(of: " ", with: "")
            .lowercased()
        
        // 3. Convert string to ClubType
        if let type = ClubType(rawValue: key) {
            self.clubType = type
        }
    }
}


// MARK: - Club Types Enum
extension GamificationClubTypeDataModel {
    
    enum ClubType: String, CaseIterable, Identifiable {
        var id: String { rawValue }
        
        case knight = "KNIGHT CLUB"
        case king = "KING CLUB"
        case queens = "QUEEN CLUB"     // matches "Queen" → "queen" → "queens"? If needed, rename to queen
        case master = "MASTER CLUB"
        case grandmaster = "GRAND MASTER CLUB" // "Grand Master" → normalized to "grandmaster"
        
        var clanLevelSticker: String {
            switch self {
            case .knight:       return "gm_knight_clan"
            case .king:         return "gm_king_clan"
            case .queens:       return "gm_queen_clan"
            case .master:       return "gm_master_clan"
            case .grandmaster:  return "gm_grand_master_clan"
            }
        }
        
        var clanLevelBackground: String {
            switch self {
            case .knight:       return "bg_knight_level_club"
            case .king:         return "bg_king_level_club"
            case .queens:       return "bg_queen_level_club"
            case .master:       return "bg_master_level_club"
            case .grandmaster:  return "bg_grand_master_level_club"
            }
        }
        
        var dashboardBackground: String {
            
            switch self {
                
            case .knight:
                "gm_Knight_Club_bg"
            case .king:
                "gm_Knight_Club_bg"
            case .queens:
                "gm_Knight_Club_bg"
            case .master:
                "gm_Knight_Club_bg"
            case .grandmaster:
                "gm_Knight_Club_bg"
            }
        }
        
        var clubLevelSticker: String {
            switch self {
            case .knight:       return "clan_knight_club"
            case .king:         return "clan_knight_club"
            case .queens:       return "clan_knight_club"
            case .master:       return "clan_knight_club"
            case .grandmaster:  return "clan_knight_club"
            }
        }
        
        var clubLevelBackground: String {
            switch self {
            case .knight:       return "bg_knight_level_club"
            case .king:         return "bg_king_level_club"
            case .queens:       return "bg_queen_level_club"
            case .master:       return "bg_master_level_club"
            case .grandmaster:  return "bg_grand_master_level_club"
            }
        }
    }
    
   
}
