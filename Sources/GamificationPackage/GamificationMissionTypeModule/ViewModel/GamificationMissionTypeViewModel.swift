//
//  GamificationMissionTypeViewModel.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 20/11/25.
//

import Foundation
import NetworkService

@MainActor
internal final class GamificationMissionTypeViewModel: BaseRoutableNavModel {
    
    
    @Published private(set) var missions: [GamificationMissionTypeDataModel.MissionTypeProgressEnum] = []
    
    init(router: Router, missionCount: GamificationDashboardDataModel.GamificationMissionResponseModel) {
        super.init(router: router)
        
        // Initialize missions immediately with empty courses so UI can display right away
        self.missions = [
            .miniMission(model: missionCount, courses: []),
            .mission(model: missionCount, courses: []),
            .bossMission(model: missionCount, courses: [])
        ]
    }

}





//MARK: API CALLS
extension GamificationMissionTypeViewModel {
    
    //MARK: Fetch All Mission Data in Parallel
    func fetchAllMissionData() async {
        // Fetch all courses in parallel and update UI as each completes
        let miniMissionTask = Task { @MainActor in
            try await getMiniMissionCourses()
        }
        
        let normalMissionTask = Task { @MainActor in
            try await getNormalMissionCourses()
        }
        
        let bossMissionTask = Task { @MainActor in
            try await getBossMissionCourses()
        }
        
        // Update UI as each task completes
        do {
            let miniCourses = try await miniMissionTask.value
            if case .miniMission(let model, _) = missions[0] {
                updateMission(at: 0, with: .miniMission(model: model, courses: miniCourses))
            }
        } catch {
            Logger.shared.log(.error, message: "Failed to fetch mini mission courses: \(error)")
        }
        
        do {
            let normalCourses = try await normalMissionTask.value
            if case .mission(let model, _) = missions[1] {
                updateMission(at: 1, with: .mission(model: model, courses: normalCourses))
            }
        } catch {
            Logger.shared.log(.error, message: "Failed to fetch normal mission courses: \(error)")
        }
        
        do {
            let bossCourses = try await bossMissionTask.value
            if case .bossMission(let model, _) = missions[2] {
                updateMission(at: 2, with: .bossMission(model: model, courses: bossCourses))
            }
        } catch {
            Logger.shared.log(.error, message: "Failed to fetch boss mission courses: \(error)")
        }
    }
    
    //MARK: Update Mission at Index
    private func updateMission(at index: Int, with mission: GamificationMissionTypeDataModel.MissionTypeProgressEnum) {
        guard index < missions.count else { return }
        missions[index] = mission
    }
    
    //MARK: Mini Mission Courses API
    private func getMiniMissionCourses() async throws -> [GamificationMissionTypeDataModel.Course] {
        let courseEndPoint = GamificationMissionTypeDataModel.Endpoint.miniMissionCourse
        return try await ApiService.shared.requestGetHeader(
            type: [GamificationMissionTypeDataModel.Course].self,
            model: courseEndPoint
        )
    }
    
    //MARK: Normal Mission Courses API
    private func getNormalMissionCourses() async throws -> [GamificationMissionTypeDataModel.Course] {
        let courseEndPoint = GamificationMissionTypeDataModel.Endpoint.normalMissionCourse
        return try await ApiService.shared.requestGetHeader(
            type: [GamificationMissionTypeDataModel.Course].self,
            model: courseEndPoint
        )
    }
    
    //MARK: Boss Mission Courses API
    private func getBossMissionCourses() async throws -> [GamificationMissionTypeDataModel.Course] {
        let courseEndPoint = GamificationMissionTypeDataModel.Endpoint.bossMissionCourse
        return try await ApiService.shared.requestGetHeader(
            type: [GamificationMissionTypeDataModel.Course].self,
            model: courseEndPoint
        )
    }
}



//MARK: Handle Event
extension GamificationMissionTypeViewModel {
    
    func handleMissionPlay(_ mission: GamificationMissionTypeDataModel.MissionTypeProgressEnum) {
        // Get the latest mission data from the array instead of using the passed-in value
        let updatedMission: GamificationMissionTypeDataModel.MissionTypeProgressEnum
        
        switch mission {
        case .miniMission:
            updatedMission = missions[0]
        case .mission:
            updatedMission = missions[1]
        case .bossMission:
            updatedMission = missions[2]
        }
        
        router.swapPopup(.missionCardStacking(mission: updatedMission))
    }
    
}
