//
//  GamificationCampaignLeaderboardDataModel.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 25/11/25.
//

import Foundation
import NetworkService


struct GamificationCampaignLeaderboardDataModel {
    
    enum EndPoints: EndpointModel {
        
        case getCampaignApplicabilitySettingForLeaderboard
        case getCampaignSpecificLeaderboardByCampaignId(capaignID: Int)
        
        // MARK: - PATH
        var path: String {
            switch self {
                
            case .getCampaignApplicabilitySettingForLeaderboard:
                return [
                    APIConst.courseBaseUrl,
                    APIConst.versionAPI,
                    APIConst.GetCampaignApplicabilitySettingForLeaderboard
                ].joined(separator: "/")
                
            case .getCampaignSpecificLeaderboardByCampaignId(let campaignID):
                return [
                    APIConst.courseBaseUrl,
                    APIConst.versionAPI,
                    APIConst.GetCampaignSpecificLeaderboardByCampaignId,
                    "\(campaignID)"
                ].joined(separator: "/")

            }
        }
        
        // MARK: - METHOD
        var method: HTTPMethod {
            return .get
        }
        
        // MARK: - HEADERS
        var headers: [String: String]? {
            return nil
        }
        
        // MARK: - BODY FOR POST ONLY
        var body: Codable? {
            return nil
        }
    }
}

//MARK: - Response Models
extension GamificationCampaignLeaderboardDataModel {
    
    struct CampaignApplicabilityLeaderboardResponseModel: Codable {
        let campaignId: Int
        let userMasterId: Int
    }
    
    struct CampaignLeaderBoardResponseModel: Codable {
        let aPIGetCampaignLeaderboardSingleUserData: CampaignLeaderboardSingleUserData
        let aPIGetCampaignLeaderboardData: [CampaignLeaderboardData]
    }
    
    struct CampaignLeaderboardSingleUserData: Codable {
        let userMasterId: Int
        let userName: String
        let campaignRank: Int
        let campaignId: Int
        let campaignName: String
        let startDate: String
        let endDate: String
        let campaignRewardPoints: Int
    }
    
    struct CampaignLeaderboardData: Codable {
        let userMasterId: Int
        let userName: String
        let campaignRank: Int
        let campaignRewardPoints: Int
    }
}

//MARK: - Preview Data
extension GamificationCampaignLeaderboardDataModel {
    
    static let previewCampaignApplicabilityLeaderboard = CampaignApplicabilityLeaderboardResponseModel(
        campaignId: 1,
        userMasterId: 8973
    )
    
    static let previewCampaignLeaderboardSingleUserData = CampaignLeaderboardSingleUserData(
        userMasterId: 8973,
        userName: "kashif",
        campaignRank: 1,
        campaignId: 1,
        campaignName: "Test 01",
        startDate: "2025-11-24T00:00:00",
        endDate: "2025-11-30T00:00:00",
        campaignRewardPoints: 150
    )
    
    static let previewCampaignLeaderboardData: [CampaignLeaderboardData] = [
        CampaignLeaderboardData(
            userMasterId: 8973,
            userName: "kashif",
            campaignRank: 1,
            campaignRewardPoints: 150
        ),
        CampaignLeaderboardData(
            userMasterId: 8974,
            userName: "john_doe",
            campaignRank: 2,
            campaignRewardPoints: 120
        ),
        CampaignLeaderboardData(
            userMasterId: 8975,
            userName: "jane_smith",
            campaignRank: 3,
            campaignRewardPoints: 100
        ),
        CampaignLeaderboardData(
            userMasterId: 8976,
            userName: "alex_jones",
            campaignRank: 4,
            campaignRewardPoints: 85
        ),
        CampaignLeaderboardData(
            userMasterId: 8977,
            userName: "sarah_wilson",
            campaignRank: 5,
            campaignRewardPoints: 70
        )
    ]
    
    static let previewCampaignLeaderBoardResponse = CampaignLeaderBoardResponseModel(
        aPIGetCampaignLeaderboardSingleUserData: previewCampaignLeaderboardSingleUserData,
        aPIGetCampaignLeaderboardData: previewCampaignLeaderboardData
    )
}
