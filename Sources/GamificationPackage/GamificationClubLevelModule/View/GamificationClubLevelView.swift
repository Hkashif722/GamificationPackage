//
//  GamificationClubLevelView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 03/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

internal struct GamificationClubLevelView: View {
    
    let shadowColor: Color = Color(hex: "#FF00B4")
    
    // Track the currently selected club
    @State private var selectedClub: GamificationClubTypeDataModel.ClubType?
    
    // Simple animation trigger
    @State private var isAnimating = false
    
    var body: some View {
        
        ZStack {
            
            clubLevelItemListView
            
        }
        .center()
        .ignoresSafeArea()
        .onAppear {
            isAnimating = true
        }
    }
    
    
    private var clubLevelItemListView: some View {
        HStack(spacing: 16) {
            ForEach(
                Array(GamificationClubTypeDataModel.ClubType.allCases.enumerated()),
                id: \.element
            ) { index , club in
                GamificationClubLevelItemView(
                    clubType: club,
                    isClubLocked: club == GamificationClubTypeDataModel.ClubType.grandMaster
                )
                .shadow(
                    color: selectedClub == club ? shadowColor : .clear,
                    radius: 8
                )
                .onTapGesture {
                    selectedClub = club
                }
                .scaleEffect(isAnimating ? 1.0 : 0.8)
                .animation(
                    .spring(response: 0.6, dampingFraction: 0.7)
                    .delay(Double(index) * 0.15),
                    value: isAnimating
                )
            }
        }
    }
    
}


#Preview {
    GamificationClubLevelView()
}
