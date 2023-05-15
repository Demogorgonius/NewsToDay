//
//  CategoriesViewController.swift
//  NewsToDay
//
//  Created by Sergey on 09.05.2023.
//

import Foundation
import UIKit

class CategoriesViewController : UIViewController {
    
    var defaults = UserDefaults.standard
    var nextButton = UIButton()
    let source: [Category] = Source.allCategories()
    var setOfCategories: [String] = ["Random"]
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        setup()
        setupNextButton()
        super.viewDidLoad()
        view.backgroundColor = .white
        
    }
    
    func setupNextButton() {
        view.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -20),
            nextButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 64)
        ])
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(.black, for: .normal)
        nextButton.backgroundColor = UIColor(named: "Purple Primary")
        nextButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        nextButton.layer.cornerRadius = 20
    }
    
    @objc func buttonAction() {
        UserDefaults.resetStandardUserDefaults()
        defaults.set(setOfCategories, forKey: "categories")

    }
    func setup() {
        collectionView = UICollectionView(frame: .zero , collectionViewLayout: setupFlowLayout())
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        collectionView.dataSource = self
        
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "\(CategoryCell.self)")
        collectionView.register(
                    HeaderReusableView.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: "\(HeaderReusableView.self)")
    }

    func setupFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = .init(width: da(), height: 72)
        
        func da() -> Int {
            let width = itemWidth(for: view.frame.width, spacing: 20)
            return Int(width)
        }

        func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
            let totalSpasing: CGFloat = 3 * spacing
            let finalWidth = (width - totalSpasing) / 2
            return finalWidth
        }
        // отступ
        layout.sectionInset = .init(top: 32, left: 20, bottom: 36, right: 20)
        //расстояние между ячейками
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        // header size
        layout.headerReferenceSize = .init(width: view.frame.size.width, height: 64+32)

        return layout
    }
}

extension CategoriesViewController: UICollectionViewDataSource {
    // number of cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return source.count
    }
    //set up cell in collection
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CategoryCell.self)", for: indexPath) as? CategoryCell else {return UICollectionViewCell()}
        
        cell.button.setTitle("\(source[indexPath.item].emojiString)  \(source[indexPath.item].categoryName)", for: .normal)
        cell.button.addTarget(self, action: #selector(addToCollection), for: .touchUpInside)
        return cell
    }
    @objc func addToCollection(button: UIButton) {
        let category = getRightCategory(buttonTitle: (button.titleLabel?.text)!)
        if setOfCategories.contains(category){
            setOfCategories = setOfCategories.filter({ $0 != category})
        }else {
            setOfCategories.append(category)
        }
    }
    
    func getRightCategory(buttonTitle: String) -> String{
        switch buttonTitle {
        case "🖥️  Technology":
            return "technology"
        case "📚  Science":
            return "science"
        case "🎭  Entertainment":
            return "entertaiment"
        case "🎰  Business":
            return "business"
        case "🏥  Health":
            return "health"
        case "⚽️  Sports":
            return "sports"
        default:
            return "unexpected case"
        }
    }
    
    // header set up
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(HeaderReusableView.self)", for: indexPath) as? HeaderReusableView else {return UICollectionReusableView()}
            return view
        default: return UICollectionReusableView()
        }
    }
    
}

