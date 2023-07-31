//
//  MovieSearchViewController.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/07/31.
//

import UIKit

final class MovieSearchViewController: UIViewController {

    @IBOutlet weak var boardLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
    }

}

private extension MovieSearchViewController {

    func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = "검색 화면"
        let leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(didTapleftBarButtonItem)
        )
        navigationItem.leftBarButtonItem = leftBarButtonItem

    }

    func configureBoardLabel() {
        boardLabel.text = "검색 화면"
    }

    func configureHierarchy() {
        configureNavigationBar()
        configureBoardLabel()
    }

}

private extension MovieSearchViewController {

    @objc
    func didTapleftBarButtonItem(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }

}
