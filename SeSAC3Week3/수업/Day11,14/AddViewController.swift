//
//  AddViewController.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/07/31.
//

import UIKit

enum TransitionType: String {
    case add = "추가 화면"
    case edit = "수정 화면"
}

final class AddViewController: UIViewController {

    var type: TransitionType = .add
    var contents: String?

    // placeholder
    let placeholderText = "내용을 입력해주세요"

    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setBackgroundColor()

        textView.delegate = self

        title = type.rawValue

        switch type {
        case .add:
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                image: UIImage(systemName: "xmark"),
                style: .plain,
                target: self,
                // 스페셜 리터럴
                action: #selector(didTapLeftBarButtonItem)
            )
            navigationItem.leftBarButtonItem?.tintColor = .black
            textView.text = placeholderText
            textView.textColor = .lightGray

        case .edit:
            guard let contents else {return}
            textView.text = contents
        }

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        view.endEditing(true)
    }

    @objc
    func didTapLeftBarButtonItem(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
//        navigationController?.popViewController(
//            animated: true
//        )
    }

}

extension AddViewController: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        title = "\(textView.text.count)"
    }

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
