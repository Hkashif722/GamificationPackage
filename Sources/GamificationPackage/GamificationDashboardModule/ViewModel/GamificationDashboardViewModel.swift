//
//  GamificationDashboardViewModel.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 14/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import Foundation
import NetworkService
import SwiftUI

@MainActor
internal class GamificationDashboardViewModel: BaseRoutableNavModel {
    
    @Published var myRankingResponseModel: GamificationDashboardDataModel.LeaderBoardResponseModel.Ranking?
    @Published var topRankingResponseModel: [GamificationDashboardDataModel.LeaderBoardResponseModel.Ranking] = []
    @Published var houseMasters: [GamificationDashboardDataModel.GETALLHouseMasterResponseModel] = []
    @Published var missionCount: GamificationDashboardDataModel.GamificationMissionResponseModel = .default
    @Published var houseRewardPoints: GamificationDashboardDataModel.HouseRewardPointCountResponseModel?
    @Published var campaignGroupedCourseData: [GamificationDashboardDataModel.GroupedCampaign] = []
    
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
            
            let houseRewardPointsTask = Task {
                try await getHouseRewardPointsResponse()
            }
            
            let levelsTask = Task {
                try await getGamificationLevelResponse()
            }
            
            let getUserProfileDetail = Task {
                try await getUerProfileDetails()
            }
            
            let getCampaignData = Task {
                try await getCampaignDetails()
            }
            
            // Await all results
            let ranking = try await rankingTask.value
            let masters = try await houseMastersTask.value
            let missions = try await missionCountTask.value
            let houseRewardPoints = try await houseRewardPointsTask.value
            let levelData = try await levelsTask.value
            let userProfileDetail = try await getUserProfileDetail.value
            let campaignCourseData = try await getCampaignData.value
            
            // Update properties on the main actor
            handleRankingResponse(ranking)
            self.houseMasters = masters
            self.missionCount = missions
            self.houseRewardPoints = houseRewardPoints
            self.campaignGroupedCourseData = campaignCourseData.groupedByCampaign()
            GamificationClubTypeDataModel.shared.ranges = levelData.sorted()
            GamificationClubTypeDataModel.shared.configure(points: ranking.myRanking?.first?.totalPoint ?? 0)
            GamificationClubTypeDataModel.shared.userProfileDetail = userProfileDetail
            
        } catch {
            Logger.shared.log(.error, message: "Parallel API calls failed: \(error)")
        }
    }
}

// MARK: - Leaderboard API

internal extension GamificationDashboardViewModel {
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

internal extension GamificationDashboardViewModel {
    private func getAllHouseMasterResponse() async throws -> [GamificationDashboardDataModel.GETALLHouseMasterResponseModel] {
        let endpoint = GamificationDashboardDataModel.Endpoint.houseMasterList
        return try await ApiService.shared.requestGetHeader(
            type: [GamificationDashboardDataModel.GETALLHouseMasterResponseModel].self,
            model: endpoint
        )
    }
}

// MARK: - Mission Count API

internal extension GamificationDashboardViewModel {
    private func getMissionCountResponse() async throws -> GamificationDashboardDataModel.GamificationMissionResponseModel {
        let endpoint = GamificationDashboardDataModel.Endpoint.missionCount
        return try await ApiService.shared.requestGetHeader(
            type: GamificationDashboardDataModel.GamificationMissionResponseModel.self,
            model: endpoint
        )
    }
}

// MARK: - House Reward Point API

internal extension GamificationDashboardViewModel {
    private func getHouseRewardPointsResponse() async throws -> GamificationDashboardDataModel.HouseRewardPointCountResponseModel {
        let endpoint = GamificationDashboardDataModel.Endpoint.houseRewardPointCount
        return try await ApiService.shared.requestGetHeader(
            type: GamificationDashboardDataModel.HouseRewardPointCountResponseModel.self,
            model: endpoint
        )
    }
}

// MARK: - Gamification Level API

internal extension GamificationDashboardViewModel {
    private func getGamificationLevelResponse() async throws -> [GamificationDashboardDataModel.GamificationLevelResponseModel] {
        let endpoint = GamificationDashboardDataModel.Endpoint.levelList
        return try await ApiService.shared.requestGetHeader(
            type: [GamificationDashboardDataModel.GamificationLevelResponseModel].self,
            model: endpoint
        )
    }
}

// MARK: Get Profile API
internal extension GamificationDashboardViewModel {
    private func getUerProfileDetails() async throws -> GamificationDashboardDataModel.UserProfileResponseModel {
        let endpoint = GamificationDashboardDataModel.Endpoint.getProfileDetail
        return try await ApiService.shared.requestGetHeader(
            type: GamificationDashboardDataModel.UserProfileResponseModel.self,
            model: endpoint
        )
    }
}

// MARK: - Response Handlers

internal extension GamificationDashboardViewModel {
    private func handleRankingResponse(_ response: GamificationDashboardDataModel.LeaderBoardResponseModel.RankingResponse) {
        myRankingResponseModel = response.myRanking?.first
        topRankingResponseModel = response.topRanking
    }
}


internal extension GamificationDashboardViewModel {
    private func getCampaignDetails() async throws -> [GamificationDashboardDataModel.CampaignCourseItem] {
        let endpoint = GamificationDashboardDataModel.Endpoint.getCampaignData
        return try await ApiService.shared.requestGetHeader(
            type: [GamificationDashboardDataModel.CampaignCourseItem].self,
            model: endpoint
        )
    }
}




//MARK: Handle Navigation
internal extension GamificationDashboardViewModel {
    
