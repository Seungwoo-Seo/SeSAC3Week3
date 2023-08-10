//
//  MovieDetailTableViewHeader.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/08/01.
//

import Kingfisher
import UIKit

protocol BookDetailTableViewHeaderDelegate: AnyObject {
    func cancelTheLike(movie: Movie?)
    func didTapBackButton()
}

final class BookDetailTableViewHeader: UIView {

    var book: Book?
    weak var homeDelegate: BookDetailTableViewHeaderDelegate?
    weak var detailDelegate: BookDetailTableViewHeaderDelegate?

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var backButton: UIButton!

    // MARK: 지금은 layoutSubViews를 안쓰고 다른 방법을 찾자 -> 오히려 버튼의 상태를 변경하는 등 응용도 가능할듯
    func configure(isHidden: Bool = true) {
        configureHierarchy()
        guard let book = book else {return}
        thumbnailImageView.kf.setImage(
            with: book.thumbnailURL
        )
        titleLabel.text = book.title
        authorsLabel.text = book.authorsArrange
        priceLabel.attributedText = book.price
        backButton.isHidden = isHidden
    }

    @IBAction func didTapBackButton(_ sender: UIButton) {
        detailDelegate?.didTapBackButton()
    }

}

private extension BookDetailTableViewHeader {

    func configureMovieImageView() {
        thumbnailImageView.layer.cornerRadius = 8
    }

    func configureLikeButton() {
        guard let book = book else {return}

//        if book.like {
//            likeButton.isSelected = true
//        } else {
//            likeButton.isSelected = false
//        }
//        likeButton.addTarget(
//            self,
//            action: #selector(didTapLikeButton),
//            for: .touchUpInside
//        )
    }

    func configureHierarchy() {
        configureMovieImageView()
        configureLikeButton()
    }

}

private extension BookDetailTableViewHeader {

    @objc
    func didTapLikeButton(_ sender: UIButton) {
        sender.toggle
//        homeDelegate?.cancelTheLike(movie: movie)
    }

}
