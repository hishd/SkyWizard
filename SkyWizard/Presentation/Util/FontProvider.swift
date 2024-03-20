//
//  FontProvider.swift
//  SkyWizard
//
//  Created by Hishara Dilshan on 2023-10-19.
//

import UIKit


class FontProvider {
    enum CustomFonts: String {
        case black = "Montserrat-Black"
        case bold = "Montserrat-Bold"
        case light = "Montserrat-Light"
        case medium = "Montserrat-Medium"
        case regular = "Montserrat-Regular"
        case semiBold = "Montserrat-SemiBold"
    }
    
    public static let shared = FontProvider()
    
    private init() {}
    
    public func getFont(typeFace: CustomFonts = .regular, fontSize: CGFloat = 10.0) -> UIFont {
        UIFont(name: typeFace.rawValue, size: fontSize) ?? .systemFont(ofSize: fontSize)
    }
}
