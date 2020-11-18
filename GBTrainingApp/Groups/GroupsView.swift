//
//  GroupsView.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 18.11.2020.
//

import UIKit

class GroupsView: UIView {

    let tableView = UITableView()
    
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup() {
        addSubview(tableView)
        
        tableView.rowHeight = 100
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        setNeedsUpdateConstraints()
    }
    
    
    override func updateConstraints() {
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        super.updateConstraints()
    }
}
