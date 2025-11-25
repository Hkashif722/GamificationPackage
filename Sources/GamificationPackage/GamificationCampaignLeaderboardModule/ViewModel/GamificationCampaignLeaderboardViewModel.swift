//
//  GamificationCampaignLeaderboardViewModel.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 25/11/25.
//

import Foundation
import NetworkService

@MainActor
internal final class GamificationCampaignLeaderboardViewModel: BaseRoutableNavModel {
    
    @Published private(set) var campaignApplicablityLeaderboardModel: [GamificationCampaignLeaderboardDataModel.CampaignApplicabilityLeaderboardResponseModel] = []
    @Published private(set) var currentCampaignLeaderboard: GamificationCampaignLeaderboardDataModel.CampaignLeaderBoardResponseModel?
    @Published private(set) var currentCampaignIndex: Int = 0
    @Published private(set) var isLoading: Bool = false
    
    
    //MARK: Computed Properties
    
    var campaignUserDataModel: GamificationCampaignLeaderboardDataModel.CampaignLeaderboardSingleUserData? {
        currentCampaignLeaderboard?.aPIGetCampaignLeaderboardSingleUserData
    }
    
    var campaignLeaderboardModel: [GamificationCampaignLeaderboardDataModel.CampaignLeaderboardData] {
        currentCampaignLeaderboard?.aPIGetCampaignLeaderboardData ?? []
    }
    
    var hasPrevious: Bool {
        return currentCampaignIndex > 0
    }
    
    var hasNext: Bool {
        return currentCampaignIndex < campaignApplicablityLeaderboardModel.count - 1
    }
    
    var currentCampaignID: Int? {
        guard !campaignApplicablityLeaderboardModel.isEmpty,
              currentCampaignIndex < campaignApplicablityLeaderboardModel.count else {
            return nil
        }
        return campaignApplicablityLeaderboardModel[currentCampaignIndex].campaignId
    }
    
    override init(router: Router) {
        super.init(router: router)
    }
    
}


//MARK: API Calls
extension GamificationCampaignLeaderboardViewModel {
    
    
    func getCampaignApplicabilityRequestModel() async {
        
        
        let model = GamificationCampaignLeaderboardDataModel.EndPoints.getCampaignApplicabilitySettingForLeaderboard
        do {
            
            let responseData = try await ApiService.shared.requestGetHeader(
                type: [GamificationCampaignLeaderboardDataModel.CampaignApplicabilityLeaderboardResponseModel].self,
                model: model
            )
            
            self.campaignApplicablityLeaderboardModel = responseData
            
            // Load the first campaign's leaderboard if available
            if !responseData.isEmpty {
                await self.loadCampaignLeaderboard(at: 0)
            }
            
        } catch {
            Logger.shared.log(.error, message: "Error Occured, while fetching campaign leaderboard applicablity")
        }
        
    }
    
    private func loadCampaignLeaderboard(at index: Int) async {
        guard index >= 0, index < campaignApplicablityLeaderboardModel.count else {
            return
        }
        
        isLoading = true
        let campaignID = campaignApplicablityLeaderboardModel[index].campaignId
        
        let model = GamificationCampaignLeaderboardDataModel.EndPoints.getCampaignSpecificLeaderboardByCampaignId(capaignID: campaignID)
        
        do {
            let responseData = try await ApiService.shared.requestGetHeader(
                type: GamificationCampaignLeaderboardDataModel.CampaignLeaderBoardResponseModel.self,
                model: model
            )
            
            self.currentCampaignLeaderboard = responseData
            self.currentCampaignIndex = index
            
        } catch {
            Logger.shared.log(.error, message: "Error occurred while fetching campaign leaderboard for ID: \(campaignID)")
        }
        
        isLoading = false
    }
    
}

//MARK: - Pagination Actions
extension GamificationCampaignLeaderboardViewModel {
    
    func goToPreviousCampaign() {
        guard hasPrevious else { return }
        
        Task {
            await loadCampaignLeaderboard(at: currentCampaignIndex - 1)
        }
    }
    
    func goToNextCampaign() {
        guard hasNext else { return }
        
        Task {
            await loadCampaignLeaderboard(at: currentCampaignIndex + 1)
        }
    }
    
}
