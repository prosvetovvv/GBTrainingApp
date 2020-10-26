//
//  LoginVC.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 21.10.2020.
//

import UIKit

class LoginVC: UIViewController {
    
    let rootView = LoginView()
    
    override func loadView() {
        super.loadView()
        view = rootView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDismissKeyboardTapGesture()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppeared), name: UIResponder.keyboardDidShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisappeared), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc
    private func keyboardAppeared(notification:Notification) {
        guard
            let userInfo = notification.userInfo,
            let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        rootView.scrollView.contentInset.bottom = keyboardSize.height
    }
    
    
    @objc
    private func keyboardDisappeared(notification:Notification) {
        rootView.scrollView.contentInset = UIEdgeInsets.zero
    }
    
    
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: rootView.containerView, action: #selector(UIView.endEditing))
        rootView.containerView.addGestureRecognizer(tap)
    }
}
