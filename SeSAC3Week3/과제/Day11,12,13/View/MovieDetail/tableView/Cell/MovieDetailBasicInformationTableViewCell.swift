//
//  MovieDetailBasicInformationTableViewCell.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/08/01.
//

import UIKit

final class MovieDetailBasicInformationTableViewCell: UITableViewCell {
    static let identifier = "MovieDetailBasicInformationTableViewCell"

    @IBOutlet weak var basicInformationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        configureHierarchy()
    }

    func configureCell(movie: Movie) {
        basicInformationLabel.text = "개봉일: \(movie.releaseDate) | 상영시간: \(movie.runtime)분 | 평점: \(movie.rate)점"
    }
    
}

private extension MovieDetailBasicInformationTableViewCell {

    func configureCell() {
        backgroundColor = .clear
    }

    func configureContentView() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        contentView.layer.masksToBounds = true
    }

    func configureHierarchy() {
        configureCell()
        configureContentView()
    }

}
