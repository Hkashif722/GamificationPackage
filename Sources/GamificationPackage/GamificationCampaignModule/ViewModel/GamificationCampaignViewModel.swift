//
//  GamificationCampaignViewModel.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 24/11/25.
//

import Foundation
import NetworkService

@MainActor
internal final class GamificationCampaignViewModel: BaseRoutableNavModel {
    
    
    private(set) var groupedCampaigns: [GamificationDashboardDataModel.GroupedCampaign]
    
    @Published var currentCampaigns: GamificationDashboardDataModel.GroupedCampaign?
    
    @Published var currentPage: Int = 0
    
    // MARK: Course Pagination
    @Published var currentCoursePage: Int = 0
    let coursesPerPage: Int = 3
    
    //MARK: Computed Porperties
    
    var getCurrentCampaign:  GamificationDashboardDataModel.GroupedCampaign? {
        groupedCampaigns[safe: currentPage]
    }
    
    // MARK: Course Pagination Computed Properties
    
    private var allCourses: [GamificationDashboardDataModel.GroupedCampaign.Course] {
        getCurrentCampaign?.courses ?? []
    }
    
    var totalCourses: Int {
        allCourses.count
    }
    
    var totalCoursePages: Int {
        guard totalCourses > 0 else { return 0 }
        return (totalCourses + coursesPerPage - 1) / coursesPerPage
    }
    
    var paginatedCourses: [GamificationDashboardDataModel.GroupedCampaign.Course] {
        let startIndex = currentCoursePage * coursesPerPage
        let endIndex = min(startIndex + coursesPerPage, totalCourses)
        guard startIndex < totalCourses else { return [] }
        return Array(allCourses[startIndex..<endIndex])
    }
    
    var courseRangeStart: Int {
        currentCoursePage * coursesPerPage + 1
    }
    
    var courseRangeEnd: Int {
        min((currentCoursePage + 1) * coursesPerPage, totalCourses)
    }
    
    var coursePaginationText: String {
        guard totalCourses > 0 else { return "0 / 0" }
        return "\(courseRangeStart)-\(courseRangeEnd) / \(totalCourses)"
    }
    
    var hasNextCoursePage: Bool {
        currentCoursePage < totalCoursePages - 1
    }
    
    var hasPreviousCoursePage: Bool {
        currentCoursePage > 0
    }

    
    var hasNextPage: Bool {
        currentPage < groupedCampaigns.count - 1
    }
    
    var hasPreviousPage: Bool {
        currentPage > 0
    }
    
    func nextPage() {
        guard hasNextPage else { return }
        currentPage += 1
        resetCoursePagination()
    }
    
    func previousPage() {
        guard hasPreviousPage else { return }
        currentPage -= 1
        resetCoursePagination()
    }
    
    func jumpTo(page: Int) {
        guard page >= 0 && page < groupedCampaigns.count else { return }
        currentPage = page
        resetCoursePagination()
    }
    
    // MARK: Course Pagination Methods
    
    func nextCoursePage() {
        guard hasNextCoursePage else { return }
        currentCoursePage += 1
    }
    
    func previousCoursePage() {
        guard hasPreviousCoursePage else { return }
        currentCoursePage -= 1
    }
    
    private func resetCoursePagination() {
        currentCoursePage = 0
    }
        
    
    init(router: Router, campaignCourseData: [GamificationDashboardDataModel.GroupedCampaign]) {
        self.groupedCampaigns = campaignCourseData
        self.currentCampaigns = campaignCourseData.first
        super.init(router: router)
    }

}


extension GamificationCampaignViewModel {
    
    func onCourseClick(_ course: GamificationDashboardDataModel.GroupedCampaign.Course) {
        // Handle course click - navigate to course detail or start course
        // TODO: Implement navigation logic
        print("Course clicked: \(course.title) (ID: \(course.id))")
    }
}

