//
//  MovieDetailTableViewHeader.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/08/01.
//

import UIKit

protocol MovieDetailTableViewHeaderDelegate: AnyObject {
    func cancelTheLike(movie: Movie?)
    func didTapBackButton()
}

final class MovieDetailTableViewHeader: UIView {

    var movie: Movie?
    weak var homeDelegate: MovieDetailTableViewHeaderDelegate?
    weak var detailDelegate: MovieDetailTableViewHeaderDelegate?

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var backButton: UIButton!


    // MARK: 지금은 layoutSubViews를 안쓰고 다른 방법을 찾자 -> 오히려 버튼의 상태를 변경하는 등 응용도 가능할듯
    func configure(movie: Movie, isHidden: Bool = true) {
        self.movie = movie
        configureHierarchy()
        movieImageView.image = UIImage(
            named: movie.title
        )
        movieTitle.text = movie.title

        backButton.isHidden = isHidden
    }

    @IBAction func didTapBackButton(_ sender: UIButton) {
        print("들어옴?")
        detailDelegate?.didTapBackButton()
    }

}

private extension MovieDetailTableViewHeader {

    func configureMovieImageView() {
        movieImageView.layer.cornerRadius = 8
    }

    func configureLikeButton() {
        if movie!.like {
            likeButton.isSelected = true
        } else {
            likeButton.isSelected = false
        }
        likeButton.addTarget(
            self,
            action: #selector(didTapLikeButton),
            for: .touchUpInside
        )
    }

    func configureHierarchy() {
        configureMovieImageView()
        configureLikeButton()
    }

}

private extension MovieDetailTableViewHeader {

    @objc
    func didTapLikeButton(_ sender: UIButton) {
        sender.toggle
        homeDelegate?.cancelTheLike(movie: movie)
    }

}
