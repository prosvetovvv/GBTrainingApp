//
//  VKTitleLabel.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 23.10.2020.
//

import UIKit

class VKTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init (textAlignment: NSTextAlignment, fontSize: CGFloat) {
        super.init(frame: .zero)
        self.textColor      = .label
        self.textAlignment  = textAlignment
        self.font           = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        setup()
    }
        
    private func setup() {
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor        = 0.9
        numberOfLines             = 1
        lineBreakMode             = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}



