//
//  NewsVC.swift
//  VKCloneWithoutStoryboard
//
//  Created by Vitaly Prosvetov on 02.10.2020.
//  Copyright © 2020 Vitaly Prosvetov. All rights reserved.
//

import UIKit

class NewsVC: UIViewController {
    
    let rootView = NewsView()
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}
