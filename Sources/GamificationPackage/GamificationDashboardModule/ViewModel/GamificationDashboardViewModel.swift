//
//  GamificationDashboardViewModel.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 14/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import Foundation
import NetworkService

@MainActor
class GamificationDashboardViewModel: BaseRoutableNavModel {
    
    @Published var myRankingResponseModel: GamificationDashboardDataModel.LeaderBoardResponseModel.Ranking?
    @Published var topRankingResponseModel: [GamificationDashboardDataModel.LeaderBoardResponseModel.Ranking]?
    @Published var houseMasters: [GamificationDashboardDataModel.GETALLHouseMasterResponseModel] = []
    @Published var missionCount: GamificationDashboardDataModel.GamificationMissionResponseModel?
    @Published var rewardPoints: GamificationDashboardDataModel.HouseRewardPointCountResponseModel?
    
    override init(router: Router) {
        super.init(router: router)
    }
    
    func allApiCall() async {
        do {
            // Create the async tasks without capturing self
            let rankingTask = Task {
                try await getRankingResponse()
            }
            
            let houseMastersTask = Task {
                try await getAllHouseMasterResponse()
            }
            
            let missionCountTask = Task {
                try await getMissionCountResponse()
            }
            
            let levelsTask = Task {
                try await getGamificationLevelResponse()
            }
            
            // Await all results
            let ranking = try await rankingTask.value
            let masters = try await houseMastersTask.value
            let missions = try await missionCountTask.value
            let levelData = try await levelsTask.value
            
            // Update properties on the main actor
            handleRankingResponse(ranking)
            self.houseMasters = masters
            self.missionCount = missions
            GamificationClubTypeDataModel.shared.ranges = levelData
            
        } catch {
            Logger.shared.log(.error, message: "Parallel API calls failed: \(error)")
        }
    }
}

// MARK: - Leaderboard API

extension GamificationDashboardViewModel {
    private func getRankingResponse() async throws -> GamificationDashboardDataModel.LeaderBoardResponseModel.RankingResponse {
        let payload = GamificationDashboardDataModel.LeaderboardRequestModel.LeaderboardPayloadRequestModel(
            configuredColumnName: "undefined",
            configuredColumnValue: "",
            houseCode: nil,
            ranks: 100
        )
        let endpoint = GamificationDashboardDataModel.Endpoint.leaderboard(payload: payload)
        return try await ApiService.shared.requestPostHeader(
            type: GamificationDashboardDataModel.LeaderBoardResponseModel.RankingResponse.self,
            model: endpoint,
            payload: payload
        )
    }
}

// MARK: - House Master API

extension GamificationDashboardViewModel {
    private func getAllHouseMasterResponse() async throws -> [GamificationDashboardDataModel.GETALLHouseMasterResponseModel] {
        let endpoint = GamificationDashboardDataModel.Endpoint.houseMasterList
        return try await ApiService.shared.requestGetHeader(
            type: [GamificationDashboardDataModel.GETALLHouseMasterResponseModel].self,
            model: endpoint
        )
    }
}

// MARK: - Mission Count API

extension GamificationDashboardViewModel {
    private func getMissionCountResponse() async throws -> GamificationDashboardDataModel.GamificationMissionResponseModel {
        let endpoint = GamificationDashboardDataModel.Endpoint.missionCount
        return try await ApiService.shared.requestGetHeader(
            type: GamificationDashboardDataModel.GamificationMissionResponseModel.self,
            model: endpoint
        )
    }
}

// MARK: - Gamification Level API

extension GamificationDashboardViewModel {
    private func getGamificationLevelResponse() async throws -> [GamificationDashboardDataModel.GamificationLevelResponseModel] {
        let endpoint = GamificationDashboardDataModel.Endpoint.levelList
        return try await ApiService.shared.requestGetHeader(
            type: [GamificationDashboardDataModel.GamificationLevelResponseModel].self,
            model: endpoint
        )
    }
}

// MARK: - Response Handlers

extension GamificationDashboardViewModel {
    private func handleRankingResponse(_ response: GamificationDashboardDataModel.LeaderBoardResponseModel.RankingResponse) {
        myRankingResponseModel = response.myRanking?.first
        topRankingResponseModel = response.topRanking
    }
}
