//
//  BookmarksView.swift
//  NewsToDay
//
//  Created by Sergey on 09.05.2023.
//

import Foundation
import UIKit
import SnapKit


protocol BookmarksViewDelegate: AnyObject {
    
}

class BookmarksView: CustomView {
    
    weak var delegate: BookmarksViewDelegate?
    
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
