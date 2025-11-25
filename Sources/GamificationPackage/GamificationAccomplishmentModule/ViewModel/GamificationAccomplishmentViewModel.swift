//
//  GamificationAccomplishmentViewModel.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 25/11/25.
//

import Foundation
import NetworkService

@MainActor
internal final class GamificationAccomplishmentViewModel: BaseRoutableNavModel {
    
    let navModel: GamificationAccomplishementDataModel.AccomplishmentNavDataModel
    
    //MARK: Computed Properties
    
    var getMissionCountModel:  GamificationDashboardDataModel.GamificationMissionResponseModel {
        navModel.missionCountModel
    }
    
    var getMyRankingModel: GamificationDashboardDataModel.LeaderBoardResponseModel.Ranking? {
        navModel.myRankingModel
    }
    
    var missionItems: [GamificationAccomplishementDataModel.MissionItem] {
        navModel.missionCountModel.toMissionItems()
    }
    
    init(
        router: Router,
        navModel: GamificationAccomplishementDataModel.AccomplishmentNavDataModel
    ) {
        self.navModel = navModel
        super.init(router: router)
    }

}
