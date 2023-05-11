//
//  HomeView.swift
//  NewsToDay
//
//  Created by Sergey on 09.05.2023.
//

import Foundation
import UIKit

class HomeView {
    
    lazy var descriptionNewsLabel: UILabel = {
        let element = UILabel()
        element.text = "Discover things of this world"
        element.font = .systemFont(ofSize: 16)
        element.textColor = UIColor(hexString: "#7C82A1")
        return element
    }()
    
    lazy var searchTextField: UITextField = {
        let element = UITextField()
        element.borderStyle = .roundedRect
        element.placeholder = "Search"
        element.backgroundColor = .tertiarySystemFill
        element.textAlignment = .left
        element.font = .systemFont(ofSize: 16)
        element.autocapitalizationType = .words
        element.returnKeyType = .search
        return element
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectViewLayout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectViewLayout)
        collectionView.backgroundColor = .none
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: "CategoriesCollectionViewCell")
        return collectionView
    }()
}
