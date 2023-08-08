//
//  TestViewController.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/08/03.
//

import UIKit

final class TestViewController: UIViewController {

    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!


    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
    }

}

private extension TestViewController {

    func configureFirstView() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapFirstView)
        )
        firstView.addGestureRecognizer(tap)
        firstView.tag = 0
    }

    @objc
    func didTapFirstView() {
//        if sender.tag == 0 {
//            print("tapped 0")
//        } else if sender.tag == 1 {
//            print("tapped 1")
//        }
    }

    func configureSecondView() {
        secondView.tag = 1
    }

    func configureHierarchy() {
        configureFirstView()
        configureSecondView()
    }

}
