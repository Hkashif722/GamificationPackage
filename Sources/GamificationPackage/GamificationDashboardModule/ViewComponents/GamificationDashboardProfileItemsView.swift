//
//  GamificationDashboardProfileItemsView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 03/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//



import SwiftUI

internal struct GamificationDashboardProfileItemsView: View {
    
    let userProfileDetail = GamificationClubTypeDataModel.shared.userProfileDetail
    
    var body: some View {
        
        ZStack {
            HStack(alignment: .top, spacing: 0) {
                
                profileImageView
                
                profileInfoView
                
            }
        }
        .bottomLeading()
        .offset(y: -10)
        .ignoresSafeArea(edges: .bottom)
    }
    
    private var profileImageView: some View {
        SwiftUIUtility.ProfileImageView(
            imageUrl: userProfileDetail?.computedUseProlePictureURL,
            size: 81,
            profileBorderColor: .white,
            borderWidth: 5
        )
        .zIndex(2)
    }
    
    
    private var profileInfoView: some View {
        VStack(alignment: .leading, spacing: 0) {
            welcomeTextMessageView
            profileNameView
            houseNameTextView
        }
        .offset(x: -53, y: -3)
        .zIndex(1)
    }
    
    private var welcomeTextMessageView: some View {
        Text("WELCOME")
            .appFont(.poppinsRegular, size: 12.4)
            .foregroundStyle(ColorUtility.label)
            .padding(.init(top: 5, leading: 48, bottom: 5, trailing: 15))
            .background(.white)
            .clipShape(Capsule())
           
            
    }
    
    @ViewBuilder
    private var profileNameView: some View {
//        if let userName = userProfileDetail?.userName {
            Text("Kashif")
            .appFont(.poppinsBold, size: 12.4, weight: .bold)
                .foregroundStyle(.white)
                .padding(.init(top: 8, leading: 58, bottom: 8, trailing: 25))
                .background(ColorUtility.primaryColor)
                .clipShape(Capsule())
//        }
    }
    
    @ViewBuilder
    private var houseNameTextView: some View {
//        if let house = userProfileDetail?.house {
            Text("Blue House")
            .appFont(.poppinsRegular, size: 12.4)
                .foregroundStyle(ColorUtility.label)
                .padding(.init(top: 5, leading: 48, bottom: 5, trailing: 15))
                .background(.white)
                .clipShape(Capsule())
//        }
    }
    
}


struct GamificationDashboardProfileItemsView_Preview: View {
    
    init() {
        FontRegistrar.registerAllFonts()
    }
    
    var body: some View {
        ZStack {
            GamificationDashboardBackgroundView()
                .blur(radius: 3)
            GamificationDashboardProfileItemsView()
        }
    }
}

#Preview {
    GamificationDashboardProfileItemsView_Preview()
}
