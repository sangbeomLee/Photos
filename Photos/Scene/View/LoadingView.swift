//
//  LoadingView.swift
//  Photos
//
//  Created by 이상범 on 2021/02/11.
//

import UIKit

private enum Constant {
    static var title: String { "Loading..."}
}

class LoadingView: UIView {
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constant.title
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

// MARK: - Setup

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
