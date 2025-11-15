//
//  GamificationDashboardDataModel.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 14/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import Foundation

//MARK: Leaderboard API REQUEST AND RESPONE MODEL
struct GamificationDashboardDataModel {
    
    struct LeaderboardRequestModel: RequestURN {
        
        struct LeaderboardPayloadRequestModel: Encodable {
            let configuredColumnName: String
            let configuredColumnValue: String
            let houseCode: String?
            let ranks: Int
            
            init(configuredColumnName: String ,configuredColumnValue: String, houseCode: String?, ranks: Int) {
                self.configuredColumnName = configuredColumnName
                self.configuredColumnValue = configuredColumnValue
                self.houseCode = houseCode
                self.ranks = ranks
            }
        }
        
        func getPlayload(
            configuredColumnName: String = "undefined",
            configuredColumnValue: String = "" ,
            houseCode: String? = nil,
            ranks: Int = 100
        ) -> [String: AnyObject]? {
            
            let payload = LeaderboardPayloadRequestModel(
                configuredColumnName: configuredColumnName,
                configuredColumnValue: configuredColumnValue ,
                houseCode: houseCode,
                ranks: ranks
            )
            
            return payload.toDictionary()
        }
        
        var url: String {
            return  [APIConst.baseURL+APIConst.courseBaseUrl, APIConst.versionAPI,APIConst.GetRanking].joinWithPathSeparator()
        }
        
    }
    
    
    
    struct LeaderBoardResponseModel {
        
        // MARK: - RankingResponse
        struct RankingResponse: Codable {
            let topRanking: [Ranking]
            let myRanking: [Ranking]?
        }
        
        // MARK: - Ranking
        struct Ranking: Codable, Identifiable {
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
            
            // Computed properties (not part of Codable)
            
            var fullProfilePath: URL? {
                //                return getResourcePath(self.profilePicture)
                return ResourceUtils.getResourceURLPath(profilePicture)
            }
            
            // Explicit CodingKeys (optional in this case)
            enum CodingKeys: String, CodingKey {
                case userId
                case euSerId
                case userName
                case totalPoint
                case profilePicture
                case gender
                case rank
                case level
                case maximumLevelPoint
                case levelCode
                case houseCode
                case houseName
                case eId
                case country
                case createdDate
            }
        }
        
        
    }
}


//MARK: House Master API REQUEST AND RESPONE MODEL
extension GamificationDashboardDataModel {
    
    struct GETALLHouseMasterRequestModel: RequestURN {
        
        var url: String {
            return  [APIConst.baseURL+APIConst.courseBaseUrl, APIConst.versionAPI,APIConst.GetAllHouseMaster].joinWithPathSeparator()
        }
    }
    
    struct GETALLHouseMasterResponseModel: Codable, Identifiable {
        let id: Int
        let code: String
        let name: String
        let createdDate: Date
        let isDeleted: Int
        let logoName: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case code
            case name
            case createdDate
            case isDeleted
            case logoName
        }
    }
}

//MARK: Gamification Level API REQUEST AND RESPONE MODEL
extension GamificationDashboardDataModel {
    
    struct GamificationLevelRequestModel: RequestURN {
        var url: String {
            return  [APIConst.baseURL+APIConst.courseBaseUrl, APIConst.versionAPI,APIConst.GamificationLevel].joinWithPathSeparator()
        }
    }
    
    struct GamificationLevelResponseModel: Codable, Identifiable {
        let id: Int
        let description: String
        let minPoint: Int
        let maxPoint: Int
    }
    
}


//MARK: Gamification MISSION COUNT API REQUEST AND RESPONE MODEL
extension GamificationDashboardDataModel {
    
    struct GamificationMissionRequestModel: RequestURN {
        var url: String {
            return  [APIConst.baseURL+APIConst.courseBaseUrl, APIConst.versionAPI,APIConst.GamificationMissionCount].joinWithPathSeparator()
        }
    }
    
    struct GamificationMissionResponseModel: Codable {
        let totalMiniMission: Int
        let totalBossMission: Int
        let totalNormalMission: Int
        let completedMiniMission: Int
        let completedBossMission: Int
        let completedNormalMission: Int
    }
    
    
}


//MARK: Gamification REWARD POINT API REQUEST AND RESPONE MODEL
extension GamificationDashboardDataModel {
    
    struct GetHouseRewardPointCountRequestModel: RequestURN {
        var url: String {
            return  [APIConst.baseURL+APIConst.courseBaseUrl, APIConst.versionAPI,APIConst.GamificationMissionCount].joinWithPathSeparator()
        }
    }
    
    struct HouseRewardPointCountResponseModel: Codable {
        let red: Int
        let green: Int
        let blue: Int
        let yellow: Int
    }
    
}
