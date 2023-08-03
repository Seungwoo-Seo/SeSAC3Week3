//
//  DetailViewController.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/07/31.
//

import UIKit

final class DetailViewController: UIViewController {

    var contents: String?

    @IBOutlet weak var contentsLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setBackgroundColor()

        contentsLabel.text = contents
    }

    @IBAction func didTapRemoveBarButtonItem(_ sender: UIBarButtonItem) {

        navigationController?.popViewController(animated: true)
    }

}
