//
//  AlertVC.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 23.10.2020.
//

import UIKit

class AlertVC: UIViewController {
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    init(title: String, message: String, buttonTitle: String) {
        self.alertTitle     = title
        self.message        = message
        self.buttonTitle    = buttonTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        let rootView = AlertView(title: alertTitle ?? "Что-то пошло не так", message: message ?? "Невозможно выполнить запрос", buttonTitle: buttonTitle ?? "Ok")
        //let rootView = VKAlertView(title: alertTitle, message: message, buttonTitle: buttonTitle)
        view = rootView
        
        rootView.actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc
    private func dismissVC() {
        dismiss(animated: true)
    }
    
}
