//
//  Color+Extension.swift
//  Katex Entertainment
//
//  Created by MD Abir Hasan Zoha on 3/3/22.
//

import Foundation
import UIKit
import SwiftUI

extension UIColor {
    static var background: UIColor {
        UIColor(named: "background")!
    }

    static var accent: UIColor {
        UIColor(named: "AccentColor")!
    }
}

extension Color {
    static var background: Color {
        Color(.background)
    }

    static var accent: Color {
        Color(.accent)
    }

    static var cardBackground: Color {
        Color("cardBackground")
    }

    static var highlight: Color {
        Color("highlight")
    }

    static var label: Color {
        Color(UIColor.label)
    }
}

extension UIImage {
    static var home: UIImage {
        UIImage(named: "home")!
    }

    static var explore: UIImage {
        UIImage(named: "explore")!
    }

    static var favorite: UIImage {
        UIImage(named: "favorite")!
    }

    static var profile: UIImage {
        UIImage(named: "profile")!
    }
}
