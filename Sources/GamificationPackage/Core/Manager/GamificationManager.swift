//
//  GamificationManager.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 15/11/25.
//

import Foundation

public actor GamificationManager {
    
    public static let shared = GamificationManager()

    public var onEvent: ((GamificationEvent) -> Void)?

    private init() {}
    
    public func send(_ event: GamificationEvent) {
        onEvent?(event)
    }
}

public enum GamificationEvent {
    case rewardClaimed(id: String)
    case buttonTapped(name: String)
    case levelCompleted(level: Int)
}
