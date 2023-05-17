import UIKit

class HeaderReusableView: UICollectionReusableView {
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.textColor = .black
        title.text = NSLocalizedString("Categories_Title", comment: "")
        title.textAlignment = .left
        title.numberOfLines = 1
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.font = UIFont.systemFont(ofSize: 24)
        return title
    }()
    
    let descriptionLabel: UILabel = {
        let title = UILabel()
        title.textColor = .lightGray
        title.text = NSLocalizedString("Categories_Title2", comment: "")
        title.textAlignment = .left
        title.numberOfLines = 0
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.font = UIFont.systemFont(ofSize: 16)
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHeader()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHeader() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: 20),
            titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor,constant: 8),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: 20),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
