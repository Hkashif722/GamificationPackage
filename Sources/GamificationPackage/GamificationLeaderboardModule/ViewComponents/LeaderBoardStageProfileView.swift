//
//  LeaderBoardStageProfileView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 05/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

internal struct LeaderBoardStageProfileView: View {
    
    let topRanking: [GamificationDashboardDataModel.LeaderBoardResponseModel.Ranking]
    
    var body: some View {
        
        HStack(alignment: .bottom, spacing: 0) {
            secondaryStageView
            firstStageView
            tertiaryStageView
        }
        .padding(.top, -2.5)
    }
    
    
    private var secondaryStageView: some View {
        VStack(spacing: 0) {
            secondaryProfileView
            secondaryProfileInfoView
        }
    }
    
    private var firstStageView: some View {
        VStack(spacing: 0) {
            firstProfileView
            firstProfileInfoView
        }
    }
    
    private var tertiaryStageView: some View {
        VStack(spacing: 0) {
            tertiaryProfileView
            tertiaryProfileInfoView
        }
    }
    
    // ProfileInfo View
    
    @ViewBuilder
    private var secondaryProfileInfoView: some View {
        if let secondRank = topRanking[safe: 1] {
            frostView(corners: [.topLeft])
                .frame(width: 130, height: 45)
                .overlay(alignment: .bottom) {
                    profileInfoView(name: secondRank.userName, points: String(secondRank.totalPoint))
                        .frame(width: 100, height: 35)
                }
        }
            
    }
    
    @ViewBuilder
    private var firstProfileInfoView: some View {
        if let firseRank = topRanking[safe: 0] {
            frostView(corners: [.topLeft, .topRight])
                .frame(width: 130, height: 60)
                .overlay(alignment: .bottom) {
                    profileInfoView(name: firseRank.userName, points: String(firseRank.totalPoint))
                        .frame(width: 100, height: 35)
                    
                }
        }
            
    }
    
    @ViewBuilder
    private var tertiaryProfileInfoView: some View {
        if let thirdRank = topRanking[safe: 2] {
            frostView(corners: [.topRight])
                .frame(width: 130, height: 37)
                .overlay(alignment: .bottom) {
                    profileInfoView(name: thirdRank.userName, points: String(thirdRank.totalPoint))
                        .frame(width: 100, height: 35)
                }
        }
           
    }
    
   // Profile View
    @ViewBuilder
    private var secondaryProfileView: some View {
        if let secondRank = topRanking[safe: 1] {
            SwiftUIUtility.ProfileImageViewWithGradientBorder(
                imageUrl: secondRank.fullProfilePath,
                size: 50,
                gradientColors: [Color(hex: "#FFFFFF"), Color(hex: "#575757")],
                borderWidth: 4
            )
            .overlay(alignment: .bottom) {
                rankBadgeView(rank: "2", size: 25)
            }
            .zIndex(1)
        }
    }
    
    @ViewBuilder
    private var firstProfileView: some View {
        if let firseRank = topRanking[safe: 0] {
            SwiftUIUtility.ProfileImageViewWithGradientBorder(
                imageUrl: firseRank.fullProfilePath,
                size: 60,
                gradientColors: [Color(hex: "#FFDD57"), Color(hex: "#FFFF9D")],
                borderWidth: 5
            )
            .overlay(alignment: .topLeading) {
                crownView
            }
            .overlay(alignment: .bottom) {
                rankBadgeView(rank: "1")
            }
            .zIndex(1)
        }
    }
    
    @ViewBuilder
    private var tertiaryProfileView: some View {
        if let thirdRank = topRanking[safe: 2] {
            SwiftUIUtility.ProfileImageViewWithGradientBorder(
                imageUrl: thirdRank.fullProfilePath,
                size: 40,
                gradientColors: [Color(hex: "#FF9511"), Color(hex: "#725502")],
                borderWidth: 3
            )
            .overlay(alignment: .bottom) {
                rankBadgeView(rank: "3", size: 20)
            }
            .zIndex(1)
        }
    }
    
    
    private var crownView: some View {
        Image("gm_leader_crown", bundle: .module)
            .resizable()
            .scaledToFit()
            .frame(width: 30, height: 30)
            .offset(y: -21)
    }
    
    
    private func rankBadgeView(rank: String, size: CGFloat = 30) -> some View {
        Image("gm_leaderboard_rank_badge", bundle: .module)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .overlay {
                Text(rank)
                    .appFont(.poppinsSemiBold, size: 10, weight: .bold)
                    .foregroundStyle(.white)
            }
            .offset(y: (size/2))
    }
    
    
    
    // Profile Info View
    private func profileInfoView(name: String, points: String) -> some View {
        VStack(spacing: 0) {
            Text(name)
                .appFont(.poppinsMedium, size: 10, weight: .bold)
            Text(points)
                .appFont(.poppinsBold, size: 10, weight: .bold)
        }
        .versionedLineLimit(1)
        .foregroundStyle(.white)
    }
    
    private func frostView(corners: UIRectCorner = .allCorners) -> some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.clear)
            .frostedGlass(corners: corners,overlayOpacity: 0.7)
    }
}
