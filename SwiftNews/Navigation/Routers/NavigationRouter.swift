//
//  NavigationRouter.swift
//  SwiftNews
//
//  Created by Uday Patial on 2020-08-09.
//  Copyright © 2020 Uday Patial. All rights reserved.
//

import UIKit

class NavigationRouter {
    lazy var newsListController: UINavigationController = {
        let vc = NewsListViewController()
        vc.delegate = self
        vc.title = NSLocalizedString("Swift News", comment: "Swift News")
        let navController = UINavigationController(rootViewController: vc)
        return navController
    }()
}

extension NavigationRouter: NewsListViewControllerDelegate {
    func newsListViewController(_ controller: NewsListViewController, didTapNewsItemFor item: NewsArticle) {
        let vc = NewsDetailsVC(newsArticle: item)
        vc.title = item.title
        controller.navigationController?.pushViewController(vc, animated: true)
    }
}

