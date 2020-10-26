//
//  MainLoginView.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 21.10.2020.
//

import UIKit

class LoginView: UIView {
    
    let scrollView          = UIScrollView()
    let containerView       = UIView()
    let logoImageView       = UIImageView()
    let loginTextField      = VKTextField(placeholder: "Имя пользователя")
    let passwordTextField   = VKTextField(placeholder: "Пароль")
    let loginButton         = VKButton(backgroundColor: .systemBlue, title: "Вход")
    
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        super.updateConstraints()

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),

            logoImageView.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 180),
            logoImageView.widthAnchor.constraint(equalToConstant: 180),

            loginTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 90),
            loginTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 50),
            loginTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -50),
            loginTextField.heightAnchor.constraint(equalToConstant: 50),

            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 40),
            passwordTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 50),
            passwordTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),

            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 50),
            loginButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -50),
            loginButton.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }
    
    
    private func setup() {
        setupScrollView()
        setupContainerView()
        setupLogoImageView()
        
        containerView.addSubview(loginTextField)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(loginButton)
        
        setNeedsUpdateConstraints()
    }
    
    
    private func setupScrollView() {
        scrollView.backgroundColor  = .systemBackground
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(scrollView)
    }
    
    
    private func setupContainerView() {
        containerView.backgroundColor = .systemBackground
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(containerView)
    }
    
    
    private func setupLogoImageView() {
        logoImageView.image         = UIImage(named: "logo")
        logoImageView.contentMode   = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(logoImageView)
    }
}
