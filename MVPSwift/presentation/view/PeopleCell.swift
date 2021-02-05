//
//  PeopleCell.swift
//  MVPSwift
//
//  Created by Nanda Wisnu Perdana on 05/02/21.
//  Copyright © 2021 Nanda w Perdana. All rights reserved.
//

import UIKit

class PeopleCell: UITableViewCell {
    let labelName: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.font = UIFont.boldSystemFont(ofSize: 16)
        view.textAlignment = .left
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let labelEmail: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.font = UIFont.boldSystemFont(ofSize: 14)
        view.textAlignment = .left
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var item: People? {
        didSet {
            guard let item = item else { return }
            setItem(item)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        selectionStyle = .gray
        
        contentView.addSubview(labelName)
        contentView.addSubview(labelEmail)
        
        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
            labelName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            labelName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            labelName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),

            labelEmail.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            labelEmail.trailingAnchor.constraint(equalTo: labelName.trailingAnchor),
            labelEmail.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: padding),
            
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: labelEmail.bottomAnchor, constant: padding)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setItem(_ item: People) {
        labelName.text = item.name
        labelEmail.text = item.email
    }
}
