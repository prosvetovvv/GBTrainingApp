//
//  VKScrollView.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 22.10.2020.
//

import UIKit

class VKScrollView: UIScrollView {
    
    let containerView = UIView()

    init(view: UIView) {
        super.init(frame: .zero)
        setup(view: view)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup(view: UIView) {
        backgroundColor     = .red
        contentSize         = CGSize(width: view.frame.width, height: view.frame.height + 200)
        translatesAutoresizingMaskIntoConstraints = false
        
        containerView.backgroundColor   = .red
        containerView.frame.size        = CGSize(width: view.frame.width, height: view.frame.height + 200)
        
        addSubview(containerView)
    }
}
