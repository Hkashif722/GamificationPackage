//
//  HappyLearningBackgroundView.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 17/11/25.
//

import SwiftUI

struct HappyLearningBackgroundView: View {
    
    var body: some View {
        ZStack(alignment: .top) {
            happyLearningTitleView
            ZStack(alignment: .bottom) {
                ringBackground
                controllerView
            }
        }
        
    }
    
    
    private var ringBackground: some View {
        Image(.ringBgGmHappyLearing)
            .resizable()
            .frame(width: 350, height: 350)
            .scaleEffect(0.9)
    }
    
    private var controllerView: some View {
        Image(.icGmController)
            .frame(width: 120, height: 120)
            .scaleEffect(0.9)
    }
    
    private var happyLearningTitleView: some View {
        Text("HAPPY LEARNING HOURS")
            .appFont(.quanticoBold, size: 24, weight: .bold)
            .foregroundStyle(.white)
            .padding(.top, 8)
        
    }
}

#Preview {
    ZStack {
        GamificationDashboardBackgroundView()
            .blur(radius: 4)
        
        HappyLearningBackgroundView()
    }
}
