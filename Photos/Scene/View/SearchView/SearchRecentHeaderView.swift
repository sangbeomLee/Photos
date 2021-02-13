//
//  SearchRecentHeaderView.swift
//  Photos
//
//  Created by 이상범 on 2021/02/11.
//

import UIKit

class SearchRecentHeaderView: UIView {
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Recent"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 24)
        
        return label
    }()
    
    private let clearButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Clear", for: .normal)
        button.tintColor = .white
       
        button.addTarget(self, action: #selector(buttonDidTapped), for: .touchUpInside)
        
        return button
    }()
    
    var buttonAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SearchRecentHeaderView {
    func setupView() {
        backgroundColor = .black
    }
    
    func setupLayout() {
        addSubview(titleLabel)
        addSubview(clearButton)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            clearButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            clearButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
}

@objc
private extension SearchRecentHeaderView {
    func buttonDidTapped(_ button: UIButton) {
        buttonAction?()
    }
}
