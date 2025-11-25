//
//  GamificationHouseChartViewModel.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 25/11/25.
//

import Foundation
import NetworkService

@MainActor
internal final class GamificationHouseChartViewModel: BaseRoutableNavModel {
    
    
    let houseChartModel: [GamificationHouseChartDataModel.HouseScoreModel]
    
    init(router: Router, houseChartModel: [GamificationHouseChartDataModel.HouseScoreModel]) {
        self.houseChartModel = houseChartModel
        super.init(router: router)
    }

}

