//
//  HomeViewController.swift
//  CollectionView
//
//  Created by Jasman Arora on 5/8/23.
//

import UIKit

class HomeViewController: UIViewController {

    //let collectionView               = UICollectionView()
    
    let userCollectionView:UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    var users: [User]   = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getUsers()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    
    func configureViewController() {
        view.backgroundColor    = .systemBackground
        title                   = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    func getUsers() {
      
        Task {
            do {
                users = try await NetworkManager.shared.getUsers()
                updateUI()
                            } catch {
                if let apError = error as? UserError {
                    switch apError {
                    case.invalidData:
                        print("Invalid Data")
                    case .invalidURL:
                        print("Invalid URL")
                    case .invalidResponse:
                        print("Invalid Response")
                    case .unableToComplete:
                        print("Unable To Complete")
                    }
                } else {
                    print("General Error Occured")
                }
             
              
            }
        }
    
    }
    
    func configureCollectionView() {
        //view.addSubview(collectionView)
        
      //  collectionView.frame         = view.bounds
       
        //collectionView.delegate      = self
        //collectionView.dataSource    = self
      
        
       // collectionView.register(UserCell.self, forCellWithReuseIdentifier: UserCell.reuseID)
        
        layout.itemSize = CGSizeMake(120, 120)
        layout.scrollDirection = .vertical
        userCollectionView.setCollectionViewLayout(layout, animated: true)
        userCollectionView.delegate = self
        userCollectionView.dataSource = self
        userCollectionView.backgroundColor = UIColor.clear
        userCollectionView.frame         = view.bounds
        userCollectionView.register(UserCell.self, forCellWithReuseIdentifier: UserCell.reuseID)
        view.addSubview(userCollectionView)
        
    }
    
    
    
    func updateUI() {
                self.userCollectionView.reloadData()
        }
    

}



extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserCell.reuseID, for: indexPath) as! UserCell
        let user = users[indexPath.row]
        cell.set(user: user)
        //cell.selectionStyle = .none
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let user        = users[indexPath.row]
        let destVC      = DetailViewController(user: user)
        if let sheet = destVC.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        self.present(destVC, animated: true, completion: nil)
//        navigationController?.pushViewController(destVC, animated: true)
        //print("Cell Tapped")
    }
    
    
}
