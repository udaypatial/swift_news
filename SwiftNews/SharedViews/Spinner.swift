//
//  Spinner.swift
//  TravelerWhitelabel
//
//  Created by Uday Patial on 2019-06-20.
//  Copyright © 2019 Uday Patial. All rights reserved.
//

import UIKit

struct Spinner {
    
    static func show(in parent: UIView, showOverlay: Bool = false) {
        if let _ = getSpinner(in: parent) {
            return
        }
        
        let spinnerContent = SpinnerContent(showOverlay: showOverlay)
        parent.addSubview(spinnerContent)
        spinnerContent.constrainEdges(to: parent)
    }
    
    static func hide(in parent: UIView?) {
        guard let parent = parent else { return }
        getSpinner(in: parent)?.removeFromSuperview()
    }
    
    private static func getSpinner(in parent: UIView) -> UIView? {
        let view = parent.subviews.first(where: {
            $0.isKind(of: SpinnerContent.self)
        })
        return view
    }
}

private class SpinnerContent: UIView {
    
    private lazy var overlay: UIView = {
        let view = UIView()
        view.alpha = 0.1
        view.backgroundColor = .darkPrimary
        return view
    }()
    
    private lazy var activityView: UIView = {
        let view = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            view.style = UIActivityIndicatorView.Style.large
        } else {
            view.style = .gray
        }
        view.color = .darkSecondary
        view.startAnimating()
        return view
    }()
    
    init(showOverlay: Bool) {
        super.init(frame: .zero)
        setup(showOverlay: showOverlay)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(showOverlay: Bool) {
        if showOverlay {
            addSubview(overlay)
            overlay.constrainEdges(to: self)
        }
        
        isUserInteractionEnabled = showOverlay
        
        addSubview(activityView)
        activityView.constrainCenterX(to: self)
        activityView.constrainCenterY(to: self)
    }
}
