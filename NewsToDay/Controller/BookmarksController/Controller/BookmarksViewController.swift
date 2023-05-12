//
//  BookmarksViewController.swift
//  NewsToDay
//
//  Created by Sergey on 09.05.2023.
//

import Foundation
import UIKit

class BookmarksViewController : CustomViewController<BookmarksView> {
    
    override func loadView() {
        view = BookmarksView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.title = NSLocalizedString("bookmarks_title", comment: "")
    }
    
}

extension BookmarksViewController: BookmarksViewDelegate {
    
}
