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
                ResourceUtils.getResourceURLPath(profilePicture)
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
    
    struct GamificationLevelResponseModel: Codable, Identifiable, Comparable {
        let id: Int
        let description: String
        let minPoint: Int
        let maxPoint: Int
        
        static func < (lhs: GamificationLevelResponseModel, rhs: GamificationLevelResponseModel) -> Bool {
            if lhs.minPoint == rhs.minPoint {
                return lhs.id < rhs.id  // Secondary sort by id
            }
            
            return lhs.id < rhs.id 
        }
        
    }

    struct GamificationMissionResponseModel: Codable {
        let totalMiniMission: Int
        let totalBossMission: Int
        let totalNormalMission: Int
        let completedMiniMission: Int
        let completedBossMission: Int
        let completedNormalMission: Int
        
        enum CodingKeys: CodingKey {
            case totalMiniMission
            case totalBossMission
            case totalNormalMission
            case completedMiniMission
            case completedBossMission
            case completedNormalMission
        }
        
        static var `default`: Self {
            .init(totalMiniMission: 0, totalBossMission: 0, totalNormalMission: 0, completedMiniMission: 0, completedBossMission: 0, completedNormalMission: 0)
        }
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
        
        var computedUseProlePictureURL: URL? {
            ResourceUtils.getResourceURLPath(self.profilePicture)
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
        case getCampaignData
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
                
            case .getCampaignData:
                return [
                    APIConst.courseBaseUrl,
                    APIConst.versionAPI,
                    APIConst.GetCampaignApplicabilitySetting 
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


extension GamificationDashboardDataModel {
    // MARK: - Flat Response Model
    struct CampaignCourseItem: Codable {
        let campaignId: Int
        let campaignName: String
        let startDate: String
        let endDate: String
        let courseId: Int
        let courseCode: String
        let courseTitle: String
        let courseRewardPoints: Int
        let campaignRewardPoints: Int
    }

    // MARK: - Grouped Models
    struct GroupedCampaign: Identifiable {
        let id: Int
        let name: String
        let startDate: String
        let endDate: String
        let rewardPoints: Int
        let courses: [Course]
        
        struct Course: Identifiable {
            let id: Int
            let code: String
            let title: String
            let rewardPoints: Int
        }
    }
}


// MARK: - Grouping Extension
extension Array where Element == GamificationDashboardDataModel.CampaignCourseItem {
    func groupedByCampaign() -> [GamificationDashboardDataModel.GroupedCampaign] {
        let grouped = Dictionary(grouping: self) { $0.campaignId }
        
        return grouped.compactMap { (campaignId, items) -> GamificationDashboardDataModel.GroupedCampaign? in
            guard let first = items.first else { return nil }
            
            let courses = items.map { item in
                GamificationDashboardDataModel.GroupedCampaign.Course(
                    id: item.courseId,
                    code: item.courseCode,
                    title: item.courseTitle,
                    rewardPoints: item.courseRewardPoints
                )
            }
            
            return GamificationDashboardDataModel.GroupedCampaign(
                id: campaignId,
                name: first.campaignName,
                startDate: first.startDate,
                endDate: first.endDate,
                rewardPoints: first.campaignRewardPoints,
                courses: courses
            )
        }
        .sorted { $0.id < $1.id }
    }
}

// MARK: - Preview Data
extension GamificationDashboardDataModel.CampaignCourseItem {
    static var previewItems: [GamificationDashboardDataModel.CampaignCourseItem] {
        [
            // Campaign 1
            GamificationDashboardDataModel.CampaignCourseItem(
                campaignId: 1,
                campaignName: "Winter Learning Sprint",
                startDate: "2025-11-17T00:00:00",
                endDate: "2025-12-01T00:00:00",
                courseId: 2537,
                courseCode: "coursera_Specialization~FoGfNV5WEeWh-woqJ8MDKQ",
                courseTitle: "TESOL Certificate, Part 1: Teach English Now!",
                courseRewardPoints: 20,
                campaignRewardPoints: 50
            ),
            GamificationDashboardDataModel.CampaignCourseItem(
                campaignId: 1,
                campaignName: "Winter Learning Sprint",
                startDate: "2025-11-17T00:00:00",
                endDate: "2025-12-01T00:00:00",
                courseId: 3278,
                courseCode: "FoGfNV5WEeWh-woqJ8MDKQ",
                courseTitle: "Advanced English Communication Skills",
                courseRewardPoints: 25,
                campaignRewardPoints: 50
            ),
            
            // Campaign 2
            GamificationDashboardDataModel.CampaignCourseItem(
                campaignId: 2,
                campaignName: "Data Science Challenge",
                startDate: "2025-11-21T00:00:00",
                endDate: "2025-12-24T00:00:00",
                courseId: 2542,
                courseCode: "coursera_Specialization~ZmRNDv6LEeqxFw7dZceVSw",
                courseTitle: "Introducción a la Ciencia de Datos",
                courseRewardPoints: 30,
                campaignRewardPoints: 100
            ),
            GamificationDashboardDataModel.CampaignCourseItem(
                campaignId: 2,
                campaignName: "Data Science Challenge",
                startDate: "2025-11-21T00:00:00",
                endDate: "2025-12-24T00:00:00",
                courseId: 2543,
                courseCode: "coursera_Specialization~_u-5WC22EeandQ6BurPvEQ",
                courseTitle: "Machine Learning Fundamentals",
                courseRewardPoints: 40,
                campaignRewardPoints: 100
            ),
            GamificationDashboardDataModel.CampaignCourseItem(
                campaignId: 2,
                campaignName: "Data Science Challenge",
                startDate: "2025-11-21T00:00:00",
                endDate: "2025-12-24T00:00:00",
                courseId: 18532,
                courseCode: "8000",
                courseTitle: "Python for Data Analysis",
                courseRewardPoints: 35,
                campaignRewardPoints: 100
            ),
            
            // Campaign 3
            GamificationDashboardDataModel.CampaignCourseItem(
                campaignId: 3,
                campaignName: "Professional Development Week",
                startDate: "2025-11-24T00:00:00",
                endDate: "2025-12-08T00:00:00",
                courseId: 19969,
                courseCode: "8912",
                courseTitle: "Leadership and Management Skills",
                courseRewardPoints: 50,
                campaignRewardPoints: 75
            ),
            GamificationDashboardDataModel.CampaignCourseItem(
                campaignId: 3,
                campaignName: "Professional Development Week",
                startDate: "2025-11-24T00:00:00",
                endDate: "2025-12-08T00:00:00",
                courseId: 18868,
                courseCode: "7494",
                courseTitle: "Effective Communication in the Workplace",
                courseRewardPoints: 25,
                campaignRewardPoints: 75
            )
        ]
    }
}

extension GamificationDashboardDataModel.GroupedCampaign {
    static var previewCampaigns: [GamificationDashboardDataModel.GroupedCampaign] {
        [
            GamificationDashboardDataModel.GroupedCampaign(
                id: 1,
                name: "Winter Learning Sprint",
                startDate: "2025-11-17T00:00:00",
                endDate: "2025-12-01T00:00:00",
                rewardPoints: 50,
                courses: [
                    GamificationDashboardDataModel.GroupedCampaign.Course(
                        id: 2537,
                        code: "coursera_Specialization~FoGfNV5WEeWh-woqJ8MDKQ",
                        title: "TESOL Certificate, Part 1: Teach English Now!",
                        rewardPoints: 20
                    ),
                    GamificationDashboardDataModel.GroupedCampaign.Course(
                        id: 3278,
                        code: "FoGfNV5WEeWh-woqJ8MDKQ",
                        title: "Advanced English Communication Skills",
                        rewardPoints: 25
                    )
                ]
            ),
            GamificationDashboardDataModel.GroupedCampaign(
                id: 2,
                name: "Data Science Challenge",
                startDate: "2025-11-21T00:00:00",
                endDate: "2025-12-24T00:00:00",
                rewardPoints: 100,
                courses: [
                    GamificationDashboardDataModel.GroupedCampaign.Course(
                        id: 2542,
                        code: "coursera_Specialization~ZmRNDv6LEeqxFw7dZceVSw",
                        title: "Introducción a la Ciencia de Datos",
                        rewardPoints: 30
                    ),
                    GamificationDashboardDataModel.GroupedCampaign.Course(
                        id: 2543,
                        code: "coursera_Specialization~_u-5WC22EeandQ6BurPvEQ",
                        title: "Machine Learning Fundamentals",
                        rewardPoints: 40
                    ),
                    GamificationDashboardDataModel.GroupedCampaign.Course(
                        id: 18532,
                        code: "8000",
                        title: "Python for Data Analysis",
                        rewardPoints: 35
                    )
                ]
            ),
            GamificationDashboardDataModel.GroupedCampaign(
                id: 3,
                name: "Professional Development Week",
                startDate: "2025-11-24T00:00:00",
                endDate: "2025-12-08T00:00:00",
                rewardPoints: 75,
                courses: [
                    GamificationDashboardDataModel.GroupedCampaign.Course(
                        id: 19969,
                        code: "8912",
                        title: "Leadership and Management Skills",
                        rewardPoints: 50
                    ),
                    GamificationDashboardDataModel.GroupedCampaign.Course(
                        id: 18868,
                        code: "7494",
                        title: "Effective Communication in the Workplace",
                        rewardPoints: 25
                    )
                ]
            )
        ]
    }
    
    static var previewSingle: GamificationDashboardDataModel.GroupedCampaign {
        previewCampaigns[0]
    }
}



extension GamificationDashboardDataModel.LeaderBoardResponseModel.Ranking {
    static let preview: GamificationDashboardDataModel.LeaderBoardResponseModel.Ranking = .init(
        userId: 12345,
        euSerId: "EU12345",
        userName: "JohnDoe",
        totalPoint: 15750,
        profilePicture: "/profiles/johndoe.jpg",
        gender: "male",
        rank: 1,
        level: "Gold",
        maximumLevelPoint: 20000,
        levelCode: "GOLD_3",
        houseCode: "HOUSE_A",
        houseName: "Phoenix",
        eId: "E001234",
        country: "US",
        createdDate: "2024-01-15T10:30:00Z"
    )
    
    static let previewArray: [GamificationDashboardDataModel.LeaderBoardResponseModel.Ranking] = [
        .init(
            userId: 12345,
            euSerId: "EU12345",
            userName: "JohnDoe",
            totalPoint: 15750,
            profilePicture: "/profiles/johndoe.jpg",
            gender: "male",
            rank: 1,
            level: "Gold",
            maximumLevelPoint: 20000,
            levelCode: "GOLD_3",
            houseCode: "HOUSE_A",
            houseName: "Phoenix",
            eId: "E001234",
            country: "US",
            createdDate: "2024-01-15T10:30:00Z"
        ),
        .init(
            userId: 67890,
            euSerId: "EU67890",
            userName: "SarahSmith",
            totalPoint: 14200,
            profilePicture: "/profiles/sarahsmith.jpg",
            gender: "female",
            rank: 2,
            level: "Gold",
            maximumLevelPoint: 20000,
            levelCode: "GOLD_2",
            houseCode: "HOUSE_B",
            houseName: "Dragon",
            eId: "E005678",
            country: "UK",
            createdDate: "2024-02-20T14:45:00Z"
        ),
        .init(
            userId: 24680,
            euSerId: "EU24680",
            userName: "MikeJohnson",
            totalPoint: 12850,
            profilePicture: "/profiles/mikejohnson.jpg",
            gender: "male",
            rank: 3,
            level: "Silver",
            maximumLevelPoint: 15000,
            levelCode: "SILVER_3",
            houseCode: "HOUSE_C",
            houseName: "Griffin",
            eId: "E009876",
            country: "CA",
            createdDate: "2024-03-10T09:15:00Z"
        ),
        .init(
            userId: 13579,
            euSerId: "EU13579",
            userName: "EmilyBrown",
            totalPoint: 11500,
            profilePicture: "/profiles/emilybrown.jpg",
            gender: "female",
            rank: 4,
            level: "Silver",
            maximumLevelPoint: 15000,
            levelCode: "SILVER_2",
            houseCode: "HOUSE_A",
            houseName: "Phoenix",
            eId: "E002468",
            country: "AU",
            createdDate: "2024-04-05T16:20:00Z"
        ),
        .init(
            userId: 98765,
            euSerId: "EU98765",
            userName: "AlexWilson",
            totalPoint: 9800,
            profilePicture: "/profiles/alexwilson.jpg",
            gender: nil,
            rank: 5,
            level: "Bronze",
            maximumLevelPoint: 10000,
            levelCode: "BRONZE_3",
            houseCode: "HOUSE_D",
            houseName: "Unicorn",
            eId: "E003691",
            country: nil,
            createdDate: "2024-05-12T11:00:00Z"
        )
    ]
}
