//
//  HappyLearningViewModel.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 18/11/25.
//

import Foundation
import NetworkService

@MainActor
class HappyLearningViewModel: BaseRoutableNavModel {
    
    @Published var remainingSeconds: Int = 0
    
    override init(router: Router) {
        super.init(router: router)
    }
    
    
}

extension HappyLearningViewModel {
    
    func getHappyLearningHours() async {
        let endpoint = GamificationHappyLearningDataModel.HappyLearningHoursRequestModel()
    
        do {
            let responseModel = try await ApiService.shared.requestGetHeader(
                type: [GamificationHappyLearningDataModel.HappyLearningHoursResponseModel].self,
                model: endpoint
            )
            
            let sorted = responseModel.sortedByTime()
            
            if let active = sorted.activeWindow() {
                self.remainingSeconds = active.remainingSeconds
            } else {
                self.remainingSeconds = 0
            }
            
        } catch {
            self.remainingSeconds = 0
        }
        
    }
}
