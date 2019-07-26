//
//  ViewController.swift
//  Card Premier
//
//  Created by Chinny Ponnoose on 7/23/19.
//  Copyright © 2019 Chinny. All rights reserved.
//

import UIKit

class CardPremierViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    fileprivate let viewModel = PremierViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configueTableView()
    }

    func configueTableView() {
        tableView.delegate = viewModel
        tableView.dataSource = viewModel

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
    }

    func configureNavigationBar() {
        title = "CARD PREMIER"

        navigationController?.navigationBar.barTintColor = .orange
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }

}



