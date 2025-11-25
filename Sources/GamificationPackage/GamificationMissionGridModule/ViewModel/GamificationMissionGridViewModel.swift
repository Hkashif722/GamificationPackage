//
//  GamificationMissionGridViewModel.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 23/11/25.
//

import Foundation
import NetworkService

@MainActor
internal final class GamificationMissionGridViewModel: BaseRoutableNavModel {
    
    let mission: GamificationMissionTypeDataModel.MissionTypeProgressEnum
    
    /// Number of items to display per page
    let itemsPerPage: Int = 4
    
    /// Current page index (0-based)
    @Published var currentPage: Int = 0
    
    init(router: Router, mission: GamificationMissionTypeDataModel.MissionTypeProgressEnum) {
        self.mission = mission
        super.init(router: router)
    }
    
}

//MARK: Pagination Logic
extension GamificationMissionGridViewModel {
    /// Total number of courses
    var totalItems: Int {
        mission.courses.count
    }
    
    /// Total number of pages
    var totalPages: Int {
        max(1, Int(ceil(Double(totalItems) / Double(itemsPerPage))))
    }
    
    /// Courses for the current page
    var currentPageCourses: [GamificationMissionTypeDataModel.Course] {
        let startIndex = currentPage * itemsPerPage
        let endIndex = min(startIndex + itemsPerPage, totalItems)
        
        guard startIndex < totalItems else { return [] }
        return Array(mission.courses[startIndex..<endIndex])
    }
    
    /// Range text for pagination display (e.g., "1-4 / 10")
    var paginationText: String {
        guard totalItems > 0 else { return "0 / 0" }
        
        let startItem = (currentPage * itemsPerPage) + 1
        let endItem = min(startItem + itemsPerPage - 1, totalItems)
        
        return "\(startItem)-\(endItem) / \(totalItems)"
    }
    
    /// Whether the previous button should be enabled
    var canGoToPrevious: Bool {
        currentPage > 0
    }
    
    /// Whether the next button should be enabled
    var canGoToNext: Bool {
        currentPage < totalPages - 1
    }
    
    /// Navigate to previous page
    func goToPreviousPage() {
        if canGoToPrevious {
            currentPage -= 1
        }
    }
    
    /// Navigate to next page
    func goToNextPage() {
        if canGoToNext {
            currentPage += 1
        }
    }
}


//MARK: Handle Event
extension GamificationMissionGridViewModel {
    
    func handleMissionLaunch (_ mission: GamificationMissionTypeDataModel.Course) {
        eventPublisher.publish(.launchCourse(mission.courseId))
    }
}
