//
//  Custom.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 03/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//


import SwiftUI

internal extension Font {
    enum Custom: String {
        // MARK: - Quantico
        case quanticoRegular = "Quantico-Regular"
        case quanticoBold = "Quantico-Bold"

        // MARK: - Roboto
        case robotoRegular = "Roboto-Regular"
        case robotoMedium = "Roboto-Medium"
        case robotoBold = "Roboto-Bold"
        case robotoBlack = "Roboto-Black"

        // MARK: - Poppins
        case poppinsRegular = "Poppins-Regular"
        case poppinsMedium = "Poppins-Medium"
        case poppinsSemiBold = "Poppins-SemiBold"
        case poppinsBold = "Poppins-Bold"
    }

    /// Creates a custom font with optional weight.
    static func custom(_ font: Custom, size: CGFloat, weight: Font.Weight? = nil) -> Font {
        if let weight = weight {
            return .custom(font.rawValue, size: size).weight(weight)
        } else {
            return .custom(font.rawValue, size: size)
        }
    }
}


internal extension View {
    /// Applies a custom app font with optional weight.
    func appFont(_ font: Font.Custom, size: CGFloat, weight: Font.Weight? = nil) -> some View {
        self.font(.custom(font.rawValue, size: size).weight(weight ?? .regular))
    }
}
