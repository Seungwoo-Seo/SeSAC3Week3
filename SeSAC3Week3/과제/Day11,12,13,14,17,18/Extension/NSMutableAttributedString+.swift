//
//  NSMutableAttributedString+.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/08/10.
//

import UIKit

extension NSMutableAttributedString {

    var priceSeparator: NSMutableAttributedString {
        let font = UIFont.systemFont(ofSize: 13)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.lightGray
        ]

        append(
            NSMutableAttributedString(
                string: " -> ",
                attributes: attributes
            )
        )

        return self
    }

}
