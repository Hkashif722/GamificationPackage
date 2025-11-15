//
//  GamificationDashboardViewModel.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 14/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import Foundation
import SwiftfulRouting
import Combine


class GamificationDashboardViewModel: RoutableViewModel {
 
    @Published var myRankingResponseModel: GamificationDashboardDataModel.LeaderBoardResponseModel.Ranking?
    
    @Published var topRankingResponseModel: [GamificationDashboardDataModel.LeaderBoardResponseModel.Ranking]?
    
    init(router: AnyRouter) {
        super.init(router: router)
    }
    
}

//MARK: API CALLS FOR LEADERBOARD
extension GamificationDashboardViewModel {
    
    private func getRanking() {
        
        let model = GamificationDashboardDataModel.LeaderboardRequestModel()
        guard let payload = GamificationDashboardDataModel.LeaderboardRequestModel().getPlayload() else {
            self.manageAlert(msg: "Something went wrong.")
            Logger.shared.log(.error, message: "Error occured, while creating request playload for leaderboard response.")
            return
        }
        
        ApiService.shared.requestPostHeader(type: GamificationDashboardDataModel.LeaderBoardResponseModel.RankingResponse.self, model: model, payload: payload)
            .handleAPICall(with: self) { [weak self] responseData in
                guard let self = self else { return }
                self.handleRankingResponse(responseData)
            }
            .store(in: &cancellables)
    }
    
    private func handleRankingResponse(_ responseData: GamificationDashboardDataModel.LeaderBoardResponseModel.RankingResponse) {
        if let myRankData = responseData.myRanking?.first {
            UserDefaultsManager.shared.saveTotalRewardPoints(myRankData.totalPoint)
            self.myRankingResponseModel = myRankData
        } else {
            self.myRankingResponseModel = nil
        }
        self.topRankingResponseModel = responseData.topRanking
        
    }
    
}


//MARK: API CALLS FOR LEADERBOARD
extension GamificationDashboardViewModel {
    
    private func getAllHouseMaster() {
        let model = GamificationDashboardDataModel.GETALLHouseMasterRequestModel()
        /*
        Task { [weak self]
            
        }
         */
    }
    
}
