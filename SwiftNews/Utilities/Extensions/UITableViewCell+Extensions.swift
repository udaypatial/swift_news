//
//  UITableViewCell+Extensions.swift
//  TravelerWhitelabel
//
//  Created by Uday Patial on 2019-06-11.
//  Copyright © 2019 Uday Patial. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
