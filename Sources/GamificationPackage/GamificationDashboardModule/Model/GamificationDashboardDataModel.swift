//
//  GamificationDashboardDataModel.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 14/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import Foundation
import NetworkService

// MARK: - ROOT MODEL
internal struct GamificationDashboardDataModel {
    
    
    
    struct MenuTrayActionButtons: Identifiable {
        
        enum ActionType {
            case happyLearningHour
            case criticalMission
            case leaderboard
            case mission
            case dailyLoginBonus
            case campaigns
            case campaignLeaderboard
            
            var getImageAssestName: String {
                switch self {
                  
                case .happyLearningHour:
                    return "ic_gm_happy_Hour"
                case .criticalMission:
                    return "ic_gm_critical_mission"
                case .leaderboard:
                    return "ic_gm_leaderboard"
                case .mission:
                    return "ic_gm_mission"
                case .dailyLoginBonus:
                    return "ic_gm_daily_bonus"
                case .campaigns:
                    return "ic_gm_campign"
                case .campaignLeaderboard:
                    return "ic_gm_camping_leaderboard"
                }
            }
        }
        
        let id: UUID = UUID()
        let actionType: ActionType
        
        init(actionType: ActionType) {
            self.actionType = actionType
        }
        
        static var getActionMenuModel: [Self] {
            [
                .init(actionType: .happyLearningHour),
                .init(actionType: .criticalMission),
                .init(actionType: .leaderboard),
                .init(actionType: .mission),
                .init(actionType: .dailyLoginBonus),
                .init(actionType: .campaigns),
                .init(actionType: .campaignLeaderboard)
            ]
        }
    }
    

    // MARK: - PAYLOAD MODELS
    struct LeaderboardRequestModel {
        struct LeaderboardPayloadRequestModel: Codable {
            let configuredColumnName: String
            let configuredColumnValue: String
            let houseCode: String?
            let ranks: Int
        }
    }

    // MARK: - RESPONSE MODELS
    struct LeaderBoardResponseModel {
        
        struct RankingResponse: Codable {
            let topRanking: [Ranking]
            let myRanking: [Ranking]?
        }
        
        struct Ranking: Codable, Identifiable, Sendable {
            let id: UUID = UUID()
            let userId: Int
            let euSerId: String
            let userName: String
            let totalPoint: Int
            let profilePicture: String
            let gender: String?
            let rank: Int
            let level: String
            let maximumLevelPoint: Int
            let levelCode: String
            let houseCode: String
            let houseName: String
            let eId: String
            let country: String?
            let createdDate: String
            
            var fullProfilePath: URL? {
//                ResourceUtils.getResourceURLPath(profilePicture)
                return nil
            }
        }
    }

    struct GETALLHouseMasterResponseModel: Codable, Identifiable {
        let id: Int
        let code: String
        let name: String
        let createdDate: String
        let isDeleted: Int
        let logoName: String
    }
    
    struct GamificationLevelResponseModel: Codable, Identifiable {
        let id: Int
        let description: String
        let minPoint: Int
        let maxPoint: Int
    }

    struct GamificationMissionResponseModel: Codable {
        let totalMiniMission: Int
        let totalBossMission: Int
        let totalNormalMission: Int
        let completedMiniMission: Int
        let completedBossMission: Int
        let completedNormalMission: Int
    }
    
    struct HouseRewardPointCountResponseModel: Codable {
        let red: Int
        let green: Int
        let blue: Int
        let yellow: Int
    }

    struct UserProfileResponseModel: Codable {
        let userId: String?
        let userName: String?
        let emailId: String?
        let mobileNumber: String?
        let userType: String?
        let gender: String?
        let timeZone: String?
        let currency: String?
        let language: String?
        let profilePicture: String?
        let reportsTo: String?
        let business: String?
        let group: String?
        let area: String?
        let location: String?
        let dateOfBirth: String?
        let dateOfJoining: String?
        let configurationColumn1: String?
        let configurationColumn2: String?
        let configurationColumn3: String?
        let configurationColumn4: String?
        let configurationColumn5: String?
        let configurationColumn6: String?
        let configurationColumn7: String?
        let configurationColumn8: String?
        let configurationColumn9: String?
        let configurationColumn10: String?
        let configurationColumn11: String?
        let configurationColumn12: String?
        let configurationColumn13: String?
        let configurationColumn14: String?
        let configurationColumn15: String?
        let district: String?
        let locationId: String?
        let businessId: String?
        let areaId: String?
        let groupId: String?
        let organizationCode: String?
        let profilePicturePath: String?
        let house: String?
        let roleName: String?
        let jobRoleName: String?
        let isManager: String?
        let buddyTrainerName: String?
        let mentorName: String?
        let hrbpName: String?
        let federationId: String?
        let country: String?
        
        var computedUseProlePictureURL: URL {
            
        }
    }

}

// ============================================================
// MARK: - ENDPOINT ENUM (ALL INSIDE THE MODEL)
// ============================================================

internal extension GamificationDashboardDataModel {
    
    enum Endpoint: EndpointModel {
        
        case leaderboard(payload: LeaderboardRequestModel.LeaderboardPayloadRequestModel)
        case houseMasterList
        case levelList
        case missionCount
        case rewardPointCount
        case getProfileDetail
        // MARK: - PATH
        var path: String {
            switch self {
                
            case .leaderboard:
                return [
                    APIConst.courseBaseUrl,
                    APIConst.versionAPI,
                    APIConst.GetRanking
                ].joined(separator: "/")
                
            case .houseMasterList:
                return [
                    APIConst.courseBaseUrl,
                    APIConst.versionAPI,
                    APIConst.GetAllHouseMaster
                ].joined(separator: "/")
                
            case .levelList:
                return [
                    APIConst.courseBaseUrl,
                    APIConst.versionAPI,
                    APIConst.GamificationLevel
                ].joined(separator: "/")
                
            case .missionCount:
                return [
                    APIConst.courseBaseUrl,
                    APIConst.versionAPI,
                    APIConst.GamificationMissionCount
                ].joined(separator: "/")
                
            case .rewardPointCount:
                return [
                    APIConst.courseBaseUrl,
                    APIConst.versionAPI,
                    APIConst.GamificationMissionCount // confirm if correct
                ].joined(separator: "/")
                
            case .getProfileDetail:
                return [
                    APIConst.courseBaseUrl,
                    APIConst.versionAPI,
                    APIConst.GetUserProfile // confirm if correct
                ].joined(separator: "/")
            }
        }
        
        // MARK: - METHOD
        var method: HTTPMethod {
            switch self {
            case .leaderboard:
                return .post
            default:
                return .get
            }
        }
        
        // MARK: - HEADERS
        var headers: [String: String]? {
            switch self {
            case .leaderboard:
                return ["Content-Type": "application/json"]
            default:
                return nil
            }
        }
        
        // MARK: - BODY FOR POST ONLY
        var body: Codable? {
            switch self {
            case .leaderboard(let payload):
                return payload
            default:
                return nil
            }
        }
    }
}

