//
//  GamificationMissionCardViewModel.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 23/11/25.
//

import Foundation
import NetworkService

@MainActor
internal final class GamificationMissionCardViewModel: BaseRoutableNavModel {
    
    let mission: GamificationMissionTypeDataModel.MissionTypeProgressEnum
    
    init(router: Router, mission: GamificationMissionTypeDataModel.MissionTypeProgressEnum) {
        self.mission = mission
        super.init(router: router)
    }

}


//MARK: Handle Event
internal extension GamificationMissionCardViewModel {
    
    func handleOnLaunchMission(_ course: GamificationMissionTypeDataModel.Course) {
        eventPublisher.publish(.launchCourse(course.courseId))
    }
    
    func handleViewAll() {
        router.swapPopup(.missionGridList(mission: mission))
    }
}
