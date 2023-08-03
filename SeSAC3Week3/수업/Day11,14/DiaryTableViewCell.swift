//
//  DiaryTableViewCell.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/07/31.
//

import UIKit

final class DiaryTableViewCell: UITableViewCell {
    static let identifier = "DiaryTableViewCell"

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var testLabel: UILabel!

    func configureCell(row: String) {
        testLabel.text = row
    }

}
