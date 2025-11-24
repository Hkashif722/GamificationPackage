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
    
    private var points: Int = 0

    
    // MARK: - Configure Club Type Based on Points
    func configure(points: Int) {
        self.points = points
        
        self.clubType = self.clubType.getCurrentClubType(userPoints: points, ranges: self.ranges)
    }
}


//MARK: Utility functions
extension GamificationClubTypeDataModel {
    func getRangeText(_ clubType: ClubType) -> String {
        clubType.getRangeText(ranges: self.ranges)
    }
    
    func isClubLocked(_ clubType: ClubType) -> Bool {
        clubType.isLocked(userPoints: self.points, ranges: self.ranges)
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
                "gm_King_Club_bg"
            case .queens:
                "gm_Queen_Club_bg"
            case .master:
                "gm_Master_Club_bg"
            case .grandmaster:
                "gm_Grand_Master_Club_bg"
            }
        }
        
        var clubLevelSticker: String {
            switch self {
            case .knight:       return "clan_knight_club"
            case .king:         return "clan_king_club"
            case .queens:       return "clan_queens_club"
            case .master:       return "clan_master_club"
            case .grandmaster:  return "clan_grand_master_club"
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
        
        func getRangeText(ranges: [GamificationDashboardDataModel.GamificationLevelResponseModel]) -> String {
            
            switch self {
            case .knight:
                "\(ranges[safe: 0]?.minPoint ?? 0) - \(ranges[safe: 0]?.maxPoint ?? 0)"
            case .king:
                "\(ranges[safe: 1]?.minPoint ?? 0) - \(ranges[safe: 1]?.maxPoint ?? 0)"
            case .queens:
                "\(ranges[safe: 2]?.minPoint ?? 0) - \(ranges[safe: 2]?.maxPoint ?? 0)"
            case .master:
                "\(ranges[safe: 3]?.minPoint ?? 0) - \(ranges[safe: 3]?.maxPoint ?? 0)"
            case .grandmaster:
                "\(ranges[safe: 4]?.minPoint ?? 0) - \(ranges[safe: 4]?.maxPoint ?? 0)"
            }
        }
        
        func isLocked(userPoints: Int, ranges: [GamificationDashboardDataModel.GamificationLevelResponseModel]) -> Bool {
            switch self {
            case .knight:
                userPoints <= ranges[safe: 0]?.minPoint ?? 0
            case .king:
                userPoints <= ranges[safe: 1]?.minPoint ?? 0
            case .queens:
                userPoints <= ranges[safe: 2]?.minPoint ?? 0
            case .master:
                userPoints <= ranges[safe: 3]?.minPoint ?? 0
            case .grandmaster:
                userPoints <= ranges[safe: 4]?.minPoint ?? 0
            }
        }
        
        func getCurrentClubType(userPoints: Int, ranges: [GamificationDashboardDataModel.GamificationLevelResponseModel]) -> ClubType {
            // Try to find matching range
            if let matched = ranges.first(where: { userPoints >= $0.minPoint && userPoints <= $0.maxPoint }) {
                return clubType(for: matched.id)
            }
            
            // If no match, check if points exceed highest range
            if let highestRange = ranges.max(by: { $0.maxPoint < $1.maxPoint }),
               userPoints > highestRange.maxPoint {
                return clubType(for: highestRange.id) // Return highest club
            }
            
            // Default to lowest club
            return .knight
        }

        private func clubType(for id: Int) -> ClubType {
            switch id {
            case 0: return .knight
            case 1: return .king
            case 2: return .queens
            case 3: return .master
            default: return .grandmaster
            }
        }
    }
    
   
}
