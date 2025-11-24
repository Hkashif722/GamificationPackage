//
//  GamificationCampaignViewModel.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 24/11/25.
//

import Foundation
import NetworkService

@MainActor
internal final class GamificationCampaignViewModel: BaseRoutableNavModel {
    
    
    private(set) var groupedCampaigns: [GamificationDashboardDataModel.GroupedCampaign]
    
    @Published var currentCampaigns: GamificationDashboardDataModel.GroupedCampaign?
    
    @Published var currentPage: Int = 0
    
    //MARK: Computed Porperties
    
    var getCurrentCampaign:  GamificationDashboardDataModel.GroupedCampaign? {
        groupedCampaigns[safe: currentPage]
    }

    
    var hasNextPage: Bool {
        currentPage < groupedCampaigns.count - 1
    }
    
    var hasPreviousPage: Bool {
        currentPage > 0
    }
    
    func nextPage() {
        guard hasNextPage else { return }
        currentPage += 1
    }
    
    func previousPage() {
        guard hasPreviousPage else { return }
        currentPage -= 1
    }
    
    func jumpTo(page: Int) {
        guard page >= 0 && page < groupedCampaigns.count else { return }
        currentPage = page
    }
        
    
    init(router: Router, campaignCourseData: [GamificationDashboardDataModel.GroupedCampaign]) {
        self.groupedCampaigns = campaignCourseData
        self.currentCampaigns = campaignCourseData.first
        super.init(router: router)
    }

}


extension GamificationCampaignViewModel {
    
}

