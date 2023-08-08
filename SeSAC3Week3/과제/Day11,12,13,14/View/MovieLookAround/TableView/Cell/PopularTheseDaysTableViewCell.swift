//
//  PopularTheseDaysTableViewCell.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/08/02.
//

import UIKit

final class PopularTheseDaysTableViewCell: UITableViewCell {
    static let identifier = "PopularTheseDaysTableViewCell"

    @IBOutlet weak var thumnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var basicInformationLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureHierarchy()
    }

    func configure(movie: Movie) {
        thumnailImageView.image = UIImage(named: movie.title)
        titleLabel.text = movie.title
        basicInformationLabel.text = movie.basicInfo
    }

}

private extension PopularTheseDaysTableViewCell {

    func configureThumnailImageView() {
        thumnailImageView.layer.cornerRadius = 8
    }

    func configureHierarchy() {
        configureThumnailImageView()
    }

}
