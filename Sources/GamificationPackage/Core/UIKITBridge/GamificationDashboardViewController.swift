//
//  GamificationUIKitBridge.swift
//  GamificationPackage
//
//  Created by Assistant
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import UIKit
import SwiftUI

// MARK: - Gamification Dashboard UIKit Wrapper
// In GamificationUIKitBridge.swift
// In GamificationUIKitBridge.swift
public class GamificationDashboardViewController: UIViewController {
    
    private var hostingController: UIHostingController<AnyView>?
    private var config: GamificationConfig
    private var gamificationPackage: GamificationPackage?
    
    public init(config: GamificationConfig) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupDashboard()
    }
    
    private func setupDashboard() {
        Task {
            // Initialize GamificationPackage with config
            gamificationPackage = await GamificationPackage(config: config)
            
            guard let pkg = gamificationPackage else { return }
            
            
            let dashboardView = pkg.dashboard(
                onDismiss: { [weak self] in
                    self?.handleDismiss()
                }
            )
            
            let hosting = UIHostingController(rootView: AnyView(dashboardView))
            
            await MainActor.run {
                hostingController = hosting
                
                addChild(hosting)
                view.addSubview(hosting.view)
                
                hosting.view.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    hosting.view.topAnchor.constraint(equalTo: view.topAnchor),
                    hosting.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    hosting.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    hosting.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
                
                hosting.didMove(toParent: self)
            }
        }
    }
    
    private func handleDismiss() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        } else if presentingViewController != nil {
            dismiss(animated: true)
        } else if parent != nil {
            willMove(toParent: nil)
            view.removeFromSuperview()
            removeFromParent()
        }
    }
}

// MARK: - UIViewController Extension
public extension UIViewController {
    
    func presentGamificationDashboard(
        config: GamificationConfig,
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        let dashboardVC = GamificationDashboardViewController(config: config)
        dashboardVC.modalPresentationStyle = .fullScreen
        present(dashboardVC, animated: animated, completion: completion)
    }
    
    func pushGamificationDashboard(
        config: GamificationConfig,
    ) {
        let dashboardVC = GamificationDashboardViewController(config: config)
        navigationController?.pushViewController(dashboardVC, animated: true)
    }
    
    func embedGamificationDashboard(
        in containerView: UIView,
        config: GamificationConfig
    ) {
        let dashboardVC = GamificationDashboardViewController(config: config)
        addChild(dashboardVC)
        containerView.addSubview(dashboardVC.view)
        
        dashboardVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dashboardVC.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            dashboardVC.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            dashboardVC.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            dashboardVC.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        dashboardVC.didMove(toParent: self)
    }
}
