//
//  HappyLearningTimerInfoView.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 17/11/25.
//

import SwiftUI
import Combine

struct HappyLearningTimerInfoView: View {
    
    @Binding private var remainingTime: Int
    @State private var timerCancellable: AnyCancellable?
    
    init(remainingTime: Binding<Int>) {
        _remainingTime = remainingTime
    }
    
    var body: some View {
        VStack(spacing: 0) {
            timerInfoView
            bottomInfoView
        }
        .offset(y: -25)
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
    }
    
    private func startTimer() {
        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if remainingTime > 0 {
                    remainingTime -= 1
                }
            }
    }
    
    private func stopTimer() {
        timerCancellable?.cancel()
        timerCancellable = nil
    }
    
    private var timerInfoView: some View {
        Text(formattedTime(remainingTime))
            .appFont(.colomboRegular, size: 35, weight: .regular)
            .foregroundStyle(Color(hex:"#0f2d94"))
    }
    
    private func formattedTime(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private var bottomInfoView: some View {
        VStack(spacing: 8) {
            remainingTextView
            extraPointView
        }
    }
    
    private var remainingTextView: some View {
        Text("Remaining...")
            .appFont(.poppinsRegular, size: 24)
            .foregroundStyle(Color(hex:"#0f2d94"))
    }
    
    private var extraPointView: some View {
        Text("You can earn extra Points")
            .appFont(.poppinsRegular, size: 14)
            .foregroundStyle(Color(hex:"#0f2d94"))
    }
}

struct HappyLearningTimerInfoView_Preview: View {
    init() {
        FontRegistrar.registerAllFonts()
    }
    var body: some View {
        HappyLearningTimerInfoView(remainingTime: .constant(1))
    }
}

#Preview {
    HappyLearningTimerInfoView_Preview()
}
