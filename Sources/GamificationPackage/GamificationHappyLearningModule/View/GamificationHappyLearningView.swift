//
//  GamificationHappyLearningView.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 17/11/25.
//

import SwiftUI

struct GamificationHappyLearningView: View {
    
    let router: Router
    
   @StateObject private var happyLearningViewModel: HappyLearningViewModel
    
    init(router: Router) {
        self.router = router
        _happyLearningViewModel = StateObject(
            wrappedValue: HappyLearningViewModel(router: router)
        )
    }
    
    var body: some View {
       
        ZStack(alignment:.topTrailing) {
            
            closeButtonView
            
            ZStack(alignment: .top) {
        
                ZStack {
                    HappyLearningBackgroundView()
                    HappyLearningTimerInfoView(
                        remainingTime: $happyLearningViewModel.remainingSeconds
                    )
                }
                .center()
                .ignoresSafeArea()
            }
        }
        .task {
            await happyLearningViewModel.getHappyLearningHours()
        }
    }
    

    private var closeButtonView: some View {
        Button(action: router.dismissPopup) {
            Image("ic_gm_close", bundle: .module)
                .frame(width: 45, height: 45)
        }
        .padding()
    }
    
}


struct GamificationHappyLearningView_Preview: View {
    
    init() {
        FontRegistrar.registerAllFonts()
    }
    
    var body: some View {
        ZStack {
            GamificationDashboardBackgroundView()
                .blur(radius: 4)
            GamificationHappyLearningView(router: Router())
        }
    }
}

#Preview {
    GamificationHappyLearningView_Preview()
}
