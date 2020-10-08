//
//  MainLoginVC.swift
//  VKCloneWithoutStoryboard
//
//  Created by Vitaly Prosvetov on 28.09.2020.
//  Copyright © 2020 Vitaly Prosvetov. All rights reserved.
//

import UIKit
import WebKit

class MainLoginVC: UIViewController {
    
    let rootView = MainLoginView()
    
    override func loadView() {
        super.loadView()
        view = rootView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRootViewDelegate()
    }
    
    
    func setRootViewDelegate() {
        rootView.navigationDelegate = self
    }
}

extension MainLoginVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        let token = params["access_token"]
        
        guard token != nil else { return }
        Session.shared.token = token ?? " "
                
        let tabBar = TabBarController()
        tabBar.modalPresentationStyle = .fullScreen
        present (tabBar, animated: true)
        
        decisionHandler(.cancel)
    }
}
