//
//  TableViewDetailViewController.swift
//  TableView
//
//  Created by Jasman Arora on 5/7/23.
//

import UIKit

class TableViewDetailViewController: UIViewController {
    var user: User
    let avatarImageView = USImage(frame: .zero)
    let nameLabel = USLabel(textAlignment: .center, fontSize: 30)
    let emailLabel = USLabel(textAlignment: .center, fontSize: 20)
    let phoneLabel = USLabel(textAlignment: .center, fontSize: 20)
    let placeholderImage = UIImage(named: "user-placeholder")
    
    
        init(user: User) {
            self.user = user
            super.init(nibName: nil, bundle: nil)
           
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureDetailViewController()
        configureImage()
        configureLabelViews()
        
    }
   
    
    func configureDetailViewController() {
        view.backgroundColor = .systemBackground
        self.title = "Selected User"
        view.addSubview(avatarImageView)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(phoneLabel)
    }
    
    func configureImage()  {
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        Task {
            avatarImageView.image =  await  NetworkManager.shared.downloadImage(from: user.picture.large.absoluteString) ?? placeholderImage
        }
       
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 200),
            avatarImageView.widthAnchor.constraint(equalToConstant: 200)
            
        
        ])
    }
    
    func configureLabelViews() {
        nameLabel.text = user.name.first + " " + user.name.last
        emailLabel.text = user.email
        phoneLabel.text = user.phone
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 20),
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            emailLabel.heightAnchor.constraint(equalToConstant: 40),
            
            
            phoneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            phoneLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            phoneLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
            phoneLabel.heightAnchor.constraint(equalToConstant: 40),
            
        ])
      
    }

}
