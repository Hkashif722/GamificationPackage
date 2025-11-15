//
//  LogLevel.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 15/11/25.
//


//
//  Logger.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 02/01/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import Foundation

enum LogLevel: String {
    case info = "ℹ️ INFO"
    case debug = "🐛 DEBUG"
    case warning = "⚠️ WARNING"
    case error = "❌ ERROR"
}

class Logger {
    static let shared = Logger()

    private let queue = DispatchQueue(label: "com.logger.queue", qos: .utility)
    private let isXcodeConsole: Bool

    private init() {
        // Detect if running in Xcode console
        #if DEBUG
        isXcodeConsole = true
        #else
        isXcodeConsole = false
        #endif
    }

    func log(_ level: LogLevel, message: String, payload: [String: Any]? = nil, useColor: Bool = true) {
        
        #if DEBUG
        
        let timestamp = Date().formatted("yyyy-MM-dd HH:mm:ss.SSS")
        let formattedMessage = formatMessage(level: level, timestamp: timestamp, message: message)

        queue.async {
            let shouldUseColor = useColor && !self.isXcodeConsole

            // Print main message to console
            self.outputToConsole(level: level, message: formattedMessage, useColor: shouldUseColor)

            // Log payload separately
            if let payload = payload {
                self.logPayload(level: level, payload: payload, useColor: shouldUseColor)
            }
        }
        
        #endif
    }

    private func formatMessage(level: LogLevel, timestamp: String, message: String) -> String {
        return "[\(timestamp)] [\(level.rawValue)] \(message)"
    }

    private func outputToConsole(level: LogLevel, message: String, useColor: Bool) {
        let output = useColor ? applyColor(to: message, for: level) : message
        print(output)
    }

    private func applyColor(to message: String, for level: LogLevel) -> String {
        let colorCode: String
        switch level {
        case .info: colorCode = "\u{001B}[0;34m"   // Blue
        case .debug: colorCode = "\u{001B}[0;32m"  // Green
        case .warning: colorCode = "\u{001B}[0;33m" // Yellow
        case .error: colorCode = "\u{001B}[0;31m"  // Red
        }
        return "\(colorCode)\(message)\u{001B}[0m"
    }

    private func logPayload(level: LogLevel, payload: [String: Any], useColor: Bool) {
        do {
            let jsonCompatiblePayload = makePayloadJSONCompatible(payload: payload)
        
            let jsonData = try JSONSerialization.data(withJSONObject: jsonCompatiblePayload, options: .prettyPrinted)
            
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                let formattedPayload = useColor ? applyColor(to: jsonString, for: level) : jsonString
                print(formattedPayload)
            } else {
                log(.warning, message: "Failed to convert JSON data to string for payload: \(payload)")
            }
        } catch {
            log(.warning, message: "Failed to format payload: \(payload). Error: \(error.localizedDescription)")
        }
    }

    private func makePayloadJSONCompatible(payload: [String: Any]) -> [String: Any] {
        var jsonCompatiblePayload = [String: Any]()

        for (key, value) in payload {
            if let setValue = value as? Set<AnyHashable> {
                jsonCompatiblePayload[key] = setValue.map { item -> Any in
                    return convertToJSONCompatible(item)
                }
            } else if let arrayValue = value as? [Any] {
                jsonCompatiblePayload[key] = arrayValue.map { item -> Any in
                    return convertToJSONCompatible(item)
                }
            } else if let dictValue = value as? [String: Any] {
                jsonCompatiblePayload[key] = makePayloadJSONCompatible(payload: dictValue)
            } else {
                jsonCompatiblePayload[key] = convertToJSONCompatible(value)
            }
        }

        return jsonCompatiblePayload
    }

    private func convertToJSONCompatible(_ value: Any) -> Any {
        if let customValue = value as? CustomStringConvertible {
            return customValue.description
        } else if let customValue = value as? CustomDebugStringConvertible {
            return customValue.debugDescription
        } else if value is NSNull || value is String || value is NSNumber || value is Bool || value is Double || value is Int {
            return value
        } else {
            return String(describing: value)
        }
    }

}

extension Date {
    func formatted(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
