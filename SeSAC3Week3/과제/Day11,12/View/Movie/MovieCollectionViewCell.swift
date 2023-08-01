//
//  MovieCollectionViewCell.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/07/31.
//

import UIKit

final class MovieCollectionViewCell: UICollectionViewCell {
    static let identifier = "MovieCollectionViewCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!

    func configureCell(movie: Movie) {
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        contentView.backgroundColor = UIColor.random
        titleLabel.text = movie.title
        rateLabel.text = "\(movie.rate)"
        bookImageView.image = UIImage(named: "\(movie.title)")
    }

}

extension UIButton {
    var toggle: Void {
        isSelected = !isSelected
    }
}
