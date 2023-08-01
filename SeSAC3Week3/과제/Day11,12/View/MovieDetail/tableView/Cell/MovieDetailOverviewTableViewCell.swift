//
//  MovieDetailOverviewTableViewCell.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/08/01.
//

import UIKit

final class MovieDetailOverviewTableViewCell: UITableViewCell {
    static let identifier = "MovieDetailOverviewTableViewCell"

    @IBOutlet weak var overviewLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        overviewLabel.numberOfLines = 0
    }

    func configureCell(movie: Movie) {
        overviewLabel.text = movie.overview
    }

}
