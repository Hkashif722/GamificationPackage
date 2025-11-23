//
//  GamificationMissionTypeDataModel.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 10/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI
import NetworkService

struct GamificationMissionTypeDataModel {
    
    enum MissionTypeProgressEnum: Identifiable, Hashable {
        case miniMission(model: GamificationDashboardDataModel.GamificationMissionResponseModel, courses: [GamificationMissionTypeDataModel.Course])
        case mission(model: GamificationDashboardDataModel.GamificationMissionResponseModel, courses: [GamificationMissionTypeDataModel.Course])
        case bossMission(model: GamificationDashboardDataModel.GamificationMissionResponseModel, courses: [GamificationMissionTypeDataModel.Course])
        
        static func == (lhs: MissionTypeProgressEnum, rhs: MissionTypeProgressEnum) -> Bool {
            lhs.rawValue == rhs.rawValue
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(rawValue)
        }
        
        var id: String { rawValue }
        
        var getGradientColors: [Color] {
            switch self {
            case .miniMission:
                return [Color.orange, Color.orange, Color.yellow]
            case .mission:
                return [Color.orange, Color.purple.opacity(1.5)]
            case .bossMission:
                return [Color.cyan, Color.blue]
            }
        }
        
        var rawValue: String {
            switch self {
            case .miniMission:
                "MINI MISSIONS"
            case .mission:
                "MISSIONS"
            case .bossMission:
                "BOSS MISSIONS"
            }
        }
        
        // Get associated values
        var count: Int {
            switch self {
            case .miniMission(let model, _):
                return model.totalMiniMission
            case .mission(let model, _):
                return model.totalNormalMission
            case .bossMission(let model, _):
                return model.totalBossMission
            }
        }
        
        var courses: [GamificationMissionTypeDataModel.Course] {
            switch self {
            case .miniMission(_, let courses),
                 .mission(_, let courses),
                 .bossMission(_, let courses):
                return courses
            }
        }
        
        var completedCount: Int {
            switch self {
            case .miniMission(let model, _):
                return model.completedMiniMission
            case .mission(let model, _):
                return model.completedNormalMission
            case .bossMission(let model, _):
                return model.completedBossMission
            }
        }
        
        var progress: Double {
            count > 0 ? Double(completedCount) / Double(count) : 0.0
        }
    }
}


//MARK: mimi mission course count & course Request Model
extension GamificationMissionTypeDataModel {
    
    enum Endpoint: EndpointModel {
        
        case miniMissionCourseCount
        case miniMissionCourse
        case normalMissionCourseCount
        case normalMissionCourse
        case bossMissionCourseCount
        case bossMissionCourse
        
        var path: String {
            switch self {
            case .miniMissionCourseCount:
                return [
                    APIConst.courseBaseUrl,
                    APIConst.versionAPI,
                    APIConst.MiniMissionCount
                ].joined(separator: "/")
            case .miniMissionCourse:
                return [
                    APIConst.courseBaseUrl,
                    APIConst.versionAPI,
                    APIConst.GetMissionCourses
                ].joined(separator: "/")
            case .normalMissionCourseCount:
                return [
                    APIConst.courseBaseUrl,
                    APIConst.versionAPI,
                    APIConst.GetNormalCoursesCount
                ].joined(separator: "/")
            case .normalMissionCourse:
                return [
                    APIConst.courseBaseUrl,
                    APIConst.versionAPI,
                    APIConst.GetNormalCourses
                ].joined(separator: "/")
            case .bossMissionCourseCount:
                return [
                    APIConst.courseBaseUrl,
                    APIConst.versionAPI,
                    APIConst.GetBossCoursesCount
                ].joined(separator: "/")
            case .bossMissionCourse:
                return [
                    APIConst.courseBaseUrl,
                    APIConst.versionAPI,
                    APIConst.GetBossCourses
                ].joined(separator: "/")
            }
            
        }
        
        var method: NetworkService.HTTPMethod  { .get }
        
        var headers: [String : String]? { nil }
        
    }
    
}



//MARK: Response Model
extension GamificationMissionTypeDataModel {
    
    struct Course: Codable, Identifiable, Hashable {
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
        
        /// Returns the parsed CourseType enum from the courseType string
        var parsedCourseType: CourseType {
            CourseType(from: courseType) ?? .online
        }
    }

    // MARK: - Course Status Enum
    enum CourseStatus: String, Codable, CaseIterable {
        case notStarted = "NotStarted"
        case inProgress = "InProgress"
        case completed = "Completed"
        case expired = "Expired"
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let rawValue = try container.decode(String.self)
            
