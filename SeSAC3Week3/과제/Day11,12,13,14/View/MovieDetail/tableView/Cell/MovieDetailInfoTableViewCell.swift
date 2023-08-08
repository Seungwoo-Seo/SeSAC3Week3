//
//  MovieDetailInfoTableViewCell.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/08/03.
//

import UIKit

final class MovieDetailInfoTableViewCell: UITableViewCell {
    static let identifier = "MovieDetailInfoTableViewCell"

    let placeholderText = "내용을 입력해주세요"

    @IBOutlet weak var basicInfoLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var memoTextView: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureHierarchy()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        memoTextView.resignFirstResponder()
    }

    func configure(movie: Movie) {
        basicInfoLabel.text = movie.basicInfo
        overviewLabel.text = movie.overview
    }

}

extension MovieDetailInfoTableViewCell: UITextViewDelegate {

    // 편집이 시작될 때(커서가 시작될 때)
    // 플레이스 홀더와 텍스트뷰 글자가 같다면 clear, color
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderText {
            textView.text = nil
            textView.textColor = .black
        }
    }

    // 편집이 끝날 때(커서가 없어지는 순간)
    // 사용자가 아무 글자도 안 썼으면 플레이스 홀더 글자 보이게 설정
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholderText
            textView.textColor = .lightGray
        }
    }

}

private extension MovieDetailInfoTableViewCell {

    func configureCell() {
        backgroundColor = UIColor(
            red: 40/255,
            green: 43/255,
            blue: 56/255,
            alpha: 1.0
        )
    }

    func configureContentView() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 12
        contentView.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        contentView.layer.masksToBounds = true
    }

    func configureMemoTextView() {
        memoTextView.delegate = self
    }

    func configureHierarchy() {
        configureCell()
        configureContentView()
        configureMemoTextView()
    }

}
