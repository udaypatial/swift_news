//
//  SNRootViewController.swift
//  SwiftNews
//
//  Created by Uday Patial on 2020-08-09.
//  Copyright © 2020 Uday Patial. All rights reserved.
//

import UIKit

class SNRootViewController: UIViewController {
    
    let homeRouter = NavigationRouter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addHostControllerAsContainer()
    }
    
    private func addHostControllerAsContainer() {
        let hostController = homeRouter.newsListController
        addChild(hostController)
        view.addSubview(hostController.view)
        hostController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hostController.view.frame = view.bounds
        hostController.didMove(toParent: self)
    }
}
