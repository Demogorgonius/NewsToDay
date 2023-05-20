//
//  ViewController.swift
//  Profile
//
//  Created by Olesia on 14.05.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //MARK: - Title Label
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Profile"
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - User Image
    private let userImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "test")
        image.contentMode = .scaleAspectFill
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.lightGray.cgColor
        image.layer.cornerRadius = image.frame.size.width/2
        image.clipsToBounds = true
        return image
    }()
    
    //MARK: - Name Label
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Steve J"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - E-mail Label
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "steve@mail.com"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - Language Button
    private lazy var languageButton: UIButton = {
        let button = UIButton()
        button.configuration = UIButton.Configuration.filled()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration?.title = NSLocalizedString("Language", comment: "")
        button.contentHorizontalAlignment = .fill
        button.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 11), forImageIn: .normal)
        button.configuration?.imagePlacement = .trailing
        button.configuration?.contentInsets.trailing = 25
        button.configuration?.contentInsets.leading = 25
        button.configuration?.baseBackgroundColor = .systemFill
        button.configuration?.cornerStyle = .small
        button.addTarget(self, action: #selector(languageButtonPressed(_:)),
            for: .touchUpInside)
        return button
    }()
    
    //MARK: - Terms&Conditions Button
    private lazy var termsButton: UIButton = {
        let button = UIButton()
        button.configuration = UIButton.Configuration.filled()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration?.title = NSLocalizedString("TermsButton", comment: "")
        button.contentHorizontalAlignment = .fill
        button.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
        button.configuration?.imagePlacement = .trailing
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 11), forImageIn: .normal)
        button.configuration?.contentInsets.trailing = 25
        button.configuration?.contentInsets.leading = 25
        button.configuration?.baseBackgroundColor = .systemFill
        button.configuration?.cornerStyle = .small
        button.addTarget(self, action: #selector(termsButtonPressed(_:)),
            for: .touchUpInside)
        return button
    }()
    
    //MARK: - SignOut Button
    private lazy var signOutButton: UIButton = {
        let button = UIButton()
        button.configuration = UIButton.Configuration.filled()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration?.title = NSLocalizedString("SignOutButton", comment: "")
        button.contentHorizontalAlignment = .fill
        button.setImage(UIImage(systemName: "rectangle.portrait.and.arrow.right"), for: .normal)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 13), forImageIn: .normal)
        button.configuration?.imagePlacement = .trailing
        button.configuration?.contentInsets.trailing = 15
        button.configuration?.contentInsets.leading = 25
        button.configuration?.baseForegroundColor = .darkGray
        button.configuration?.baseBackgroundColor = .systemFill
        button.configuration?.cornerStyle = .small
        button.addTarget(self,action: #selector(signOutButtonPressed(_:)),
                         for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }

    //MARK: - Methods
    private func setupViews() {
        
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        view.addSubview(userImage)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(languageButton)
        view.addSubview(termsButton)
        view.addSubview(signOutButton)

    }
    
    @objc func languageButtonPressed(_ sender: UIButton) {
        let languageVC = LanguageViewController()
        self.navigationController?.pushViewController(languageVC, animated: true)
    }
    
    
    @objc func termsButtonPressed(_ sender: UIButton) {
        let termsVC = TermsConditionsViewController()
        self.navigationController?.pushViewController(termsVC, animated: true)
    }
    
    @objc func signOutButtonPressed(_ sender: UIButton) {
        #warning("Здесь добавить Sign Out")

    }
    
   private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),

            userImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            userImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            userImage.widthAnchor.constraint(equalToConstant: 80),
            userImage.heightAnchor.constraint(equalToConstant: 80),
            
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 115),
            nameLabel.leftAnchor.constraint(equalTo: userImage.rightAnchor, constant: 25),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            emailLabel.leftAnchor.constraint(equalTo: userImage.rightAnchor, constant: 25),
            
            languageButton.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 60),
            languageButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            languageButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            languageButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            languageButton.heightAnchor.constraint(equalToConstant: 55),
            
            termsButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            termsButton.bottomAnchor.constraint(equalTo: signOutButton.topAnchor, constant: -30),

            termsButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            termsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            termsButton.heightAnchor.constraint(equalToConstant: 55),
            
            signOutButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            signOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            signOutButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            signOutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            signOutButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}

