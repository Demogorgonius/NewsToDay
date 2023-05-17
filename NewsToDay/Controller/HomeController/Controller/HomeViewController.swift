//
//  HomeViewController.swift
//  NewsToDay
//
//  Created by Sergey on 09.05.2023.
//

import Foundation
import UIKit
import SnapKit

class HomeViewController: UIViewController {

    private let homeView = HomeView()
    private let sections = MockData.shared.pageData
    var newsManager = NewsManager()
    var newsData: [Results]?
    var selectedCategory = ["Все" : "general",
                     "Развлечения" : "entertainment",
                     "Бизнес" : "business",
                     "Здоровье" : "health",
                     "Наука" : "science",
                     "Спорт" : "sports",
                     "Технологии" : "technology",
                     "Random" : "general",
                     "Entertainment" : "entertainment",
                     "Business" : "business",
                     "Health" : "health",
                     "Science" : "science",
                     "Sport" : "sports",
                     "Technology" : "technology"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addViews()
        setupViews()
        setDelegates()
        fetchDataNews()
    }
    
    private func fetchDataNews() {
        newsManager.performRequest(category: "top") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.newsData = data
                    self.homeView.collectionView.reloadData()
                    print(self.newsData)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func getNewsFromTopic(category: String) {
        if let index = MockData.shared.topics.items.firstIndex(where: { $0.categories == category }) {
            let selected = MockData.shared.topics.items[index].categories
            newsManager.performRequest(category: selectedCategory[selected] ?? "general") { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let news):
                        self.newsData = news
                        self.homeView.collectionView.reloadData()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    private func setupViews() {
        homeView.collectionView.register(TextFieldCollectionViewCell.self, forCellWithReuseIdentifier: "TextFieldCollectionViewCell")
        homeView.collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: "CategoriesCollectionViewCell")
        homeView.collectionView.register(LatestNewsCollectionViewCell.self, forCellWithReuseIdentifier: "LatestNewsCollectionViewCell")
        homeView.collectionView.register(RecomendedNewsCollectionViewCell.self, forCellWithReuseIdentifier: "RecomendedNewsCollectionViewCell")
        homeView.collectionView.register(HeaderSupplemetaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderSupplemetaryView")
        homeView.collectionView.collectionViewLayout = createLayout()
    }
    
    private func setDelegates() {
        homeView.collectionView.delegate = self
        homeView.collectionView.dataSource = self
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self = self else { return nil }
            let section = self.sections[sectionIndex]
            switch section {
            case .textField(_):
                return self.createTextFieldSection()
            case .topics(_):
                return self.createTopicSection()
            case .news(_):
                return self.createNewsSection()
            case .recommended(_):
                return self.createRecommendedNewsSection()
            }
        }
    }
    
    private func createLayoutSection(group: NSCollectionLayoutGroup,
                                     behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior,
                                     interGroupSpacing: CGFloat,
                                     supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem],
                                     contentInsets: Bool) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = behavior
        section.interGroupSpacing = interGroupSpacing
        section.boundarySupplementaryItems = supplementaryItems
        section.supplementariesFollowContentInsets = contentInsets
        return section
    }
    
    private func createTextFieldSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(112)), subitems: [item])
        let section = createLayoutSection(group: group,
                                          behavior: .none,
                                          interGroupSpacing: 16,
                                          supplementaryItems: [],
                                          contentInsets: false)
        section.contentInsets = .init(top: 0, leading: 20, bottom: 32, trailing: 20)
        return section
    }
    
    private func createTopicSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(100), heightDimension: .absolute(32)), subitems: [item])
        let section = createLayoutSection(group: group,
                                          behavior: .continuous,
                                          interGroupSpacing: 16,
                                          supplementaryItems: [],
                                          contentInsets: false)
        section.contentInsets = .init(top: 0, leading: 20, bottom: 24, trailing: 20)
        return section
    }
    
    private func createNewsSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(256), heightDimension: .absolute(256)), subitems: [item])
        let section = createLayoutSection(group: group,
                                          behavior: .continuous,
                                          interGroupSpacing: 16,
                                          supplementaryItems: [],
                                          contentInsets: false)
        section.contentInsets = .init(top: 0, leading: 20, bottom: 48, trailing: 20)
        return section
    }
    
    private func createRecommendedNewsSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(96)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.supplementariesFollowContentInsets = false
        section.interGroupSpacing = 16
        section.boundarySupplementaryItems = [supplementaryHeaderItem()]
        section.contentInsets = .init(top: 24, leading: 20, bottom: 16, trailing: 20)
        return section
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(30)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
}


extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let section = sections[indexPath.section]
        switch section {
        case .textField(_):
            print("0")
        case .topics(_):
            let selectedCategory = MockData.shared.topics.items[indexPath.item].categories
            getNewsFromTopic(category: selectedCategory)
            if let latestNewsCell = homeView.collectionView.cellForItem(at: indexPath) as? LatestNewsCollectionViewCell {
                if let newDone = newsData {
                    latestNewsCell.configureCell(image: nil, topic: newDone[indexPath.row].title ?? "", news: newDone[indexPath.row].title ?? "")
                } else {
                    latestNewsCell.latestNewsImage.image = UIImage(named: "default")
                    latestNewsCell.topicNewsLabel.text = ""
                    latestNewsCell.newsLabel.text = ""
                }
            }
        case .news(_):
            print("2")
        case .recommended(_):
            print("3")
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sections[section] {
        case .textField(_):
            return 1
        case .topics(_):
            return 7
        case .news(_):
            return 10
        case .recommended(_):
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case .textField(_):
            guard let cell = homeView.collectionView.dequeueReusableCell(withReuseIdentifier: "TextFieldCollectionViewCell", for: indexPath) as? TextFieldCollectionViewCell else { return UICollectionViewCell() }
            return cell
        case .topics(let topic):
            guard let cell = homeView.collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as? CategoriesCollectionViewCell else { return UICollectionViewCell() }
            cell.configureCell(topicName: topic[indexPath.row].categories)
            return cell
        case .news(_):
            guard let cell = homeView.collectionView.dequeueReusableCell(withReuseIdentifier: "LatestNewsCollectionViewCell", for: indexPath) as? LatestNewsCollectionViewCell else { return UICollectionViewCell() }
                        
            if let newsDataNew = newsData {
                cell.configureCell(image: nil, topic: newsDataNew[indexPath.row].title ?? "", news: newsDataNew[indexPath.row].description ?? "")
            } else {
                cell.newsLabel.text = "some text"
                cell.topicNewsLabel.text = ""
            }
            return cell
        case .recommended(let recommendedNews):
            guard let cell = homeView.collectionView.dequeueReusableCell(withReuseIdentifier: "RecomendedNewsCollectionViewCell", for: indexPath) as? RecomendedNewsCollectionViewCell else { return UICollectionViewCell() }
            cell.configureCell(image: recommendedNews[indexPath.row].image, newTopic: recommendedNews[indexPath.row].newsTopic, news: recommendedNews[indexPath.row].news)
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = homeView.collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                  withReuseIdentifier: "HeaderSupplemetaryView", for: indexPath) as! HeaderSupplemetaryView
            header.configureHeader(labelName: sections[indexPath.section].title)
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
}

extension HomeViewController {
    private func addViews() {
        view.addSubview(homeView.collectionView)
        addConstraints()
    }
    
    private func addConstraints() {
        homeView.collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
