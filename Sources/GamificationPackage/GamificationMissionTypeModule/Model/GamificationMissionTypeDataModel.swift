//
//  GamificationMissionTypeDataModel.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 10/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationMissionTypeDataModel {
    
    enum MissionTypeProgressEnum: String, CaseIterable, Identifiable {
        case miniMission =  "MINI MISSIONS"
        case mission = "MISSIONS"
        case bossMission = "BOSS MISSIONS"
        
        var id: String { self.rawValue }
        
        var getGradientColors: [Color] {
            switch self {
            case .miniMission:
                return [Color.orange,Color.orange, Color.yellow]
            case .mission:
                return [Color.orange, Color.purple.opacity(1.5)]
            case .bossMission:
                return [Color.cyan, Color.blue]
            }
        }
    }
}

extension GamificationMissionTypeDataModel {
    
    struct Course: Codable, Identifiable {
        let courseId: Int
        let title: String
        let mission: String?
        let description: String?
        let thumbnailPath: String?
        let categoryName: String?
        let subCategoryName: String?
        let subSubCategoryName: String?
        let code: String?
        let courseFee: Double?
        let courseTaxPercentage: Double?
        let currency: String?
        let courseType: String?
        let completionPeriodDays: Int?
        let courseCreationdDays: Int?
        let numberofModules: Int?
        let categoryId: Int?
        let subCategoryId: Int?
        let subSubCategoryId: Int?
        let courseRating: Double?
        let status: CourseStatus?
        let isFeedback: Bool?
        let isAssignment: Bool?
        let isAssessment: Bool?
        let isPreAssessment: Bool?
        let isCertificateIssued: Bool?
        let courseStartDate: String?
        let courseCompleteDate: String?
        let createdDate: String?
        let assignDate: String?
        let rewardPoint: Int?
        let isCourseApplicable: Bool?
        let courseApprovalStatus: String?
        let competencyCategory: String?
        let competencyCategoryID: Int?
        let assessmentPercentage: Double?
        let scheduleRequestStatus: String?
        let durationInMinutes: Int?
        let assessmentResult: String?
        let isPreRequisiteCourse: Bool?
        let isExternalProvider: Bool?
        let externalProvider: String?
        let courseURL: String?
        let isRetraining: Bool?
        let nodalApprovalStatus: String?
        let isSCORM: Bool?
        let firstAccessDate: String?
        let lastAccessDate: String?
        let timeSpent: String?
        let views: Int?
        let progressinpercentage: Int?
        let score: Int?
        let assignmentType: String?
        let courseDueDate: String?
        let pathLink: String?
        let alreadyEnrolled: Bool?
        let totalRating: Double?
        let externalDescription: String?
        let isParentCourse: Bool?
        let childCoursesCount: Int?
        
        // Conformance to Identifiable
        var id: Int { courseId }
    }

    // MARK: - Course Status Enum
    enum CourseStatus: String, Codable {
        case notStarted = "NotStarted"
        case inProgress = "InProgress"
        case completed = "Completed"
        case expired = "Expired"
    }
}