            // Try exact match first, then lowercase match
            if let status = CourseStatus(rawValue: rawValue) {
                self = status
            } else if let status = CourseStatus.allCases.first(where: { $0.rawValue.lowercased() == rawValue.lowercased() }) {
                self = status
            } else {
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Cannot initialize CourseStatus from invalid String value \(rawValue)"
                )
            }
        }
    }
    
    // MARK: - Course Type Enum
    enum CourseType: String, CaseIterable {
        case certification = "Certification"
        case elearning = "Elearning"
        case blended = "Blended"
        case classroom = "Classroom"
        case vilt = "Vilt"
        case online = "Online"
        case webinar = "Webinar"
        
        init?(from string: String?) {
            guard let string = string else { return nil }
            
            // Try exact match first, then case-insensitive match
            if let type = CourseType(rawValue: string) {
                self = type
            } else if let type = CourseType.allCases.first(where: { $0.rawValue.lowercased() == string.lowercased() }) {
                self = type
            } else {
                return nil
            }
        }
        
        var iconName: String {
            switch self {
            case .classroom, .vilt:
                return "ic_gm_course_type_classroom"
            case .online, .elearning, .webinar:
                return "ic_gm_course_type_online"
            case .blended:
                return "ic_gm_course_type_blended"
            case .certification:
                return "ic_gm_course_type_certification"
            }
        }
        
        
        var displayName: String {
            switch self {
            case .certification:
                return "Assessment"
            case .elearning:
                return "E-Learning"
            case .blended:
                return "Blended"
            case .classroom:
                return "Classroom"
            case .vilt:
                return "VILT"
            case .online:
                return "Online"
            case .webinar:
                return "Webinar"
            }
        }
    }
}


// MARK: - Preview Data
extension GamificationMissionTypeDataModel {
    
    enum PreviewData {
        
        static let sampleCourse = Course(
            courseId: 1,
            title: "Sample Course",
            mission: "Mini Mission",
            description: "A sample course for preview purposes",
            thumbnailPath: nil,
            categoryName: "Training",
            subCategoryName: nil,
            subSubCategoryName: nil,
            code: "SC001",
            courseFee: 0,
            courseTaxPercentage: 0,
            currency: "INR",
            courseType: "Online",
            completionPeriodDays: 30,
            courseCreationdDays: 7,
            numberofModules: 5,
            categoryId: 1,
            subCategoryId: nil,
            subSubCategoryId: nil,
            courseRating: 4.5,
            status: .notStarted,
            isFeedback: false,
            isAssignment: false,
            isAssessment: true,
            isPreAssessment: false,
            isCertificateIssued: true,
            courseStartDate: nil,
            courseCompleteDate: nil,
            createdDate: "2025-01-01",
            assignDate: "2025-01-15",
            rewardPoint: 100,
            isCourseApplicable: true,
            courseApprovalStatus: "Approved",
            competencyCategory: nil,
            competencyCategoryID: nil,
            assessmentPercentage: 0,
            scheduleRequestStatus: nil,
            durationInMinutes: 60,
            assessmentResult: nil,
            isPreRequisiteCourse: false,
            isExternalProvider: false,
            externalProvider: nil,
            courseURL: nil,
            isRetraining: false,
            nodalApprovalStatus: nil,
            isSCORM: false,
            firstAccessDate: nil,
            lastAccessDate: nil,
            timeSpent: nil,
            views: 0,
            progressinpercentage: 0,
            score: 0,
            assignmentType: nil,
            courseDueDate: nil,
            pathLink: nil,
            alreadyEnrolled: false,
            totalRating: 4.5,
            externalDescription: nil,
            isParentCourse: false,
            childCoursesCount: 0
        )
        
        static let sampleCourses: [Course] = [
            sampleCourse,
            Course(
                courseId: 2,
                title: "Advanced Training",
                mission: "Normal Mission",
                description: "An advanced training course",
                thumbnailPath: nil,
                categoryName: "Training",
                subCategoryName: nil,
                subSubCategoryName: nil,
                code: "AT002",
                courseFee: 0,
                courseTaxPercentage: 0,
                currency: "INR",
                courseType: "Online",
                completionPeriodDays: 45,
                courseCreationdDays: 14,
                numberofModules: 8,
                categoryId: 1,
                subCategoryId: nil,
                subSubCategoryId: nil,
                courseRating: 4.8,
                status: .inProgress,
                isFeedback: true,
                isAssignment: true,
                isAssessment: true,
                isPreAssessment: true,
                isCertificateIssued: true,
                courseStartDate: "2025-01-20",
                courseCompleteDate: nil,
                createdDate: "2025-01-01",
                assignDate: "2025-01-15",
                rewardPoint: 250,
                isCourseApplicable: true,
                courseApprovalStatus: "Approved",
                competencyCategory: nil,
                competencyCategoryID: nil,
                assessmentPercentage: 50,
                scheduleRequestStatus: nil,
                durationInMinutes: 120,
                assessmentResult: nil,
                isPreRequisiteCourse: false,
                isExternalProvider: false,
                externalProvider: nil,
                courseURL: nil,
                isRetraining: false,
                nodalApprovalStatus: nil,
                isSCORM: false,
                firstAccessDate: "2025-01-20",
                lastAccessDate: "2025-01-25",
                timeSpent: "60",
                views: 5,
                progressinpercentage: 50,
                score: 0,
                assignmentType: nil,
                courseDueDate: "2025-03-01",
                pathLink: nil,
                alreadyEnrolled: true,
                totalRating: 4.8,
                externalDescription: nil,
                isParentCourse: false,
                childCoursesCount: 0
            )
        ]
        
        static let miniMission: (count: Int, courses: [Course]) = (3, sampleCourses)
        static let normalMission: (count: Int, courses: [Course]) = (5, sampleCourses)
        static let bossMission: (count: Int, courses: [Course]) = (2, sampleCourses)
    }
}
