//
//  GamificationAccomplishmentListView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 11/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationAccomplishmentListView: View {
    
    var body: some View {
        VStack {
            gamificationAccomplishmentListView
        }
    }
    
    private var gamificationAccomplishmentListView: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach(0..<4) { item in
                    GamificationAccomplishmentListItemView()
                    dividerView(item)
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
    GamificationAccomplishmentListView()
}
