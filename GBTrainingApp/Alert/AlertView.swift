//
//  VKAlertView.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 23.10.2020.
//

import UIKit

class AlertView: UIView {
    
    let titleLabel    = VKTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel  = VKBodyLabel(textAlignment: .center)
    let actionButton  = VKButton(backgroundColor: .systemPink, title: "Ok")
    let containerView = UIView()
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    let padding: CGFloat = 20
    
    init(title: String, message: String, buttonTitle: String) {
        super.init(frame: .zero)
        self.alertTitle     = title
        self.message        = message
        self.buttonTitle    = buttonTitle
        
        setupSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSelf() {
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        setupContainerView()
        setupTitleLabel()
        setupMessageLabel()
        setupActionButton()
        
        setNeedsUpdateConstraints()
    }
    
    private func setupContainerView() {
        containerView.backgroundColor       = .systemBackground
        containerView.layer.cornerRadius    = 16
        containerView.layer.borderWidth     = 2
        containerView.layer.borderColor     = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(containerView)
    }
    
    private func setupTitleLabel() {
        titleLabel.text = alertTitle ?? "Что-то пошло не так"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(titleLabel)
    }
    
    
    private func setupMessageLabel() {
        messageLabel.text           = message ?? "Невозможно выполнить запрос"
        messageLabel.numberOfLines  = 4
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(messageLabel)
    }
    
    
    private func setupActionButton() {
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(actionButton)
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28),
            
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12),
            
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        super.updateConstraints()
    }
}
