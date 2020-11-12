//
//  VKNewBodyLabel.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 06.11.2020.
//

import UIKit

class VKNewBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        
    private func setup() {
        backgroundColor             = .systemTeal
        textAlignment               = .left
        textColor                   = .secondaryLabel
        font                        = UIFont.preferredFont(forTextStyle: .body)
        numberOfLines               = 0
        
//        adjustsFontSizeToFitWidth   = true
//        minimumScaleFactor          = 0.75
//        lineBreakMode               = .byWordWrapping
        
        translatesAutoresizingMaskIntoConstraints = false
    }

}
