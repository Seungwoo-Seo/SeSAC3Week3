//
//  ImageCollectionViewCell.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/08/02.
//

import UIKit

final class ImageCollectionViewCell: UICollectionViewCell {
    static let identifier = "ImageCollectionViewCell"

    @IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureHierarhcy()
    }

    func configure(movie: Movie) {
        imageView.image = UIImage(named: movie.title)
    }

}

private extension ImageCollectionViewCell {

    func configureImageView() {
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 8
    }

    func configureHierarhcy() {
        configureImageView()
    }

}
