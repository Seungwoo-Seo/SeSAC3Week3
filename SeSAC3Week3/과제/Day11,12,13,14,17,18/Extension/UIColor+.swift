//
//  Extension+UIColor.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/07/31.
//

import UIKit

extension UIColor {
    static var random: UIColor {
        let r: CGFloat = .random(in: 0...1)
        let g: CGFloat = .random(in: 0...1)
        let b: CGFloat = .random(in: 0...1)

        return UIColor(
            red: CGFloat(drand48()),
            green: CGFloat(drand48()),
            blue: CGFloat(drand48()),
            alpha: 1.0
        )
    }
}

extension CGFloat {

    static var randomRGB: (r: CGFloat, g: CGFloat, b: CGFloat) {
        let r: CGFloat = .random(in: 0...1)
        let g: CGFloat = .random(in: 0...1)
        let b: CGFloat = .random(in: 0...1)

        return (r: r, g: g, b: b)
    }

}
