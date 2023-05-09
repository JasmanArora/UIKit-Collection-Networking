//
//  UserCell.swift
//  CollectionView
//
//  Created by Jasman Arora on 5/8/23.
//

import UIKit

class UserCell: UICollectionViewCell {
    static let reuseID = "UserCell"
    
    let avatarImageView = USImage(frame: .zero)
    let usernameLabel = USLabel(textAlignment: .center, fontSize: 16)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(user:User) {
      
        avatarImageView.downloadImage(fromURL: user.picture.large.absoluteString)
        usernameLabel.text = user.name.first
        
    }
    
    private func configure() {
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
        
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding ),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 5),
            usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 18)
        
        ])
        
    }
}
