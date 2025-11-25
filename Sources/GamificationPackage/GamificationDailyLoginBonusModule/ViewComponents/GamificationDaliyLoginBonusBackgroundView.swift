//
//  GamificationDaliyLoginBonusBackgroundView.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 25/11/25.
//

import SwiftUI

struct GamificationDaliyLoginBonusBackgroundView: View {
    
    var body: some View {
        
        gamificationDailyLoginBackgroundImage
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    
    private var gamificationDailyLoginBackgroundImage: some View {
        SwiftUIUtility.BackgroundImageView(
            imageName: "gm_daily_login_bonus_bg",
            contentMode: .fill
        )
    }
}

#Preview {
    GamificationDaliyLoginBonusBackgroundView()
}
