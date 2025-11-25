//
//  GamificationDashboardNavControlView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 03/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//


///---------------------------------` Gamification Nav Control Items`-------------------------------------------------
///-------------------------------------------------
///-------------------------------------------------


import SwiftUI

internal struct GamificationDashboardNavControlView: View {
    @Environment(\.dismiss) private var dismiss
    var onDismiss: (() -> Void)?
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            navigationControlBackgroundView
            navControlButtonViews
        }
        .topTrailing()
        .offset(y: 35)
        .ignoresSafeArea()
        
        
    }
    
    private var navigationControlBackgroundView: some View {
        Image(.gamificationNavControlBg)
            .resizable()
            .frame(width: 190, height: 60)
    }
    
    private var navControlButtonViews: some View {
        HStack {
            captureButtonView
            settingButtonView
            closeButtonView
        }
        .padding(.horizontal, 10)
        .offset(y: -3.2)
    }
    
    private var captureButtonView: some View {
        Button(action: {}) {
            Image(.icGmCapture)
                .frame(width: 45, height: 45)
        }
    }
    
    private var settingButtonView: some View {
        Button(action: {}) {
            Image(.icGmSetting)
                .frame(width: 45, height: 45)
        }
    }
    
    private var closeButtonView: some View {
        Button(action: handleDismiss) {
            Image(.icGmClose)
                .frame(width: 45, height: 45)
        }
    }
    
    private func handleDismiss() {
        if let onDismiss = onDismiss {
            onDismiss()
        } else {
            dismiss()
        }
    }
}


#Preview {
    GamificationDashboardNavControlView()
}
