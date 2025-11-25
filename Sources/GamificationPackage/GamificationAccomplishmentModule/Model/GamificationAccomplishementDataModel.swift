//
//  GamificationAccomplishementDataModel.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 25/11/25.
//

import Foundation

internal struct GamificationAccomplishementDataModel {
    
    struct AccomplishmentNavDataModel {
        let missionCountModel: GamificationDashboardDataModel.GamificationMissionResponseModel
        let myRankingModel:  GamificationDashboardDataModel.LeaderBoardResponseModel.Ranking?
    }
    
    struct MissionItem: Identifiable {
        let id = UUID()
        let title: String
        let completed: Int
        let total: Int
    }
}
