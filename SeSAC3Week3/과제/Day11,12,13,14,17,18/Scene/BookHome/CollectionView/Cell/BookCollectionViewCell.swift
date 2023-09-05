//
//  BookCollectionViewCell.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/08/10.
//

import Kingfisher
import UIKit

final class BookCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var originalPriceLabel: UILabel!
    @IBOutlet weak var salePriceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
    }

    func configure(book: RMBook) {
        contentView.backgroundColor = UIColor(
            red: book.randomRGB.r,
            green: book.randomRGB.g,
            blue: book.randomRGB.b,
            alpha: 1.0
        )
        thumbnailImageView.kf.setImage(
            with: book.thumbnailURL
        )
        titleLabel.text = book.title
        originalPriceLabel.attributedText = book.originalPrice.originalPriceStyle(
            fontSize: 15
        )

        salePriceLabel.attributedText = book.salePrice.salePriceStyle(
            fontSize: 17
        )
    }

}
