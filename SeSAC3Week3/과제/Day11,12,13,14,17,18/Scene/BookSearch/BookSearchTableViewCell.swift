//
//  BookSearchTableViewCell.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/08/10.
//

import Kingfisher
import UIKit

final class BookSearchTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(book: Book) {
        thumbnailImageView.kf.setImage(with: book.thumbnailURL)
        titleLabel.text = book.title
        authorsLabel.text = book.authorsArrange
        priceLabel.attributedText = book.price
    }

}
