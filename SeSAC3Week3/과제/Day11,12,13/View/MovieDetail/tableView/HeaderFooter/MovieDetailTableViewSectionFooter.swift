//
//  MovieDetailTableViewSectionFooter.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/08/01.
//

import UIKit

final class MovieDetailTableViewSectionFooter: UITableViewHeaderFooterView {
    static let identifier = "MovieDetailTableViewSectionFooter"

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        configureHierarchy()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension MovieDetailTableViewSectionFooter {

    func configureContentView() {
        contentView.backgroundColor = .secondarySystemBackground
    }

    func configureHierarchy() {
        configureContentView()
    }

}
