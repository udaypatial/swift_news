//
//  NewsListViewController.swift
//  SwiftNews
//
//  Created by Uday Patial on 2020-08-09.
//  Copyright © 2020 Uday Patial. All rights reserved.
//

import UIKit

protocol NewsListViewControllerDelegate: class {
    func newsListViewController(_ controller: NewsListViewController,
                                    didTapNewsItemFor news: NewsArticle)
}

class NewsListViewController: UIViewController {
    
    weak var delegate: NewsListViewControllerDelegate?
    
    private lazy var tableListViewModel: NewsListViewModel = {
        let builder = NewsListViewModel(apiDataManager: APIDataManager())
        builder.delegate = self
        return builder
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.appThemedTableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100.0
        tableView.dataSource = tableListViewModel
        tableView.delegate = tableListViewModel
        return tableView
    }()
    
    private lazy var errorView = ErrorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bgLight
        
        NewsRow.registerAllCells(in: tableView)
        
        view.addSubview(tableView)
        constrainViews()
        
        fetchNewsArticles()
    }
    
    private func fetchNewsArticles() {
        Spinner.show(in: view)
        errorView.dismiss()
        tableListViewModel.fetchNewsArticles(onSuccess: { [weak self] newsArticles in
            Spinner.hide(in: self?.view)
            newsArticles.isEmpty
                ? self?.showEmptyView(action: { [weak self] in self?.fetchNewsArticles() })
                : self?.tableView.reloadData()
        }) { [weak self] err in
            Spinner.hide(in: self?.view)
            self?.showErrorView(withError: err, action: { [weak self] in
                self?.fetchNewsArticles()
            })
        }
    }
    
    private func constrainViews() {
        tableView.constrainEdgesHorizontally(to: view)
        tableView.constrainEdgesVertically(to: view)
    }
    
    private func showErrorView(withError error: NetworkError, action: (() -> Void)?) {
        errorView.showErrorView(in: self,
                                title: Strings.somethingWentWrong.rawValue,
                                subtitle: Strings.pleaseTryAgainLater.rawValue,
                                buttonTitle: Strings.tryAgain.rawValue,
                                buttonAction: action)
    }
    
    private func showEmptyView(action: (() -> Void)?) {
        errorView.showErrorView(in: self,
                                title: Strings.noNewsFound.rawValue,
                                subtitle: Strings.pleaseTryAgainLater.rawValue,
                                buttonTitle: Strings.tryAgain.rawValue,
                                buttonAction: action)
    }
    
}

extension NewsListViewController: NewsListViewModelDelegate {
    
    func didTapArticle(_ newsArticle: NewsArticle) {
        self.delegate?.newsListViewController(self, didTapNewsItemFor: newsArticle)
    }
}
