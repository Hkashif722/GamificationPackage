//
//  GamificationCriticalMissionListView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 10/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationCriticalMissionListView: View {
    var body: some View {
        VStack {
            GamificationCriticalMissionHeaderView()
            gamificationCriticalMissionContentView
        }
        .frame(width: 450)
        .padding()
        .background {
            backgroundFrostView
        }
        .padding(.init(top: 10, leading: 0, bottom: 36, trailing: 0))
    }
    
    
    private var gamificationCriticalMissionContentView: some View {
        VStack {
            gamificationCriticalMissionListView
            GamificationCriticalMissionSeeAllButtonView()
        }
    }
    
    private var gamificationCriticalMissionListView: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(0..<5) { _ in
                    GamificationCriticalMissionListItemView()
                    Divider()
                        .background(Color.white)
                }
            }
            .foregroundStyle(.white)
        }
        .versionedContentMargins()
        .applyScrollBounceBehavior()
    }
    
    
    private var backgroundFrostView: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.clear)
            .frostedGlass(overlayOpacity: 0.7)
    }
}

#Preview {
    GamificationCriticalMissionListView()
}
