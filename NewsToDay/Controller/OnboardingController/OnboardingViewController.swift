//
//  OnboardingViewController.swift
//  NewsToDay
//
//  Created by Марк Райтман on 11.05.2023.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    //MARK: - Properties
    let arrayUI = OnboardingModel()
    var index = 0
    
    //MARK: - UI components
    /// image
    private let cityImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    /// pageControl
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 6
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor(named: Colors.greyLighter)
        pageControl.currentPageIndicatorTintColor = UIColor(named: Colors.purpleDarker)
        return pageControl
    }()
    
    /// button
    private let nextButton: UIButton = {
        let button = UIButton()
        button.configuration = UIButton.Configuration.filled()
        button.configuration?.title = "Next"
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.configuration?.baseForegroundColor = .white
        button.configuration?.baseBackgroundColor = UIColor(named: Colors.purpleDarker)
        button.configuration?.cornerStyle = .medium
        button.addTarget(self, action: #selector(updatingUIButton(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc private func updatingUIButton(_ sender: UIButton) {
        index += 1
        updateUI()
        
        if nextButton.configuration?.title == "Get Started" {
            let vc = CategoriesVCOnboarding()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        } else if pageControl.currentPage == 5 {
            nextButton.configuration?.title = "Get Started"
            index = 0
        }
    }
    
    /// title
    private let titleTextView: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .center
        textView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        textView.textColor = .black
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.font = .boldSystemFont(ofSize: 24)
        return textView
    }()
    
    /// description
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .center
        textView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        textView.textColor = .gray
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.font = .systemFont(ofSize: 16, weight: .regular)
        return textView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        
        setupUI()
        updateUI()
    }
    
    //MARK: - Methods
    func updateUI() {
        let page = arrayUI.pages[index]
        pageControl.currentPage = index
        cityImageView.image = page.image
        titleTextView.text = page.title
        descriptionTextView.text = page.description
        nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }
}

extension OnboardingViewController {
    
    //MARK: - setupUI
    private func setupUI() {
        
        /// ADDING SUBVIEWS
        lazy var subView: [UIView] = [self.cityImageView, self.pageControl, self.nextButton, self.titleTextView, self.descriptionTextView]
        for view in subView { self.view.addSubview(view) }
        
        /// TAMIC
        cityImageView.translatesAutoresizingMaskIntoConstraints = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        titleTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        ///SETUP CONSTRAINTS
        NSLayoutConstraint.activate([
            cityImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            cityImageView.widthAnchor.constraint(equalToConstant: 290),
            cityImageView.heightAnchor.constraint(equalToConstant: 335),
            
            pageControl.topAnchor.constraint(equalTo: cityImageView.bottomAnchor, constant: 40),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.widthAnchor.constraint(equalToConstant: 140),
            pageControl.heightAnchor.constraint(equalToConstant: 10),
            
            titleTextView.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 35),
            titleTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleTextView.widthAnchor.constraint(equalToConstant: 300),
            
            descriptionTextView.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: 25),
            descriptionTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionTextView.widthAnchor.constraint(equalToConstant: 215),
            
            nextButton.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 335),
            nextButton.heightAnchor.constraint(equalToConstant: 55)])
    }
}

