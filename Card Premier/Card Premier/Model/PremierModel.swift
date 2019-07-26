//
//  PremierModel.swift
//  Card Premier
//
//  Created by Chinny Ponnoose on 7/23/19.
//  Copyright © 2019 Chinny. All rights reserved.
//

import UIKit

struct StaticData: Decodable {
    let data: PremierModel
}

struct PremierModel: Decodable {
    let spendDetails: SpendDetails
    let cards: [Card]
    let recentTransactions: [Transaction]
    let creditScore: CreditScore
}

struct SpendDetails: Decodable {
    let month: String
    let limit: Double
    let pending: Double
    let currentSpending: Double
    let usualSpending: Double
}

struct Card: Decodable {
    let namePrinted: String
    let type: String
    let image: String
    let endDigit: String
}

struct Transaction: Decodable {
    let amount: Double
    let name: String
    let date: String //TODO: Make it Date
    let cardUsed: String
    let image: String
}

struct CreditScore: Decodable {
    let lastChecked: String //TODO: Make it Date
}
