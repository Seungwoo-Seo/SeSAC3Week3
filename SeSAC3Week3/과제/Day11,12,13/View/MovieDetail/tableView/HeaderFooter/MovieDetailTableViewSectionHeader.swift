//
//  MovieDetailTableViewSectionHeader.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/08/01.
//

import UIKit

final class MovieDetailTableViewSectionHeader: UITableViewHeaderFooterView {
    static let identifier = "MovieDetailTableViewSectionHeader"

    lazy var titleLabel: UILabel = {
        let label = UILabel()

        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        configureHierarchy()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureHeader(title: String?) {
        titleLabel.text = title
    }

}

private extension MovieDetailTableViewSectionHeader {

    func configureContentView() {
        contentView.backgroundColor = .systemBackground
    }

    func configureTitleLabel() {
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.tintColor = .black
    }

    func configureHierarchy() {
        contentView.addSubview(titleLabel)

        configureContentView()
        configureTitleLabel()

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(
            equalTo: contentView.topAnchor,
            constant: 10.0
        ).isActive = true
        titleLabel.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor,
            constant: 16.0
        ).isActive = true
        titleLabel.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -16.0
        ).isActive = true
        titleLabel.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor,
            constant: -10.0
        ).isActive = true
    }

}
