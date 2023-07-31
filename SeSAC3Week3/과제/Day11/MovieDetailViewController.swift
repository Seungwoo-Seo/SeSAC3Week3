//
//  MovieDetailViewController.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/07/31.
//

import UIKit

final class MovieDetailViewController: UIViewController {

    var movieTitle: String?

    @IBOutlet weak var boardLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
    }

}

private extension MovieDetailViewController {

    func configureNavigationBar() {
        navigationItem.title = movieTitle
    }

    func configureBoardLabel() {
        boardLabel.text = "상세 화면"
    }

    func configureHierarchy() {
        configureNavigationBar()
        configureBoardLabel()
    }

}
