//
//  SharedRow.swift
//  SwiftNews
//
//  Created by Uday Patial on 2020-08-09.
//  Copyright © 2020 Uday Patial. All rights reserved.
//

import UIKit

// View Model for a single Cell
protocol GLRow {
    func tableViewCell(_ tableView: UITableView) -> UITableViewCell?
    static func registerAllCells(in tableView: UITableView)
}

enum SharedRow: GLRow {
    case topNavSpacer
    case spacer(_ height: CGFloat)
    case divider
    case customDivider(height: CGFloat, inset: CGFloat)
    case label(_ title: NSAttributedString)
    case multilineLabel(_ title: NSAttributedString)
    case labelWithButton(title: NSAttributedString, buttonTitle: NSAttributedString, buttonAction: (() -> Void)?)
    
    func tableViewCell(_ tableView: UITableView) -> UITableViewCell? {
        switch self {
            case .topNavSpacer:
                if let cell: SpacerCell = tableView.dequeue() {
                    cell.configure(height: AppTheme.NavBar.navCornerRadius)
                    cell.selectionStyle = .none
                    return cell
            }
            case .spacer(let height):
                if let cell: SpacerCell = tableView.dequeue() {
                    cell.configure(height: height)
                    cell.selectionStyle = .none
                    return cell
            }
            case .divider:
                if let cell: DividerCell = tableView.dequeue() {
                    cell.configure(height: 1, inset: 0)
                    cell.selectionStyle = .none
                    return cell
            }
            case .customDivider(let height, let inset):
                if let cell: DividerCell = tableView.dequeue() {
                    cell.configure(height: height, inset: inset)
                    cell.selectionStyle = .none
                    return cell
            }
            case .label(let attributedString):
                if let cell: LabelCell = tableView.dequeue() {
                    cell.configure(title: attributedString, numberOfLines: 1)
                    cell.selectionStyle = .none
                    return cell
            }
            case .labelWithButton(let title, let buttonTitle, let buttonAction):
                if let cell: LabelWithButtonCell = tableView.dequeue() {
                    cell.configure(title: title, buttonTitle: buttonTitle, buttonAction: buttonAction)
                    cell.selectionStyle = .none
                    return cell
            }
            case .multilineLabel(let attributedString):
                if let cell: LabelCell = tableView.dequeue() {
                    cell.configure(title: attributedString, numberOfLines: 0)
                    cell.selectionStyle = .none
                    return cell
            }
        }
        return nil
    }
    
    static func registerAllCells(in tableView: UITableView) {
        tableView.register(SpacerCell.self)
        tableView.register(DividerCell.self)
        tableView.register(LabelCell.self)
        tableView.register(LabelWithButtonCell.self)
        
    }
}

