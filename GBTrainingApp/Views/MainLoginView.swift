//
//  MainLoginView.swift
//  VKCloneWithoutStoryboard
//
//  Created by Vitaly Prosvetov on 28.09.2020.
//  Copyright © 2020 Vitaly Prosvetov. All rights reserved.
//

import UIKit
import WebKit

class MainLoginView: WKWebView, WKNavigationDelegate {
    
    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration: configuration)
        
        let urlComponents = makeUrlComponents()
        let request = URLRequest(url: urlComponents.url!)
        
        load(request)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeUrlComponents() -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7611296"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
            //Для выхода из аккаунта
            //URLQueryItem(name: "revoke", value: "1")
        ]
        
        return urlComponents
    }
}
