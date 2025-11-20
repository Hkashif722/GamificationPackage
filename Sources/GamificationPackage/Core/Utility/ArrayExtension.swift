//
//  ArrayExtension.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 17/11/25.
//

import Foundation

internal extension Array where Element == String {
    func joinWithPathSeparator() -> String {
        return self.joined(separator: "/")
    }
}


internal extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
