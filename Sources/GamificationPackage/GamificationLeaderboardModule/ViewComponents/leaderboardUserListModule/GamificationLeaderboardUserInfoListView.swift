//
//  GamificationLeaderboardUserInfoListView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 10/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationLeaderboardUserInfoListView: View {
    var body: some View {
        gamificationLeaderboardUserInfoListView
    }
    
    private var gamificationLeaderboardUserInfoListView: some View {
        ScrollView {
            ForEach(0..<7) { _ in
                GamificationLeaderboardUserInfoListItemView()
            }
        }
        .versionedContentMargins()
        .applyScrollBounceBehavior()
    }
}

#Preview {
    GamificationLeaderboardUserInfoListView()
}
