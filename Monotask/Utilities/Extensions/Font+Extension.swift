//
//  Font+Extension.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 14/08/24.
//

import SwiftUI

public enum Oswald: String {
    case extraLight = "Oswald-ExtraLight"
    case light = "Oswald-Light"
    case regular = "Oswald-Regular"
    case medium = "Oswald-Medium"
    case semiBold = "Oswald-SemiBold"
    case bold = "Oswald-Bold"
}

extension Font {
    static func oswald(_ font: Oswald, size: CGFloat) -> Font {
        return .custom(font.rawValue, size: size)
    }
    
    static var oswaldLargeTitle: Font = {
        return oswald(.medium, size: 34)
    }()
    
    static var oswaldLargeEmphasized: Font = {
        return oswald(.semiBold, size: 34)
    }()
    
    static var oswaldTitle1: Font = {
        return oswald(.regular, size: 28)
    }()
    
    static var oswaldTitle2: Font = {
        return oswald(.regular, size: 22)
    }()
    
    static var oswaldTitle3: Font = {
        return oswald(.regular, size: 20)
    }()
    
    static var oswaldHeadline: Font = {
        return oswald(.semiBold, size: 17)
    }()
    
    static var oswaldBody: Font = {
        return oswald(.regular, size: 17)
    }()
    
    static var oswaldCallout: Font = {
        return oswald(.regular, size: 16)
    }()
    
    static var oswaldSubhead: Font = {
        return oswald(.regular, size: 15)
    }()
    
    static var oswaldFootnote: Font = {
        return oswald(.regular, size: 13)
    }()
    
    static var oswaldCaption1: Font = {
        return oswald(.regular, size: 12)
    }()
    
    static var oswaldCaption2: Font = {
        return oswald(.regular, size: 11)
    }()
}