    @ViewBuilder
    func popupView(_ popup: Route) -> some View {
        
        switch popup {
            
        case .happyLearningHour:
            
            GamificationHappyLearningView(router: self.router)
            
        case .criticalMission:
            GamificationCriticalMissionView(router: self.router)
            
        case .leaderboard:
           
            GamificationLeaderboardView(router: self.router, myRanking: self.myRankingResponseModel, topRanking: self.topRankingResponseModel)
            
            
        case .mission:
            GamificationMissionTypeView(router: self.router, missionCounts: self.missionCount)
            
        case .missionCardStacking(let mission):
            GamificationMissionCardStackingView(router: self.router, mission: mission)
            
        case .missionGridList(let mission):
            GamificationMissionGridContentView(router: self.router, mission: mission)
            
        case .clubLeveType:
            GamificationClubLevelView(router: self.router)
            
        case .campaigns:
            GamificationCampaignView(router: self.router, campaignCourseData: self.campaignGroupedCourseData)
            
        case .campaignLeaderboard:
            GamificationCampaignLeaderBoardView(router: router)
            
        case .houseChart:
            let housesChartModel: [GamificationHouseChartDataModel.HouseScoreModel] = [
                .init(name: "Red House",    score: houseRewardPoints?.red ?? 0, barColor: .red),
                .init(name: "Green House",  score: houseRewardPoints?.green ?? 0, barColor: .green),
                .init(name: "Blue House",   score: houseRewardPoints?.blue ?? 0, barColor: .blue),
                .init(name: "Yellow House", score: houseRewardPoints?.yellow ?? 0, barColor: .yellow)
               ]
            
            let _ = {
                GamificationHouseChartDataModel.HouseScoreModel.userHouse = housesChartModel.first { house in
                    guard let houseName = self.myRankingResponseModel?.houseName else { return false }
                    return house.name.contains(houseName)
                }
            }()
            
            GamificationHouseChartView(router: self.router, houseChartModel: housesChartModel)
            
        case .accomplishment:
            let navModel = GamificationAccomplishementDataModel.AccomplishmentNavDataModel(
                missionCountModel: self.missionCount,
                myRankingModel: self.myRankingResponseModel
            )
            GamificationAccomplishmentView(router: self.router, navModel: navModel)
            
        case .dailyLoginBonus:
            GamificationDailyLoginBonusPointView(router: self.router)
        default:
            GamificationMissionCardStackingView(router: self.router, mission: .bossMission(model: .default, courses: []))
        }
        
    }
    
    func handleDeckMenuSelection(_ type: GamificationDashboardDataModel.MenuTrayActionButtons.ActionType) {
        switch type {
        case .happyLearningHour:
            router.presentPopup(.happyLearningHour)
        case .criticalMission:
            router.presentPopup(.criticalMission)
        case .leaderboard:
            router.presentPopup(.leaderboard)
        case .mission:
            router.presentPopup(.mission)
        case .dailyLoginBonus:
            router.presentPopup(.dailyLoginBonus)
        case .campaigns:
            router.presentPopup(.campaigns)
        case .campaignLeaderboard:
            router.presentPopup(.campaignLeaderboard)
        }
    }
    
    @MainActor
    func presentPopupView(_ type:  GamificationDashboardDataModel.MenuTrayActionButtons.ActionType) {
        switch type {
        case .happyLearningHour:
            router.presentPopup(.happyLearningHour)
        case .criticalMission:
            router.presentPopup(.criticalMission)
        case .leaderboard:
            router.presentPopup(.leaderboard)
        case .mission:
            router.presentPopup(.mission)
        case .dailyLoginBonus:
            router.presentPopup(.dailyLoginBonus)
        case .campaigns:
            router.presentPopup(.campaigns)
        case .campaignLeaderboard:
            router.presentPopup(.campaignLeaderboard)
        }
    }
}
