//
//  LeaderBoardStageProfileView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 05/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

internal struct LeaderBoardStageProfileView: View {
    
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
    
    private var secondaryProfileInfoView: some View {
        frostView(corners: [.topLeft])
            .frame(width: 130, height: 45)
            .overlay(alignment: .bottom) {
                profileInfoView(name: "Alan", points: "28090")
                    .frame(width: 100, height: 35)
            }
            
    }
    
    
    private var firstProfileInfoView: some View {
        frostView(corners: [.topLeft, .topRight])
            .frame(width: 130, height: 60)
            .overlay(alignment: .bottom) {
                profileInfoView(name: "Rebacca", points: "2800")
                    .frame(width: 100, height: 35)
                
            }
            
    }
    
    private var tertiaryProfileInfoView: some View {
        frostView(corners: [.topRight])
            .frame(width: 130, height: 37)
            .overlay(alignment: .bottom) {
                profileInfoView(name: "Jessica", points: "21090")
                    .frame(width: 100, height: 35)
            }
           
    }
    
   // Profile View
    
    private var secondaryProfileView: some View {
        SwiftUIUtility.ProfileImageViewWithGradientBorder(
            imageUrl: URL(string:""),
            size: 50,
            gradientColors: [Color(hex: "#FFFFFF"), Color(hex: "#575757")],
            borderWidth: 4
        )
        .overlay(alignment: .bottom) {
            rankBadgeView(rank: "2", size: 25)
        }
        .zIndex(1)
    }
    
    private var firstProfileView: some View {
        SwiftUIUtility.ProfileImageViewWithGradientBorder(
            imageUrl: URL(string:""),
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
    
    private var tertiaryProfileView: some View {
        SwiftUIUtility.ProfileImageViewWithGradientBorder(
            imageUrl: URL(string:""),
            size: 40,
            gradientColors: [Color(hex: "#FF9511"), Color(hex: "#725502")],
            borderWidth: 3
        )
        .overlay(alignment: .bottom) {
            rankBadgeView(rank: "3", size: 20)
        }
        .zIndex(1)
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
