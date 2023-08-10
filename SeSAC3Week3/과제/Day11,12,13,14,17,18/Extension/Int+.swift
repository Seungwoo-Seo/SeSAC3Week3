//
//  NSMutableAttributedString+.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/08/10.
//

import UIKit

extension Int {

    func originalPriceStyle(
        fontSize: CGFloat
    ) -> NSMutableAttributedString {
        let font = UIFont.systemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.lightGray,
            .strikethroughStyle: NSUnderlineStyle.single.rawValue
        ]

        return NSMutableAttributedString(
            string: "\(self)원",
            attributes: attributes
        )
    }

    func salePriceStyle(
        fontSize: CGFloat
    ) -> NSMutableAttributedString {
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.red
        ]

        return NSMutableAttributedString(
            string: "\(self)원",
            attributes: attributes
        )
     }


}
