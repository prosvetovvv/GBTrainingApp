//
//  VKItemInfoBar.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 02.11.2020.
//

import UIKit

class VKItemInfoBar: UIView {
    
    let stackView   = UIStackView()
    let likes       = VKItemInfoView(symbol: .likes)
    let comments    = VKItemInfoView(symbol: .comments)
    let reposts     = VKItemInfoView(symbol: .reposts)
    let show        = VKItemInfoView(symbol: .show)

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup() {
        stackView.axis          = .horizontal
        stackView.distribution  = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(likes)
        stackView.addArrangedSubview(comments)
        stackView.addArrangedSubview(reposts)
        stackView.addArrangedSubview(show)
    }
}
