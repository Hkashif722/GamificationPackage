//
//  GamificationEventPublisher.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 25/11/25.
//


// Sources/GamificationPackage/Core/Events/GamificationEventPublisher.swift
import Combine
import Foundation

public final class GamificationEventPublisher {
    
    // Singleton instance
    @MainActor public static let shared = GamificationEventPublisher()
    
    // Private subject to emit events
    private let eventSubject = PassthroughSubject<GamificationEvent, Never>()
    
    // Public publisher that external consumers can subscribe to
    public var events: AnyPublisher<GamificationEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
    
    private init() {}
    
    // Internal method to publish events (only accessible within the package)
    internal func publish(_ event: GamificationEvent) {
        eventSubject.send(event)
    }
}
