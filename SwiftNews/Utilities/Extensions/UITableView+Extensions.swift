//
//  UITableView+Extensions.swift
//  TravelerWhitelabel
//
//  Created by Uday Patial on 2019-06-12.
//  Copyright © 2019 Uday Patial. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeue<Cell: UITableViewCell>() -> Cell? {
        return dequeueReusableCell(withIdentifier: Cell.reuseIdentifier) as? Cell
    }
    
    func register<Cell>(_ cellType: Cell.Type) where Cell: UITableViewCell {
        register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
    }
    
    static func appThemedTableView() -> UITableView {
        let almostZero = CGFloat.leastNormalMagnitude
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.sectionHeaderHeight = almostZero
        tableView.sectionFooterHeight = almostZero
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: almostZero))
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: almostZero))
        return tableView
    }
}
