//
//  Custom.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 03/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//


import SwiftUI
import CoreText

internal extension Font {
    enum Custom: String, CaseIterable {
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
        
        // Colombo
        case colomboRegular = "PostNoBillsColombo-Regular"
        case colomboBold = "PostNoBillsColombo-Bold"
        case colomboMedium = "PostNoBillsColombo-Medium"
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


internal enum FontRegistrar {
    static func registerAllFonts() {
        Font.Custom.allCases.forEach { fontCase in
            register(fontName: fontCase.rawValue)
        }
    }

    private static func register(fontName: String) {
        let bundle = Bundle.module

        let url = bundle.url(forResource: fontName, withExtension: "ttf")
            ?? bundle.url(forResource: fontName, withExtension: "otf")

        guard let url else {
            print("⚠️ Font not found: \(fontName)")
            return
        }

        guard let dataProvider = CGDataProvider(url: url as CFURL),
              let font = CGFont(dataProvider)
        else {
            print("⚠️ Unable to load font data: \(fontName)")
            return
        }

        CTFontManagerRegisterGraphicsFont(font, nil)
    }
}
