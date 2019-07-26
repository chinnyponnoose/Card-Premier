//
//  PremierViewModel.swift
//  Card Premier
//
//  Created by Chinny Ponnoose on 7/23/19.
//  Copyright © 2019 Chinny. All rights reserved.
//

import UIKit

enum PremierViewModelItemType {
    case spendDetail
    case card
    case transaction
    case creditScore
}

protocol PremierViewModelItem {
    
    var type: PremierViewModelItemType { get }
    var rowCount: Int { get }
    var sectionTitle: String? { get }
    
}

extension PremierViewModelItem {

    var sectionTitle: String? {
        return nil
    }

    var rowCount: Int {
        return 0
    }

}

class PremierViewModel: NSObject {
    
    var items = [PremierViewModelItem]()
    
    override init() {
        super.init()
        guard let data = DataProvider.staticData() else { return }

        let staticData = try! JSONDecoder().decode(StaticData.self, from: data)
        let sampleModel = staticData.data

        let spendDetails = PremierViewModelItemSpendDetail(spendInfo: sampleModel.spendDetails)
        items.append(spendDetails)

        let cards = PremierViewModelItemCard(cards: sampleModel.cards)
        items.append(cards)
        
        let transactions = PremierViewModelItemTransaction(transactions: sampleModel.recentTransactions)
        items.append(transactions)
        
        let score = PremierViewModelItemScore(score: sampleModel.creditScore)
        items.append(score)
        
    }
}

class PremierViewModelItemSpendDetail: PremierViewModelItem {
    
    var type: PremierViewModelItemType {
        return .spendDetail
    }
    
    var spendInfo: SpendDetails
    
    init(spendInfo: SpendDetails) {
        self.spendInfo = spendInfo
        
    }
}

class PremierViewModelItemCard: PremierViewModelItem {
    var type: PremierViewModelItemType {
        return .card
    }

    var rowCount: Int {
        return cards.count
    }

    var sectionTitle: String {
        return "Your Cards"
    }

    var cards: [Card]
    
    init(cards: [Card]) {
        self.cards = cards
    }
}

class PremierViewModelItemTransaction: PremierViewModelItem {
    var type: PremierViewModelItemType {
        return .transaction
    }

    var rowCount: Int {
        return transactions.count
    }

    var sectionTitle: String {
        return "Recent Transactions"
    }

    var transactions: [Transaction]
    
    init(transactions: [Transaction]) {
        self.transactions = transactions
    }
}

class PremierViewModelItemScore: PremierViewModelItem {
    var type: PremierViewModelItemType {
        return .creditScore
    }

    var sectionTitle: String {
        return "Credit Scores"
    }

    var score: CreditScore
    
    init(score: CreditScore) {
        self.score = score
    }

    var rowCount: Int {
        return 1
    }
}

//MARK: - Table Cell
extension PremierViewModel {

    func setBottomCorner(of cell: inout UITableViewCell) {
        cell.layer.cornerRadius = 20.0
        cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }

    func sectionHeaderCell(_ tableView: UITableView, with title: String, accessory: UITableViewCell.AccessoryType = .none) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kBasicCell) else { return UITableViewCell() }
        cell.textLabel?.text = title
        cell.textLabel?.textColor = .orange
        cell.textLabel?.font = UIFont(name: "Montserrat", size: 18.0)
        cell.accessoryType = accessory
        cell.layer.cornerRadius = 20.0
        cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return cell
    }

    func cardCell(_ tableView: UITableView, for indexPath: IndexPath , for item: PremierViewModelItem) -> UITableViewCell {

        guard let item = item as? PremierViewModelItemCard, var cell = tableView.dequeueReusableCell(withIdentifier: Constants.kDetailCell) else { return UITableViewCell() }
        if indexPath.row == 0 {
            return sectionHeaderCell(tableView, with: item.sectionTitle)
        } else if indexPath.row == item.rowCount {
            setBottomCorner(of: &cell)
        }
        let card = item.cards[indexPath.row - 1]
        cell.imageView?.image = UIImage(named: card.image)
        cell.textLabel?.text = card.namePrinted
        cell.detailTextLabel?.text = "\(card.type) ending in \(card.endDigit)"
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func transactionCell(_ tableView: UITableView, for indexPath: IndexPath , for item: PremierViewModelItem) -> UITableViewCell {

        guard let item = item as? PremierViewModelItemTransaction,  let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kTransactionCell) as? TransactionTableViewCell else { return UITableViewCell() }
        if indexPath.row == 0 {
            return sectionHeaderCell(tableView, with: item.sectionTitle,
                                     accessory: .disclosureIndicator)
        }
        if indexPath.row == item.rowCount {
            cell.layer.cornerRadius = 20.0
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
        let transaction = item.transactions[indexPath.row - 1]
        cell.updateCell(with: transaction)
        return cell
    }

    func creditScoreCell(_ tableView: UITableView, for indexPath: IndexPath , for item: PremierViewModelItem) -> UITableViewCell {

        guard let item = item as? PremierViewModelItemScore, var cell = tableView.dequeueReusableCell(withIdentifier: Constants.kDetailCell) else { return UITableViewCell() }
        if indexPath.row == 0 {
            return sectionHeaderCell(tableView, with: item.sectionTitle,
                                     accessory: .disclosureIndicator)
        } else if indexPath.row == 1 {
            setBottomCorner(of: &cell)
        }
        cell.textLabel?.text = "Get Your FICO Score"
        cell.detailTextLabel?.text = "Last update \(item.score.lastChecked)"
        cell.imageView?.image = UIImage(named: "Clock")
        return cell
    }

    func spendInsightsCell(_ tableView: UITableView, for item: PremierViewModelItem) -> UITableViewCell {
         guard let item = item as? PremierViewModelItemSpendDetail, let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kSpendInsightsTableViewCell) as? SpendInsightsTableViewCell else { return UITableViewCell() }
        cell.updateCell(with: item.spendInfo)
        return cell

    }


}

//MARK: - UITableViewDataSource
extension PremierViewModel: UITableViewDataSource,UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].rowCount + 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
        switch item.type {
        case .spendDetail:
            return spendInsightsCell(tableView, for: item)
        case .card:
            return cardCell(tableView, for: indexPath, for: item)
        case .transaction:
            return transactionCell(tableView, for: indexPath, for: item)
        case .creditScore:
            return creditScoreCell(tableView, for: indexPath, for: item)

        }
    }

}
