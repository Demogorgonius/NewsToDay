//
//  ProfileViewController.swift
//  NewsToDay
//
//  Created by Sergey on 09.05.2023.
//

import Foundation
import UIKit

class ProfileViewController : CustomViewController<ProfileView> {
    
    override func loadView() {
        view = ProfileView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.delegate = self
        
    }
    
}

extension ProfileViewController: ProfileViewDelegate {
    
}
