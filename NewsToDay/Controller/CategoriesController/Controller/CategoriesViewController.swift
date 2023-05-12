//
//  CategoriesViewController.swift
//  NewsToDay
//
//  Created by Sergey on 09.05.2023.
//

import Foundation
import UIKit

class CategoriesViewController : CustomViewController<CategoriesView> {
    
    override func loadView() {
        view = CategoriesView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.delegate = self
        
    }
    
}

extension CategoriesViewController: CategoriesViewDelegate {
    
}
