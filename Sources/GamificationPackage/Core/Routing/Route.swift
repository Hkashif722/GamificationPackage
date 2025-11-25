//
//  Route.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 15/11/25.
//


enum Route: Hashable {
    case happyLearningHour
    case criticalMission
    case leaderboard
    case mission
    case missionCards
    case missionCardStacking(mission: GamificationMissionTypeDataModel.MissionTypeProgressEnum)
    case missionGridList(mission: GamificationMissionTypeDataModel.MissionTypeProgressEnum)
    case houseChart
    case clubLeveType
    case dailyLoginBonus
    case campaigns
    case campaignLeaderboard
    case accomplishment
}
