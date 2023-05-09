//
//  USImage.swift
//  CollectionView
//
//  Created by Jasman Arora on 5/8/23.
//



import UIKit

class USImage: UIImageView {
    
    let cache = NetworkManager.shared.cache
    let placeholderImage = UIImage(named: "user-placeholder")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func downloadImage(fromURL url: String) {
        
        Task {
            image = await  NetworkManager.shared.downloadImage(from: url) ?? placeholderImage
        }
    }
}
