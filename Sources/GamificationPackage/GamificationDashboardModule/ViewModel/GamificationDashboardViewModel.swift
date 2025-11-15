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
    @Published var gamificationLevels: [GamificationDashboardDataModel.GamificationLevelResponseModel] = []
    @Published var missionCount: GamificationDashboardDataModel.GamificationMissionResponseModel?
    @Published var rewardPoints: GamificationDashboardDataModel.HouseRewardPointCountResponseModel?
    
    override init(router: Router) {
        super.init(router: router)
    }
}


extension GamificationDashboardViewModel {
    
    func getRanking() {
        Task { [weak self] in
            guard let self else { return }
            
            let payload = GamificationDashboardDataModel.LeaderboardRequestModel.LeaderboardPayloadRequestModel(
                configuredColumnName: "undefined",
                configuredColumnValue: "",
                houseCode: nil,
                ranks: 100
            )
            
            do {
                let endpoint = GamificationDashboardDataModel.Endpoint.leaderboard(payload: payload)
                
                let response = try await ApiService.shared.requestPostHeader(
                    type: GamificationDashboardDataModel.LeaderBoardResponseModel.RankingResponse.self,
                    model: endpoint,
                    payload: payload
                )
                
                await MainActor.run { self.handleRankingResponse(response) }
                
            } catch {
                Logger.shared.log(.error, message: "Leaderboard API failed: \(error)")
//                self.manageAlert(msg: "Unable to fetch leaderboard.")
            }
        }
    }
    
    private func handleRankingResponse(_ response: GamificationDashboardDataModel.LeaderBoardResponseModel.RankingResponse) {
        if let myRank = response.myRanking?.first {
            self.myRankingResponseModel = myRank
        } else {
            self.myRankingResponseModel = nil
        }
        
        self.topRankingResponseModel = response.topRanking
    }
}


extension GamificationDashboardViewModel {
    
    func getAllHouseMaster() {
        Task { [weak self] in
            guard let self else { return }
            
            let endpoint = GamificationDashboardDataModel.Endpoint.houseMasterList
            
            do {
                let response = try await ApiService.shared.requestGetHeader(
                    type: [GamificationDashboardDataModel.GETALLHouseMasterResponseModel].self,
                    model: endpoint
                )
                
                await MainActor.run { self.houseMasters = response }
                
            } catch {
                Logger.shared.log(.error, message: "House Master API failed: \(error)")
//                self.manageAlert(msg: "Unable to fetch house masters.")
            }
        }
    }
}


extension GamificationDashboardViewModel {
    
    func getMissionCount() {
        Task { [weak self] in
            guard let self else { return }
            
            let endpoint = GamificationDashboardDataModel.Endpoint.missionCount
            
            do {
                let response = try await ApiService.shared.requestGetHeader(
                    type: GamificationDashboardDataModel.GamificationMissionResponseModel.self,
                    model: endpoint
                )
                
                await MainActor.run { self.missionCount = response }
                
            } catch {
                Logger.shared.log(.error, message: "Mission Count API failed: \(error)")
//                self.manageAlert(msg: "Unable to fetch mission count.")
            }
        }
    }
}

