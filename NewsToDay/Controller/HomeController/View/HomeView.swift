//
//  HomeView.swift
//  NewsToDay
//
//  Created by Sergey on 09.05.2023.
//

import Foundation
import UIKit
import SnapKit


protocol HomeViewDelegate: AnyObject {
    
}

class HomeView: CustomView {
    
    weak var delegate: HomeViewDelegate?
    
    //MARK: - setViews
    
    override func setViews() {
         super.setViews()
        
        // add subviews to view
        
    }
    
    //MARK: - layoutView
    
    override func layoutViews() {
        super.layoutViews()
        
        // setup constraints
        
    }
    
    
}
