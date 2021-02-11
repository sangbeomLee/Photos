//
//  LoadingView.swift
//  Photos
//
//  Created by 이상범 on 2021/02/11.
//

import UIKit

class LoadingView: UIView {
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "NOW LOADING"
        label.textColor = .white
        label.font = .systemFont(ofSize: 24)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupLayout()
    }
}

private extension LoadingView {
    func setupView() {
        backgroundColor = .black
    }
    
    func setupLayout() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
