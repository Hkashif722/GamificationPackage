//
//  GamificationConfig.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 15/11/25.
//


import Foundation

public struct GamificationConfig: Sendable {
    public let baseURL: String
    public let tokenProvider: @Sendable () -> String?

    public init(
        baseURL: String,
        tokenProvider: @escaping @Sendable () -> String?
    ) {
        self.baseURL = baseURL
        self.tokenProvider = tokenProvider
    }
}
