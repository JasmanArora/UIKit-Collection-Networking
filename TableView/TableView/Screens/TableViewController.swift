//
//  TableViewController.swift
//  TableView
//
//  Created by Jasman Arora on 5/7/23.
//

import UIKit

class TableViewController: UIViewController {

    let tableView               = UITableView()
    var users: [User]   = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
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
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame         = view.bounds
        tableView.rowHeight     = 80
        tableView.delegate      = self
        tableView.dataSource    = self
        //tableView.removeExcessCells()
        
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.reuseID)
    }
    
    
    
    func updateUI() {
    
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.view.bringSubviewToFront(self.tableView)
            }
        }
        
    
}


extension TableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.reuseID) as! UserCell
        let user = users[indexPath.row]
        cell.set(user: user)
        //cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let user        = users[indexPath.row]
       let destVC      = TableViewDetailViewController(user: user)
       navigationController?.pushViewController(destVC, animated: true)
       print("Cell Tapped")
    }
    
   
}
