//
//  File.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 15/11/25.
//

import Foundation

internal struct APIConst {
    
    static let courseBaseUrl = "/api";
    static let versionAPI = "v1";
    static let GetRanking = "User/GetRanking"
    static let GetAllHouseMaster = "user/GetAllHouseMaster";
    static let GamificationLevel = "GamificationLevel"
    static let GamificationMissionCount = "Gamification/MissionCounts"
    static let GetHouseRewardPointCount = "GetHouseRewardPointCount"
    static let GetUserProfile = "user/GetUserProfile"
    static let lxpPath = "/org-content"
    static nonisolated(unsafe) var baseURL = ""
    static nonisolated(unsafe) var lxpOPath = ""
    static nonisolated(unsafe) var lxpBlobPath = ""
    static nonisolated(unsafe) var lxpBlobPath1 = ""
    static let ContentPath = "https://content.gogetempowered.com"
    static let GetTodaysHappyHours = "HappyHour/GetTodaysHappyHours"
    static let toDoURN = "ToDoPriorityList/GetToDoList"
}
