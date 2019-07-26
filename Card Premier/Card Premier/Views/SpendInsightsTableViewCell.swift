//
//  SpendInsightsTableViewCell.swift
//  Card Premier
//
//  Created by Chinny Ponnoose on 7/24/19.
//  Copyright © 2019 Chinny. All rights reserved.
//

import UIKit

class SpendInsightsTableViewCell: UITableViewCell {

    @IBOutlet weak var spendInsightsView: SpendView!
    @IBOutlet weak var monthLabel: UILabel!

    @IBOutlet weak var usualSpendLabel: UILabel!
    @IBOutlet weak var currentSpendingLabel: UILabel!
    @IBOutlet weak var pendingLabel: UILabel!
    @IBOutlet weak var limitLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func updateCell(with spendDetails: SpendDetails) {

        layer.cornerRadius = 20.0
        monthLabel.text = spendDetails.month
        currentSpendingLabel?.text = "$ \(spendDetails.currentSpending)"
        pendingLabel?.text = "🔵 $\(spendDetails.pending) Pending"
        limitLabel?.text = "⚪ $\(spendDetails.limit) Limit"
        usualSpendLabel?.text = "Usual. $\(spendDetails.usualSpending)"

        let spendPecentage = (spendDetails.currentSpending / spendDetails.limit) * 100.0
        let pendingSpendPecentage = ((spendDetails.currentSpending + spendDetails.pending) / spendDetails.limit) * 100.0
       spendInsightsView.spendPercentage = spendPecentage
       spendInsightsView.pendingSpendPercentage = pendingSpendPecentage
        
    }

    @IBAction func insightButtonPressed(_ sender: Any) {
    }
    @IBAction func optionSelected(_ sender: Any) {
    }

}
