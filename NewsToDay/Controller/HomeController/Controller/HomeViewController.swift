//
//  HomeViewController.swift
//  NewsToDay
//
//  Created by Sergey on 09.05.2023.
//

import Foundation
import UIKit

class HomeViewController : CustomViewController<HomeView> {
    
    override func loadView() {
        view = HomeView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.delegate = self
        
    }
    
}

extension HomeViewController: HomeViewDelegate {
    
}
