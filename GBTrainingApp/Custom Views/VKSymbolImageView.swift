//
//  VKSymbolImageView.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 29.10.2020.
//

import UIKit

class VKSymbolImageView: UIImageView {

    init(symbol: SFSymbols) {
        super.init(frame: .zero)
        setup()
        image = UIImage(systemName: symbol.rawValue)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup() {
        tintColor = .secondaryLabel
        translatesAutoresizingMaskIntoConstraints = false
    }
}
