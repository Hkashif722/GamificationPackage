//
//  CardStackingDefaultButtonView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 13/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

// MARK: - Default button type (must be a TYPE, not a function)
struct CardStackingDefaultButtonView: View {
    let system: String
    var body: some View {
        Circle()
            .fill(Color.black.opacity(0.20))
            .frame(width: 50, height: 50)
            .overlay(Image(systemName: system).foregroundColor(.white))
            .shadow(color: .black.opacity(0.25), radius: 3, x: 0, y: 2)
    }
}

