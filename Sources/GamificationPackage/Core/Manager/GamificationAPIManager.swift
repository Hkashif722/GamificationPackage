//
//  APIManager.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 15/11/25.
//


import Foundation
import NetworkService

public actor GamificationAPIManager {

    public static let shared = GamificationAPIManager()
    
    nonisolated(unsafe) private var config: GamificationConfig?
    
    nonisolated internal var getOrgCode: String {
        config?.orgCode ?? ""
    }
    
    nonisolated internal var isBlobEnabled: Bool {
        config?.isBlobEnabled ?? true
    }
    
    private init() {}

    // Call this once from the host app
    public func configure(_ config: GamificationConfig) {
        self.config = config
        
        // Note: You'll need to make ApiService calls async
        ApiService.shared.setAuthToken(config.tokenProvider)
        APIConfiguration.shared.baseURL = APIConst.baseURL
        
    }

    // Shared accessor
    public var baseURL: String {
        APIConst.baseURL
    }
}
