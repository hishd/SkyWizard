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
    
    private var customFont: UIFont?
    public let shared = FontProvider()
    
    private init(typeFace: CustomFonts = .regular, fontSize: CGFloat = 10.0) {
        customFont = UIFont(name: CustomFonts.regular.rawValue, size: fontSize)
    }
    
    public func getFont(typeFace: CustomFonts = .regular, fontSize: CGFloat = 10.0) -> UIFont {
        UIFont(name: CustomFonts.regular.rawValue, size: fontSize) ?? .systemFont(ofSize: fontSize)
    }
}
