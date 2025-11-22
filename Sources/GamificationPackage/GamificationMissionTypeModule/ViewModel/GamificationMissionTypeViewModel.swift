//
//  GamificationMissionTypeViewModel.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 20/11/25.
//

import Foundation
import NetworkService


class GamificationMissionTypeViewModel: BaseRoutableNavModel {
    
    @Published var remainingSeconds: Int = 0
    
    override init(router: Router) {
        super.init(router: router)
    }

}

//MARK: API CALLS
extension GamificationMissionTypeViewModel {
    
}
