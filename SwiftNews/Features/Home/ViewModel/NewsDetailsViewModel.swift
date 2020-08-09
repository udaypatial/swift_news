//
//  NewsDetailsViewModel.swift
//  SwiftNews
//
//  Created by Uday Patial on 2020-08-09.
//  Copyright © 2020 Uday Patial. All rights reserved.
//

import UIKit

enum NewsDetailRow: GLRow {
    
    case sharedRow(_ sharedRow: SharedRow)
    case newsPhoto(_ url: String?)
    case newsInfo(_ title: String, description: String)
    
    func tableViewCell(_ tableView: UITableView) -> UITableViewCell? {
        switch self {
            case .sharedRow(let sharedRow):
                return sharedRow.tableViewCell(tableView)
            case .newsPhoto(let url):
                if let cell: NewsImageCell = tableView.dequeue() {
                    cell.configure(for: url)
                    cell.selectionStyle = .none
                    return cell
            }
            case .newsInfo(let title, let description):
                if let cell: NewsInfoCell = tableView.dequeue() {
                    cell.configure(title: title, description: description)
                    cell.selectionStyle = .none
                    return cell
            }
        }
        return nil
    }
    
    static func registerAllCells(in tableView: UITableView) {
        SharedRow.registerAllCells(in: tableView)
        tableView.register(NewsImageCell.self)
        tableView.register(NewsInfoCell.self)
    }
}

class NewsDetailsViewModel: NSObject {
    var sections = [[NewsDetailRow]]()
    
    var newsArticle: NewsArticle
    
    init(newsArticle: NewsArticle) {
        self.newsArticle = newsArticle
    }
    
    func updateSections(newsArticle: NewsArticle) {
        var newSections = [[NewsDetailRow]]()
        
        newSections.append(newsDetailsSection(newsArticle))
        
        sections = newSections
    }
    
    private func newsDetailsSection(_ newsArticle: NewsArticle) -> [NewsDetailRow] {
        var rows = [NewsDetailRow]()
        
        if newsArticle.thumbnailImage?.isValidURL ?? false {
            rows.append(.newsPhoto(newsArticle.thumbnailImage))
            rows.append(.sharedRow(.spacer(10)))
        }
        
        rows.append(.newsInfo(newsArticle.title,
                              description: newsArticle.description ?? ""))
        
        return rows
    }
    
}

extension NewsDetailsViewModel: UITableViewDataSource {
    
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
