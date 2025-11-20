//
//  GamificationCriticalMissionDataModel.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 20/11/25.
//

import SwiftUI
import NetworkService

internal struct GamificationCriticalMissionDataModel {
    
    //MARK: TODO Request Model
    struct TODORequestModel: EndpointModel {
        var path: String {
            [
                APIConst.courseBaseUrl,
                APIConst.versionAPI,
                APIConst.toDoURN
            ].joined(separator: "/")
        }
        
        var method: NetworkService.HTTPMethod { .get }
        
        var headers: [String : String]? { nil }
    }
    
    
    //MARK: TODO Response Model
    enum TODOTypeEnum {
        case course
        case developmentPlan
        case survey
        case quiz
        
        /// Initialize from a String (case-insensitive).
        init?(from string: String) {
            switch string.lowercased() {
            case "course":
                self = .course
            case "developmentplan":
                self = .developmentPlan
            case "survey":
                self = .survey
            case "quiz":
                self = .quiz
            default:
                return nil
            }
        }
    }
    
    struct TODOResponseModel: Codable, Identifiable {
        var id: Int
        var title: String
        var scheduleDate: String?
        var endDate: String?
        var priority: Bool?
        var status: ToDoStatus?
        var type: String?
        var assignmentType: AssignmentType?
        var moduleType: String? // New property to handle the "moduleType" field
        
        enum CodingKeys: String, CodingKey {
            case id
            case title
            case scheduleDate
            case endDate
            case priority
            case status
            case type
            case assignmentType
            case moduleType // Added here to decode the "moduleType" field
        }
        
        
        var todoType: TODOTypeEnum? {
            return  TODOTypeEnum(from: self.type ?? "")
        }
        
        
        var typeRepresentable: String {
            "Type: \(self.type ?? "")"
        }
        
        var priorityHighLowRepresentable: String {
            guard let priority = self.priority else { return "Low" }
            return priority ? "High" : "Low"
        }
        
        /// Computed property to get the progress value for the task
        var toDoProgressValue: Double {
            switch status {
            case .notStarted:
                return 0.0
            case .inProgress:
                return 0.5
            case .completed:
                return 1.0
            case .none, .unknown:
                return 0.0
            }
        }
        
        /// Computed property to calculate the number of days between scheduleDate and endDate
        var numberOfDays: String? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy" // Matches the format of the JSON dates

            guard
                let scheduleDate = scheduleDate,
                let endDate = endDate,
                let start = dateFormatter.date(from: scheduleDate),
                let end = dateFormatter.date(from: endDate)
            else { return nil }

            let calendar = Calendar.current
            let components = calendar.dateComponents([.day], from: start, to: end)
            guard let numberOfDays = components.day else { return nil }
            return "\(numberOfDays) Days"
        }
        
        var assignmentTypeValueAndColor: (value: String, color: Color)? {
            
            switch assignmentType {
            case .mandatory:
                return (value: assignmentType?.rawValue.uppercased() ?? "", color: Color(hex: "#7d0505"))
            
            case .some(.optional):
                return (value: assignmentType?.rawValue.uppercased() ?? "", color: Color(hex: "#89c247"))
            case .some(.recommended):
                return (value: assignmentType?.rawValue.uppercased() ?? "", color: Color(hex: "#ffb207"))
            case .some(.compliance):
                return (value: assignmentType?.rawValue.uppercased() ?? "", color: Color(hex: "#147cbb"))
            case .none,.unknown:
                return nil
            }
        }

    }
    
    
    /// Enum for representing TODO task status with raw string values
    enum ToDoStatus: String, Codable {
        case notStarted = "notstarted"
        case inProgress = "inprogress"
        case completed = "completed"
        case unknown = "unknown" // Fallback case for invalid or empty values

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let rawValue = try container.decode(String.self).trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
            
            self = ToDoStatus(rawValue: rawValue) ?? .unknown
        }
    }

    
    enum AssignmentType: String, Codable {
        case mandatory = "Mandatory"
        case optional = "Optional"
        case recommended = "Recommended"
        case compliance = "Compliance"
        case unknown = "Unknown" // Fallback case for empty or unrecognized values

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let rawValue = try container.decode(String.self).trimmingCharacters(in: .whitespacesAndNewlines)

            self = AssignmentType(rawValue: rawValue) ?? .unknown
        }
    }

    
}



//MARK: Preview Model

extension GamificationCriticalMissionDataModel.TODOResponseModel {
    
    /// Sample preview data for SwiftUI previews and testing
    static var preview: Self {
        .init(
            id: 1,
            title: "Complete iOS Development Course",
            scheduleDate: "01 Nov 2024",
            endDate: "30 Nov 2024",
            priority: true,
            status: .inProgress,
            type: "course",
            assignmentType: .mandatory,
            moduleType: "Learning Module"
        )
    }
    
    /// Preview data for not started task
    static var previewNotStarted: Self {
        .init(
            id: 2,
            title: "Swift Concurrency Best Practices",
            scheduleDate: "15 Nov 2024",
            endDate: "15 Dec 2024",
            priority: false,
            status: .notStarted,
            type: "course",
            assignmentType: .optional,
            moduleType: "Advanced Course"
        )
    }
    
    /// Preview data for completed task
    static var previewCompleted: Self {
        .init(
            id: 3,
            title: "Annual Compliance Survey",
            scheduleDate: "01 Oct 2024",
            endDate: "31 Oct 2024",
            priority: true,
            status: .completed,
            type: "survey",
            assignmentType: .compliance,
            moduleType: "Compliance"
        )
    }
    
    /// Preview data for quiz type
    static var previewQuiz: Self {
        .init(
            id: 4,
            title: "SwiftUI Assessment Quiz",
            scheduleDate: "20 Nov 2024",
            endDate: "27 Nov 2024",
            priority: true,
            status: .inProgress,
            type: "quiz",
            assignmentType: .mandatory,
            moduleType: "Assessment"
        )
    }
    
    /// Preview data for development plan
    static var previewDevelopmentPlan: Self {
        .init(
            id: 5,
            title: "Q4 Professional Development Plan",
            scheduleDate: "01 Nov 2024",
            endDate: "31 Dec 2024",
            priority: false,
            status: .notStarted,
            type: "developmentplan",
            assignmentType: .recommended,
            moduleType: "Career Development"
        )
    }
    
    /// Array of sample todos for list previews
    static var previewList: [Self] {
        [
            preview,
            previewNotStarted,
            previewCompleted,
            previewQuiz,
            previewDevelopmentPlan
        ]
    }
    
    /// Preview data with minimal fields
    static var previewMinimal: Self {
        .init(
            id: 6,
            title: "Basic Task",
            scheduleDate: nil,
            endDate: nil,
            priority: nil,
            status: nil,
            type: nil,
            assignmentType: nil,
            moduleType: nil
        )
    }
}
