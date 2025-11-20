//
//  GamificationHappyLearningDataModel.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 17/11/25.
//

import Foundation
import NetworkService


struct GamificationHappyLearningDataModel {
    
    
    struct HappyLearningHoursRequestModel: EndpointModel {
        var path: String {
            [
                APIConst.courseBaseUrl,
                APIConst.versionAPI,
                APIConst.GetTodaysHappyHours
            ].joined(separator: "/")
        }
        
        var method: NetworkService.HTTPMethod { .get }
        
        var headers: [String : String]? { nil }
        
        
    }
    

    struct HappyLearningHoursResponseModel: Codable, Identifiable {
        let id: Int
        let date: Date           // date at midnight (parsed from "date")
        let fromTime: Date       // full Date (date + fromTime)
        let toTime: Date         // full Date (date + toTime)
        let pointMultiplier: Int

        enum CodingKeys: String, CodingKey {
            case id
            case date
            case fromTime
            case toTime
            case pointMultiplier = "pointmultiplier"
        }

        // Helpers to expose start/end if needed
        var start: Date { fromTime }
        var end: Date { toTime }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            id = try container.decode(Int.self, forKey: .id)
            pointMultiplier = try container.decode(Int.self, forKey: .pointMultiplier)

            let dateString = try container.decode(String.self, forKey: .date)       // "2025-11-18T00:00:00"
            let fromTimeString = try container.decode(String.self, forKey: .fromTime) // "13:00:00"
            let toTimeString = try container.decode(String.self, forKey: .toTime)     // "13:15:00"

            // Parse the date string (server format: "yyyy-MM-dd'T'HH:mm:ss")
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.timeZone = .current
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

            guard let baseDate = dateFormatter.date(from: dateString) else {
                throw DecodingError.dataCorruptedError(forKey: .date,
                                                       in: container,
                                                       debugDescription: "Invalid date string: \(dateString)")
            }
            // Extract year/month/day from baseDate
            let calendar = Calendar.current
            let dateComponents = calendar.dateComponents([.year, .month, .day], from: baseDate)

            // Parse time string "HH:mm:ss" into components and combine with date
            func combine(timeString: String) -> Date? {
                let parts = timeString.split(separator: ":").map { Int($0) }
                guard parts.count >= 2,
                      let hour = parts[0], let minute = parts[1] else { return nil }
                let second = (parts.count >= 3) ? (parts[2] ?? 0) : 0

                var comps = DateComponents()
                comps.year = dateComponents.year
                comps.month = dateComponents.month
                comps.day = dateComponents.day
                comps.hour = hour
                comps.minute = minute
                comps.second = second
                comps.timeZone = TimeZone.current
                return calendar.date(from: comps)
            }

            guard let fullFrom = combine(timeString: fromTimeString) else {
                throw DecodingError.dataCorruptedError(forKey: .fromTime,
                                                       in: container,
                                                       debugDescription: "Invalid fromTime string: \(fromTimeString)")
            }
            guard let fullTo = combine(timeString: toTimeString) else {
                throw DecodingError.dataCorruptedError(forKey: .toTime,
                                                       in: container,
                                                       debugDescription: "Invalid toTime string: \(toTimeString)")
            }

            date = calendar.startOfDay(for: baseDate)
            fromTime = fullFrom
            toTime = fullTo
        }
    }

    

}



internal extension Array where Element == GamificationHappyLearningDataModel.HappyLearningHoursResponseModel {
    func sortedByTime() -> [Element] {
        sorted {
            if $0.fromTime == $1.fromTime {
                return $0.toTime < $1.toTime
            }
            return $0.fromTime < $1.fromTime
        }
    }
}

internal extension Array where Element == GamificationHappyLearningDataModel.HappyLearningHoursResponseModel {
    func activeWindow() -> (model: Element, remainingSeconds: Int)? {
        let now = Date()

        for item in self {
            if now >= item.fromTime && now <= item.toTime {
                let remaining = Int(item.toTime.timeIntervalSince(now))
                return (item, remaining)
            }
        }
        return nil
    }
}
