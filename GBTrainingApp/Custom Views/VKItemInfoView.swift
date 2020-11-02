//
//  VKItemInfoView.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 02.11.2020.
//

import UIKit

enum ItemInfoType {
    case likes, comments, reposts, show
}

class VKItemInfoView: UIView {
    
    let symbolImageView = UIImageView()
    let countLabel      = VKTitleLabel(textAlignment: .left, fontSize: 14)
    
    
    init(symbol: SFSymbols) {
        super.init(frame: .zero)
        symbolImageView.image = UIImage(systemName: symbol.rawValue)
        setup()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup() {
        addSubview(symbolImageView)
        addSubview(countLabel)
        
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor   = .label
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        
        needsUpdateConstraints()
    }
    
    
    override func updateConstraints() {
        super.updateConstraints()
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            
            countLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            countLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            countLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
}
