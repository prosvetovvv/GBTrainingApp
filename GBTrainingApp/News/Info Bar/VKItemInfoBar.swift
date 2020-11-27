//
//  VKItemInfoBar.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 02.11.2020.
//

import UIKit

class VKItemInfoBar: UIView {
    
    private let stackView   = UIStackView()
    private let likes       = VKItemInfoView(symbol: .likes)
    private let comments    = VKItemInfoView(symbol: .comments)
    private let reposts     = VKItemInfoView(symbol: .reposts)
    private let show        = VKItemInfoView(symbol: .show)

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(with new: News) {
        DispatchQueue.main.async {
            self.likes.countLabel.text     = String(new.likes)
            self.comments.countLabel.text  = String(new.comments)
            self.reposts.countLabel.text   = String(new.reposts)
            self.show.countLabel.text      = String(new.show)
        }
    }
    
    private func setup() {
        stackView.axis          = .horizontal
        stackView.distribution  = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(likes)
        stackView.addArrangedSubview(comments)
        stackView.addArrangedSubview(reposts)
        stackView.addArrangedSubview(show)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        super.updateConstraints()
    }
}
