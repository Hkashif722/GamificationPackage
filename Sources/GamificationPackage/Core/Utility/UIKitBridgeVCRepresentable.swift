//
//  UIKitBridgeVCRepresentable.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 14/11/25.
//

import UIKit
import SwiftUI


internal struct UIKitBridgeVCRepresentable {
    
    
    
    struct BlurView: UIViewRepresentable {
        
        let style: UIBlurEffect.Style
        func makeUIView(context: Context) -> some UIView {
            
            let blurView = UIVisualEffectView(effect: UIBlurEffect(style: style))
            return blurView
        }
        
        func updateUIView(_ uiView: UIViewType, context: Context) {
            
        }
        
    }
    
    
}
