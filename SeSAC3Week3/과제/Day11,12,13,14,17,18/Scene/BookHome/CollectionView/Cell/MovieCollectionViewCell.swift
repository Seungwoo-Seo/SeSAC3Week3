//
//  MovieCollectionViewCell.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/07/31.
//

import Kingfisher
import UIKit

final class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!

    func configureCell(book: Book) {
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        contentView.backgroundColor = UIColor.random
        titleLabel.text = book.title
//        rateLabel.text = "\(book.rate)"
        bookImageView.kf.setImage(with: book.thumbnailURL)
    }

}

extension UIButton {
    var toggle: Void {
        isSelected = !isSelected
    }
}
