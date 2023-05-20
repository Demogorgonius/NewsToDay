//
//  HomeController.swift
//  NewsToDay
//
//  Created by Марк Райтман on 20.05.2023.
//

import UIKit
import FirebaseAuth

class HomeController: UIViewController {
    //MARK: - UI Components
    /// label
    private let homeLabel: UILabel = {
        let label = UILabel()
        label.text = "This is our HOME controller of NewsApp"
        label.textColor = #colorLiteral(red: 0.8446564078, green: 0.5145705342, blue: 1, alpha: 1)
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        return label
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchingUser()
    }
    
    #warning("Здесь достаём данные из бд Firebase")
    //MARK: - Methods
    private func fetchingUser() {
        AuthService.shared.fetchUser { [weak self] user, error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showFetchingUserError(on: self, with: error)
                return
            }
            
            if let user = user {
                self.homeLabel.text = "\(user.username)\n\(user.email)"
            }
        }
    }
    
    #warning("Здесь мы разлогиниваемся")
    @objc private func didTapLogout() {
        AuthService.shared.signOut { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showLogOutErrorAlert(on: self, with: error)
                return
            }
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
    }
    
    #warning("Поменять UI в своём контроллере")
    //MARK: - UI Setup
    func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(didTapLogout))
        
        /// ADDING SUBVIEWS
        view?.addSubview(homeLabel)
        
        /// TAMIC
        homeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        /// SETUP CONSTRAINTS
        NSLayoutConstraint.activate([
            homeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            homeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
    }

    
}
