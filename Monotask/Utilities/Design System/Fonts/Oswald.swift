//
//  Oswald.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 16/08/24.
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
}

extension UIFont {
    static func oswald(_ font: Oswald, size: CGFloat) -> UIFont {
        return .init(name: font.rawValue, size: size)!
    }
}
