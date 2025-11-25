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
        let userMasterId: Int?
        let userName: String?
        let campaignRank: Int?
        let campaignId: Int?
        let campaignName: String?
        let startDate: String?
        let endDate: String?
        let campaignRewardPoints: Int?
    }

    struct CampaignLeaderboardData: Codable , Identifiable {
        let userMasterId: Int
        let userName: String?
        let gender: String?
        let profilePicture: String?
        let eId: String?
        let campaignRewardPoints: Int?
        let campaignRank: Int?
        
        
        var id:Int { self.userMasterId }
        
        var computedUseProlePictureURL: URL? {
            ResourceUtils.getResourceURLPath(self.profilePicture)
        }
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
            gender: "Male",
            profilePicture: "profilePicture/male/m2.png",
            eId: "5MuV9uilMng5813CFFEKlA==",
            campaignRewardPoints: 150,
            campaignRank: 1
        ),
        CampaignLeaderboardData(
            userMasterId: 8974,
            userName: "john_doe",
            gender: "Male",
            profilePicture: "profilePicture/male/m1.png",
            eId: "6NvW0vjmNoh6924DGGFLmB==",
            campaignRewardPoints: 120,
            campaignRank: 2
        ),
        CampaignLeaderboardData(
            userMasterId: 8975,
            userName: "jane_smith",
            gender: "Female",
            profilePicture: "profilePicture/female/f1.png",
            eId: "7OwX1wknOpi7035EHHGMnC==",
            campaignRewardPoints: 100,
            campaignRank: 3
        ),
        CampaignLeaderboardData(
            userMasterId: 8976,
            userName: "alex_jones",
            gender: "Male",
            profilePicture: "profilePicture/male/m3.png",
            eId: "8PxY2xloPqj8146FIIHNoD==",
            campaignRewardPoints: 85,
            campaignRank: 4
        ),
        CampaignLeaderboardData(
            userMasterId: 8977,
            userName: "sarah_wilson",
            gender: "Female",
            profilePicture: "profilePicture/female/f2.png",
            eId: "9QyZ3ymqQrk9257GJJIOpE==",
            campaignRewardPoints: 70,
            campaignRank: 5
        )
    ]
    
    static let previewCampaignLeaderBoardResponse = CampaignLeaderBoardResponseModel(
        aPIGetCampaignLeaderboardSingleUserData: previewCampaignLeaderboardSingleUserData,
        aPIGetCampaignLeaderboardData: previewCampaignLeaderboardData
    )
}
