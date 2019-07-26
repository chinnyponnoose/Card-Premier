//
//  TransactionTableViewCell.swift
//  Card Premier
//
//  Created by Chinny Ponnoose on 7/24/19.
//  Copyright © 2019 Chinny. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {

    @IBOutlet weak var sellerTitleLabel: UILabel!
    @IBOutlet weak var sellerImageView: UIImageView!
    @IBOutlet weak var transactionDetailsLabel: UILabel!
    @IBOutlet weak var transactionAmountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateCell(with transaction: Transaction) {
        sellerTitleLabel?.text = transaction.name
        sellerImageView?.image = UIImage(named: transaction.image)
        transactionDetailsLabel?.text = "\(transaction.date) - \(transaction.cardUsed)"
        transactionAmountLabel?.text = "$ \(transaction.amount)"
    }

}
