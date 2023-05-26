//
//  ViewController.swift
//  Profile
//
//  Created by Olesia on 14.05.2023.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    //MARK: - UI Components
    /// title Label
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Profile"
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    /// user image
    let profileImageViewWidth: CGFloat = 100
    
    private lazy var userImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
//        image.image = UIImage(systemName: "photo.circle")
        image.image = #imageLiteral(resourceName: "photo").withRenderingMode(.alwaysOriginal)
        image.contentMode = .scaleAspectFill
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.lightGray.cgColor
        image.layer.cornerRadius = image.frame.size.width / 2
//        image.layer.cornerRadius = profileImageViewWidth / 2
        image.clipsToBounds = true
        return image
    }()
    
    /// user image button
    private lazy var profileImageViewButton: UIButton = {
        var button = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        button.configuration = .plain()
        button.layer.cornerRadius = button.frame.size.width / 2
        button.addTarget(self, action: #selector(profileImageButtonTapped), for: .touchUpInside)
        return button
    }()
    
    /// name Label
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    /// e-mail label
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.textColor = UIColor(named: Colors.greyDarker)
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    /// language button
    private lazy var languageButton: UIButton = {
        let button = UIButton()
        button.configuration = UIButton.Configuration.filled()
        button.configuration?.title = NSLocalizedString("LanguageButton", comment: "")
        button.configuration?.baseForegroundColor = UIColor(named: Colors.blackLighter)
        button.contentHorizontalAlignment = .fill
        button.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 11), forImageIn: .normal)
        button.configuration?.imagePlacement = .trailing
        button.configuration?.contentInsets.trailing = 25
        button.configuration?.contentInsets.leading = 25
        button.configuration?.baseBackgroundColor = UIColor(named: Colors.greyLighter)
        button.configuration?.cornerStyle = .medium
        button.addTarget(self, action: #selector(languageButtonPressed(_:)),
            for: .touchUpInside)
        return button
    }()
    
    /// terms&Conditions button
    private lazy var termsButton: UIButton = {
        let button = UIButton()
        button.configuration = UIButton.Configuration.filled()
        button.configuration?.title = NSLocalizedString("TermsButton", comment: "")
        button.contentHorizontalAlignment = .fill
        button.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
        button.configuration?.imagePlacement = .trailing
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 11), forImageIn: .normal)
        button.configuration?.contentInsets.trailing = 25
        button.configuration?.contentInsets.leading = 25
        button.configuration?.baseBackgroundColor = UIColor(named: Colors.greyLighter)
        button.configuration?.baseForegroundColor = UIColor(named: Colors.blackLighter)
        button.configuration?.cornerStyle = .medium
        button.addTarget(self, action: #selector(termsButtonPressed(_:)),
            for: .touchUpInside)
        return button
    }()
    
    /// sign out button
    private lazy var signOutButton: UIButton = {
        let button = UIButton()
        button.configuration = UIButton.Configuration.filled()
        button.configuration?.title = NSLocalizedString("SignOutButton", comment: "")
        button.contentHorizontalAlignment = .fill
        button.setImage(UIImage(systemName: "rectangle.portrait.and.arrow.right"), for: .normal)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 13), forImageIn: .normal)
        button.configuration?.imagePlacement = .trailing
        button.configuration?.contentInsets.trailing = 15
        button.configuration?.contentInsets.leading = 25
        button.configuration?.baseForegroundColor = UIColor(named: Colors.blackLighter)
        button.configuration?.baseBackgroundColor = UIColor(named: Colors.greyLighter)
        button.configuration?.cornerStyle = .medium
        button.addTarget(self,action: #selector(signOutButtonPressed(_:)),
                         for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchingUser()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        
    }
    
    //MARK: - Methods
    private func fetchingUser() {
        AuthService.shared.fetchUser { [weak self] user, error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showFetchingUserError(on: self, with: error)
                return
            }
            
            if let user = user {
                self.nameLabel.text = "\(user.username)"
                self.emailLabel.text = "\(user.email)"
            }
        }
    }
    
    @objc private func profileImageButtonTapped() {
        showImagePickerControllerActionSheets()
    }
    
    @objc private func languageButtonPressed(_ sender: UIButton) {
        let languageVC = LanguageViewController()
        self.navigationController?.pushViewController(languageVC, animated: true)
    }
    
    @objc private func termsButtonPressed(_ sender: UIButton) {
        let termsVC = TermsConditionsViewController()
        self.navigationController?.pushViewController(termsVC, animated: true)
    }
    
    @objc private func signOutButtonPressed(_ sender: UIButton) {
        AuthService.shared.signOut { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showLogOutErrorAlert(on: self, with: error)
                return
            }
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
    }
    
    //MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        /// ADDING SUBVIEWS
        view.addSubview(titleLabel)
        view.addSubview(profileImageViewButton)
        profileImageViewButton.addSubview(userImage)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(languageButton)
        view.addSubview(termsButton)
        view.addSubview(signOutButton)
        
        /// TAMIC
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        userImage.translatesAutoresizingMaskIntoConstraints = false
        profileImageViewButton.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        languageButton.translatesAutoresizingMaskIntoConstraints = false
        termsButton.translatesAutoresizingMaskIntoConstraints = false
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        
        /// SETUP CONSTRAINTS
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
            profileImageViewButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            profileImageViewButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            profileImageViewButton.widthAnchor.constraint(equalToConstant: 80),
            profileImageViewButton.heightAnchor.constraint(equalToConstant: 80),
            
            userImage.centerXAnchor.constraint(equalTo: profileImageViewButton.centerXAnchor),
            userImage.centerYAnchor.constraint(equalTo: profileImageViewButton.centerYAnchor),
            userImage.widthAnchor.constraint(equalToConstant: 80),
            userImage.heightAnchor.constraint(equalToConstant: 80),
            
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 115),
            nameLabel.leftAnchor.constraint(equalTo: profileImageViewButton.rightAnchor, constant: 25),
            
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

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showImagePickerControllerActionSheets() {
        let photoLibraryAction = UIAlertAction(title: "Choose from Library", style: .default) { (action) in
            self.showImagePickerController(sourceType: .photoLibrary)
        }
        let cameraAction = UIAlertAction(title: "Take a Photo", style: .default) { (action) in
            self.showImagePickerController(sourceType: .camera)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        AlertService.showAlert(style: .actionSheet, title: "Choose your image", message: nil, actions: [photoLibraryAction, cameraAction, cancelAction], completion: nil)
    }
    
    func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            userImage.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            userImage.image = originalImage
        }
        dismiss(animated: true, completion: nil)
    }
}

