import Foundation
import UIKit

class CategoriesViewController : UIViewController {
    
    var categoriesManager = CategoriesManager()
    var nextButton = UIButton()
    let source: [Category] = Source.allCategories()
    var collectionView: UICollectionView!
    var selectedButtons = 0
    
    override func viewDidLoad() {
        setup()
        setupNextButton()
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
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
        nextButton.setTitle(NSLocalizedString("Categories_NextButton", comment: ""), for: .normal)
        nextButton.setTitleColor(.black, for: .normal)
        nextButton.backgroundColor = UIColor(named: "Purple Primary")
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        nextButton.layer.cornerRadius = 20
    }

    @objc func nextButtonTapped(_ sender: UIButton) {
        
        categoriesManager.setUserDefaults()
        let homeVC = HomeViewController()
        tabBarController?.selectedIndex = 0
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
        // активирует кнопки если userDefaults уже есть
        let category = categoriesManager.getCategories()
        if !category.isEmpty {
            for element in category {
                if cell.button.titleLabel!.text == categoriesManager.getRightTitle(category: "\(element)"){
                    addToCollection(button: cell.button)
                }
            }
        }
        return cell
    }
    @objc func addToCollection(button: UIButton) {
        if selectedButtons == 5 && !button.isSelected {
            return
        }
        let category = categoriesManager.getRightCategory(buttonTitle: (button.titleLabel?.text)!)
        if categoriesManager.setOfCategories.contains(category){
            button.isSelected = false
            button.backgroundColor = .systemBackground
            categoriesManager.setOfCategories = categoriesManager.setOfCategories.filter({ $0 != category})
            selectedButtons -= 1
        }else {
            button.isSelected = true
            button.backgroundColor = UIColor(named: "Purple Primary")
            categoriesManager.setOfCategories.append(category)
            selectedButtons += 1
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

