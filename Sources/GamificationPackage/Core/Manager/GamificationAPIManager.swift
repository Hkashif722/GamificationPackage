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
    
    private var config: GamificationConfig?
    
    private init() {}

    // Call this once from the host app
    public func configure(_ config: GamificationConfig) {
        self.config = config
        
        // Note: You'll need to make ApiService calls async
        ApiService.shared.setAuthToken(config.tokenProvider)
        APIConfiguration.shared.baseURL = config.baseURL
        
    }

    // Shared accessor
    public var baseURL: String {
        config?.baseURL ?? ""
    }
}
