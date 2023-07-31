//
//  AddViewController.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/07/31.
//

import UIKit

final class AddViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setBackgroundColor()
        title = "추가 화면"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .plain,
            target: self,
            // 스페셜 리터럴
            action: #selector(didTapLeftBarButtonItem)
        )
        navigationItem.leftBarButtonItem?.tintColor = .black
    }

    @objc
    func didTapLeftBarButtonItem(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
//        navigationController?.popViewController(
//            animated: true
//        )
    }

}
