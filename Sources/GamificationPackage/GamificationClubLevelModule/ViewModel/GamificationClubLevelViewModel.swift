//
//  GamificationClubLevelViewModel..swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 24/11/25.
//

import SwiftUI
import NetworkService

internal final class GamificationClubLevelViewModel: BaseRoutableNavModel {
    @Published var gamificationClubTypeModel: GamificationClubTypeDataModel
    
    @Published var isAnimating = false
    
    let shadowColor: Color = Color(hex: "#FF00B4")
    
    //MARK: Computed properties
    
    var ranges: [GamificationDashboardDataModel.GamificationLevelResponseModel] {
        MainActor.assumeIsolated {
            GamificationClubTypeDataModel.shared.ranges
        }
    }
    
    var selectedClub: GamificationClubTypeDataModel.ClubType {
        MainActor.assumeIsolated {
            GamificationClubTypeDataModel.shared.clubType
        }
    }

    
    override init(router: Router) {
        self.gamificationClubTypeModel = MainActor.assumeIsolated {
            GamificationClubTypeDataModel.shared
        }
        super.init(router: router)
    }
}
