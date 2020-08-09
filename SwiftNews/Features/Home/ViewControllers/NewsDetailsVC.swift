//
//  NewsDetailsVCViewController.swift
//  SwiftNews
//
//  Created by Uday Patial on 2020-08-09.
//  Copyright © 2020 Uday Patial. All rights reserved.
//

import UIKit

class NewsDetailsVC: UIViewController {

    let newsArticle: NewsArticle

    private lazy var newsDetailsViewModel: NewsDetailsViewModel = {
        let builder = NewsDetailsViewModel(newsArticle: newsArticle)
        return builder
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView.appThemedTableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100.0
        tableView.dataSource = newsDetailsViewModel
        return tableView
    }()

    init(newsArticle: NewsArticle) {
        self.newsArticle = newsArticle
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bgLight

        view.addSubview(tableView)
        NewsDetailRow.registerAllCells(in: tableView)

        constrainViews()

        newsDetailsViewModel.updateSections(newsArticle: newsArticle)
        tableView.reloadData()
    }

    private func constrainViews() {
        tableView.constrainEdgesHorizontally(to: view)
        tableView.constrainEdgesVertically(to: view)
    }

}
