//
//  NewsListViewModel.swift
//  SwiftNews
//
//  Created by Uday Patial on 2020-08-09.
//  Copyright © 2020 Uday Patial. All rights reserved.
//

import UIKit

enum NewsRow: GLRow {
    case sharedRow(_ sharedRow: SharedRow)
    case newsArticleText(_ newsArticle: NewsArticle)
    case newsArticleWithImage(_ newsArticle: NewsArticle)
    
    func tableViewCell(_ tableView: UITableView) -> UITableViewCell? {
        switch self {
            case .sharedRow(let sharedRow):
                return sharedRow.tableViewCell(tableView)
            case .newsArticleText(let newsArticle):
                if let cell: NewsItemTextCell = tableView.dequeue() {
                    cell.configure(for: newsArticle)
                    cell.selectionStyle = .none
                    return cell
            }
            case .newsArticleWithImage(let newsArticle):
                if let cell: NewsItemImageCell = tableView.dequeue() {
                    cell.configure(for: newsArticle)
                    cell.selectionStyle = .none
                    return cell
            }
        }
        return nil
    }
    
    static func registerAllCells(in tableView: UITableView) {
        SharedRow.registerAllCells(in: tableView)
        tableView.register(NewsItemTextCell.self)
        tableView.register(NewsItemImageCell.self)
    }
}

protocol NewsListViewModelDelegate: class {
    func didTapArticle(_ newsArticle: NewsArticle)
}

class NewsListViewModel: NSObject {
    
    weak var delegate: NewsListViewModelDelegate?
    
    var sections = [[NewsRow]]()
    
    let apiDataManager: APIDataManager
    
    var newsArticles: [NewsArticle]?
    
    //inject APIDataManager for testability
    init(apiDataManager: APIDataManager) {
        self.apiDataManager = apiDataManager
    }
    
    func fetchNewsArticles(onSuccess: @escaping ([ItemData<NewsArticle>]) -> Void,
                           onFailure: @escaping (NetworkError) -> Void) {
        apiDataManager.getNewsArticleList { [weak self] result in
            switch result {
                case .success(let newsArticles):
                    self?.updateSections(newsArticles: newsArticles.data.children)
                    onSuccess(newsArticles.data.children)
                case .failure(let error):
                    onFailure(error)
            }
        }
    }
    
    func updateSections(newsArticles: [ItemData<NewsArticle>]) {
        var newSections = [[NewsRow]]()
        
        newSections.append(newsSection(newsArticles))
        
        sections = newSections
    }
    
    private func newsSection(_ newsArticles: [ItemData<NewsArticle>]) -> [NewsRow] {
        var rows = [NewsRow]()
        for newsArticle in newsArticles {
            if newsArticle.data.thumbnailImage?.isValidURL ?? false {
                rows.append(.newsArticleWithImage(newsArticle.data))
            } else {
                rows.append(.newsArticleText(newsArticle.data))
                rows.append(.sharedRow(.divider))
            }
        }
        return rows
    }
}

extension NewsListViewModel: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = sections[indexPath.section][indexPath.row]
        return row.tableViewCell(tableView) ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
}

extension NewsListViewModel: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section][indexPath.row]
        switch row {
            case .newsArticleText(let newsArticle),
                 .newsArticleWithImage(let newsArticle):
                delegate?.didTapArticle(newsArticle)
            default:
                break
        }
    }
}
