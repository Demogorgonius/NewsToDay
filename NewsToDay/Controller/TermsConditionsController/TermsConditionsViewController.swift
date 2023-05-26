//
//  ViewController.swift
//  Terms
//
//  Created by Olesia on 16.05.2023.
//

import UIKit

class TermsConditionsViewController: UIViewController {
    
    //MARK: - UI Elements
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Terms & Coditions"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let termsText: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = true
        textView.isUserInteractionEnabled = true
        textView.frame = CGRect(x: 0, y: 0, width: 400, height: 100)
        textView.textColor = UIColor(named: Colors.greyPrimary)
        textView.font = .systemFont(ofSize: 17, weight: .regular)
        textView.text = NSLocalizedString("Terms", comment: "")
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = UIColor(named: Colors.purplePrimary)
    }
    
    private func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(termsText)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            
            termsText.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            termsText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            termsText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            termsText.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
            
        ])
    }
    

}

