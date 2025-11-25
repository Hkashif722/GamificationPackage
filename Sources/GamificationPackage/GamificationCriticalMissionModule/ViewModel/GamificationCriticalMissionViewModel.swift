//
//  GamificationCriticalMissionViewModel.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 20/11/25.
//

import Foundation
import NetworkService

@MainActor
class GamificationCriticalMissionViewModel: BaseRoutableNavModel {
    
    @Published var criticalMissions: [GamificationCriticalMissionDataModel.TODOResponseModel] = []
    
    override init(router: Router) {
        super.init(router: router)
    }
    
    
}


extension GamificationCriticalMissionViewModel {
    
    func getCriticalMissions() async {
        let endpoint = GamificationCriticalMissionDataModel.TODORequestModel()
    
        do {
            let responseModel = try await ApiService.shared.requestGetHeader(
                type: [GamificationCriticalMissionDataModel.TODOResponseModel].self,
                model: endpoint
            )
            
           
            
            criticalMissions = responseModel
        } catch {
            criticalMissions = []
        }
        
    }
}


//MARK: Handle Event
extension GamificationCriticalMissionViewModel {
    
    func handeTodoLaunch(_ todo: GamificationCriticalMissionDataModel.TODOResponseModel) {
        eventPublisher.publish(.launchTodo(id: todo.id, type: todo.type ?? ""))
    }
    
    func handleSeeAll() {
        eventPublisher.publish(.launchAllTodo)
    }
}



