//
//  GamificationConfig.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 15/11/25.
//


import Foundation

public struct GamificationConfig: Sendable {
    
    public let orgCode: String
    public let isBlobEnabled: Bool
    public let tokenProvider: @Sendable () -> String?

    public init(
        baseURL: String,
        lxpOPath: String,
        lxpBlobPath: String,
        lxpBlobPath1: String,
        isBlobEnabled: Bool,
        orgCode: String,
        tokenProvider: @escaping @Sendable () -> String?
    ) {
        APIConst.baseURL = baseURL
        APIConst.lxpOPath = lxpOPath
        APIConst.lxpBlobPath = lxpBlobPath
        APIConst.lxpBlobPath1 = lxpBlobPath1
        self.isBlobEnabled = isBlobEnabled
        self.orgCode = orgCode
        self.tokenProvider = tokenProvider
    }
}
