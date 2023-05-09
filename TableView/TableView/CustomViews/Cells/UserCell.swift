//
//  UserCell.swift
//  TableView
//
//  Created by Jasman Arora on 5/7/23.
//

import UIKit

class UserCell: UITableViewCell {

    static let reuseID = "FavoriteCell"
    let avatarImageView = USImage(frame: .zero)
    let usernameLabel = USLabel(textAlignment: .left, fontSize: 26)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(user:User) {
        avatarImageView.downloadImage(fromURL: user.picture.large.absoluteString)
        usernameLabel.text = user.name.first + " " + user.name.last
    }
    
    
    
    private func configure() {
      
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        
        
        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
        
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            
            
            usernameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40)
        
        ])
    }
}
