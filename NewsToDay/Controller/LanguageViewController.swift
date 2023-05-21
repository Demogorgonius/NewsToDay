//
//  ViewController.swift
//  Language
//
//  Created by Olesia on 16.05.2023.
//

import UIKit

class LanguageViewController: UIViewController {
    
//MARK: - UI Elements
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Language"
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var engButton: UIButton = {
        let button = UIButton()
        button.configuration = UIButton.Configuration.filled()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration?.title = NSLocalizedString("English", comment: "")
        button.contentHorizontalAlignment = .leading
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 11), forImageIn: .normal)
        button.configuration?.imagePlacement = .trailing
        button.configuration?.contentInsets.trailing = 25
        button.configuration?.contentInsets.leading = 25
        button.configuration?.baseForegroundColor = .darkGray
        button.configuration?.baseBackgroundColor = .systemFill
        button.configuration?.cornerStyle = .small
        button.addTarget(self, action: #selector(engButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var rusButton: UIButton = {
        let button = UIButton()
        button.configuration = UIButton.Configuration.filled()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration?.title = NSLocalizedString("Russian", comment: "")
        button.contentHorizontalAlignment = .leading
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 11), forImageIn: .normal)
        button.configuration?.imagePlacement = .trailing
        button.configuration?.contentInsets.trailing = 25
        button.configuration?.contentInsets.leading = 25
        button.configuration?.baseBackgroundColor = .systemFill
        button.configuration?.baseForegroundColor = .darkGray
        button.configuration?.cornerStyle = .small
        button.addTarget(self, action: #selector(rusButtonPressed), for: .touchUpInside)
        return button
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
    
    @objc private func engButtonPressed(_ sender: UIButton) {
        sender.configuration?.baseBackgroundColor = .blue
        sender.configuration?.baseForegroundColor = .white
        rusButton.configuration?.baseBackgroundColor = .systemFill
        rusButton.configuration?.baseForegroundColor = .darkGray
        changeLang(lang: "en-US")
    }
    
    @objc private func rusButtonPressed(_ sender: UIButton) {
        sender.configuration?.baseBackgroundColor = .blue
        sender.configuration?.baseForegroundColor = .white
        engButton.configuration?.baseBackgroundColor = .systemFill
        engButton.configuration?.baseForegroundColor = .darkGray
        changeLang(lang: "ru-RU")
        
    }

    private func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(engButton)
        view.addSubview(rusButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
            engButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            engButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            engButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            engButton.heightAnchor.constraint(equalToConstant: 55),
            
            rusButton.topAnchor.constraint(equalTo: engButton.bottomAnchor, constant: 20),
            rusButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            rusButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            rusButton.heightAnchor.constraint(equalToConstant: 55)
            ])
    }

}

extension LanguageViewController {
    private func changeLang(lang: String) {
        let defaults = UserDefaults.standard
        defaults.set([lang], forKey: "AppleLanguages")
        defaults.synchronize()
        navigationController?.popToRootViewController(animated: true)
    }
}
