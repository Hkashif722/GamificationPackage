//
//  GamificationCampagnListView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 12/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationCampagnListView: View {
    var body: some View {
        gamificationPackageListView
    }
    
    
    private var gamificationPackageListView: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach(0..<5) { index in
                    GamificationCampaignListItemView(onClick: {})
                    dividerView(index)
                }
            }
        }
        .versionedContentMargins()
        .applyScrollBounceBehavior()
    }
    
    @ViewBuilder
    private func dividerView(_ index: Int) -> some View {
        if index < 4 {
            Divider()
                .background(.white)
        }
    }
}

#Preview {
    Color.gray.ignoresSafeArea()
    GamificationCampagnListView()
}
