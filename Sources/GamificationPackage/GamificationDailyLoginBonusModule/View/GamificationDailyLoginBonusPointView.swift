//
//  GamificationDailyLoginBonusPointView.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 25/11/25.
//

import SwiftUI

struct GamificationDailyLoginBonusPointView: View {
    
    let router: Router
    
    init(router: Router) {
        self.router = router
        FontRegistrar.registerAllFonts()
    }
    
    var body: some View {
        ZStack {
            bonusBackgroundView
                .overlay(alignment: .topTrailing) {
                    closeButtonView
                }
        }
    }
    
    
    private var bonusBackgroundView: some View {
        ZStack {
            GamificationDaliyLoginBonusBackgroundView()
            cardInfoView
        }
    }
    
    private var cardInfoView: some View {
        VStack {
            dailyLoginTextView
            bonusTextView
        }
    }
    private var dailyLoginTextView: some View {
        Text("DAILY LOGIN")
            .appFont(.poppinsBold, size: 40, weight: .bold)
            .foregroundStyle(.white)
    }
    
    private var bonusTextView: some View {
        Text("BONUS")
            .appFont(.poppinsBold, size: 40, weight: .bold)
            .foregroundStyle(Color(hex:"#ffc200"))
    }
    
    private var bottomInfoVew: some View {
        Text("Login daily in a row to win extra points")
            .appFont(.poppinsSemiBold, size: 14, weight: .semibold)
            .foregroundStyle(.white)
        
    }
    
    private var closeButtonView: some View {
        Button(action: router.dismissPopup) {
            Image("ic_gm_close", bundle: .module)
                .frame(width: 45, height: 45)
        }
        .padding()
    }
}

#Preview {
    GamificationDailyLoginBonusPointView(router: Router())
}
