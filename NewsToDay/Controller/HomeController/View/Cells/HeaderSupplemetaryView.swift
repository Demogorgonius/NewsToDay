//
//  HeaderSupplemetaryView.swift
//  NewsToDay
//
//  Created by Dmitry Medvedev on 11.05.2023.
//

import UIKit
import SnapKit

final class HeaderSupplemetaryView: UICollectionReusableView {
    private lazy var headerLabel: UILabel = {
        let element = UILabel()
        element.text = "Recommended for you"
        element.textColor = UIColor(hexString: "#333647")
        element.font = .boldSystemFont(ofSize: 20)
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHeader(labelName: String) {
        headerLabel.text = labelName
    }
    
    private func setupView() {
        addSubview(headerLabel)
    }
    
    private func setConstraints() {
        headerLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
    }
}
