//
//  VKAlertView.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 23.10.2020.
//

import UIKit

class AlertView: UIView {
    
    let titleLabel      = VKTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel    = VKBodyLabel(textAlignment: .center)
    let actionButton    = VKButton(backgroundColor: .systemPink, title: "Ok")
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    let padding: CGFloat = 20
    
    init(title: String, message: String, buttonTitle: String) {
        super.init(frame: .zero)
        self.alertTitle     = title
        self.message        = message
        self.buttonTitle    = buttonTitle
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28),
            
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12),
            
            actionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        super.updateConstraints()
    }
    
    
    private func setup() {
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        setupTitleLabel()
        setupMessageLabel()
        setupActionButton()
    }
    
    private func setupTitleLabel() {
        titleLabel.text = alertTitle ?? "Что-то пошло не так"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
    }
    
    
    private func setupMessageLabel() {
        messageLabel.text           = message ?? "Невозможно выполнить запрос"
        messageLabel.numberOfLines  = 4
        
        addSubview(messageLabel)
    }
    
    
    private func setupActionButton() {
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(actionButton)
    }
}
