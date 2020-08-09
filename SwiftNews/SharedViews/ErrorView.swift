//
//  ErrorView.swift
//  TravelerWhitelabel
//
//  Created by Uday Patial on 2019-07-18.
//  Copyright © 2019 Uday Patial. All rights reserved.
//

import UIKit

class ErrorView: UIView {
    
    private let imageHeight: CGFloat = 174
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 50
        return stackView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = false
        imageView.layer.shadowColor = UIColor.darkSecondary.cgColor
        imageView.layer.shadowOpacity = 0.1
        return imageView
    }()
    
    private lazy var imageContainer: UIView = {
        let container = UIView()
        container.addSubview(imageView)        
        return container
    }()
    
    private lazy var labelContainer: UIView = {
        let view = UIView()
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        
        titleLabel.constrainTop(to: view)
        titleLabel.constrainEdgesHorizontally(to: view)
        
        subtitleLabel.constrainTopToBottom(of: titleLabel, offset: 10)
        subtitleLabel.constrainEdgesHorizontally(to: view)
        subtitleLabel.constrainBottom(to: view)
        return view
    }()
    
    private lazy var titleLabel = UILabel()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var button: GLButton = {
        let button = GLButton()
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    private var buttonAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(stackView)
        
        stackView.addArrangedSubview(imageContainer)
        stackView.addArrangedSubview(labelContainer)
        stackView.addArrangedSubview(button)
        
        constrainSubviews()
    }
    
    // MARK: - Public
    
    func showErrorViewWithBackButton(in viewController: UIViewController, title: String, subtitle: String) {
        
        show(in: viewController, image: #imageLiteral(resourceName: "img_error"), showRoundCard: true, title: title, subtitle: subtitle, buttonStyle: .secondary,
             buttonTitle: "Go Back",
             buttonAction: {
                viewController.navigationController?.popViewController(animated: true)
        })
    }
    
    func showModalErrorViewWithBackButton(in viewController: UIViewController, title: String, subtitle: String) {
        
        show(in: viewController, image: #imageLiteral(resourceName: "img_error"), showRoundCard: true, title: title, subtitle: subtitle, buttonStyle: .secondary,
             buttonTitle: "Go Back",
             buttonAction: {
                viewController.navigationController?.dismiss(animated: true, completion: nil)
        })
    }
    
    func showErrorView(in viewController: UIViewController, title: String, subtitle: String, buttonTitle: String? = nil, buttonAction: (() -> Void)? = nil) {
        
        show(in: viewController, image: #imageLiteral(resourceName: "img_error"), showRoundCard: true, title: title, subtitle: subtitle, buttonStyle: .secondary, buttonTitle: buttonTitle, buttonAction: buttonAction)
    }
    
    func showEmptyView(in viewController: UIViewController, image: UIImage? = nil, title: String, subtitle: String, buttonStyle: GLButton.Style = .secondary, buttonTitle: String? = nil, buttonAction: (() -> Void)? = nil) {
        
        let showRoundCard = image == nil
        show(in: viewController, image: image ?? #imageLiteral(resourceName: "img_empty"), showRoundCard: showRoundCard, title: title, subtitle: subtitle, buttonStyle: buttonStyle, buttonTitle: buttonTitle, buttonAction: buttonAction)
    }
    
    func dismiss() {
        removeFromSuperview()
    }
    
    // MARK: - Private
    
    private func show(in viewController: UIViewController, image: UIImage, showRoundCard: Bool, title: String, subtitle: String, buttonStyle: GLButton.Style, buttonTitle: String?, buttonAction: (() -> Void)?) {
        
        dismiss()
        viewController.view.addSubview(self)
        constrainErrorView(in: viewController)
        
        updateShadowCard(showRoundCard: showRoundCard)
        configure(title: title, subtitle: subtitle, image: image, buttonStyle: buttonStyle, buttonTitle: buttonTitle, buttonAction: buttonAction)
    }
    
    private func constrainErrorView(in viewController: UIViewController) {
        guard let parent = viewController.view else {
            print("🚨 ErrorView: View Controller doesn't have a view to constrain to")
            return
        }
        
        if viewController is UINavigationController {
            constrainEdgesHorizontally(to: parent)
            constrainEdgesVertically(to: parent)
            constrainBottom(to: parent)
        } else {
            constrainToTopLayoutGuide(of: viewController)
            constrainEdgesHorizontally(to: parent)
            constrainBottom(to: parent)
        }
    }
    
    private func updateShadowCard(showRoundCard: Bool) {
        if showRoundCard {
            imageView.layer.cornerRadius = imageHeight / 2
            imageView.layer.shadowRadius = 16
            imageView.layer.shadowOffset = CGSize(width: 0, height: 8)
            imageView.backgroundColor = .bgWhite
        } else {
            imageView.layer.cornerRadius = 0
            imageView.layer.shadowRadius = 0
            imageView.layer.shadowOffset = .zero
            imageView.backgroundColor = .clear
        }
    }
    
    private func configure(title: String, subtitle: String, image: UIImage? = nil, buttonStyle: GLButton.Style, buttonTitle: String?, buttonAction: (() -> Void)?) {
        titleLabel.attributedText = .headline(title, alignment: .center)
        subtitleLabel.attributedText = .body(subtitle, alignment: .center)
        imageView.image = image
        
        self.buttonAction = buttonAction
        
        button.style = buttonStyle
        if let buttonTitle = buttonTitle {
            button.configure(title: buttonTitle)
            button.isHidden = false
        } else {
            button.isHidden = true
        }
    }
    
    private func constrainSubviews() {
        let windowHeight = UIScreen.main.bounds.height
        let errorViewOffset = windowHeight * 0.025
        
        stackView.constrainCenterY(to: self, offset: -errorViewOffset)
        stackView.constrainEdgesHorizontally(to: self, offset: 32)
        
        imageView.constrainEdgesVertically(to: imageContainer)
        imageView.constrainCenterX(to: imageContainer)
        imageView.constrainSize(CGSize(width: imageHeight, height: imageHeight))
    }
    
    @objc private func buttonPressed() {
        buttonAction?()
    }
}
