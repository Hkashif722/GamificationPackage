//
//  GamificationDashboardProfileItemsView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 03/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//



///---------------------------------` Profile Info Items`-------------------------------------------------
///-------------------------------------------------
///-------------------------------------------------


import SwiftUI

struct GamificationDashboardProfileItemsView: View {
    
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
        Image("managerEvalActiveIcon")
            .resizable()
            .frame(width: 80, height: 80)
            .clipShape(Circle())
            .overlay(Circle().stroke(.white, lineWidth: 5))
            .zIndex(2)
    }
    
    
    private var profileInfoView: some View {
        VStack(alignment: .leading, spacing: 0) {
            welcomeTextMessageView
            profileNameView
            houseNameTextView
        }
        .offset(x: -50, y: -3)
        .zIndex(1)
    }
    
    private var welcomeTextMessageView: some View {
        Text("WELCOME")
            .appFont(.poppinsRegular, size: 12)
            .foregroundStyle(Color(.label))
            .padding(.init(top: 5, leading: 45, bottom: 5, trailing: 15))
            .background(.white)
            .clipShape(Capsule())
           
            
    }
    
    private var profileNameView: some View {
        Text("Ava Wilson")
            .appFont(.poppinsBold, size: 12, weight: .bold)
            .foregroundStyle(.white)
            .padding(.init(top: 8, leading: 55, bottom: 8, trailing: 25))
            .background(BrandingColorStyle.primaryColor)
            .clipShape(Capsule())
    }
    
    
    private var houseNameTextView: some View {
        Text("Red House")
            .appFont(.poppinsRegular, size: 12)
            .foregroundStyle(Color(.label))
            .padding(.init(top: 5, leading: 45, bottom: 5, trailing: 15))
            .background(.white)
            .clipShape(Capsule())
    }
    
}

#Preview {
    GamificationDashboardProfileItemsView()
}
