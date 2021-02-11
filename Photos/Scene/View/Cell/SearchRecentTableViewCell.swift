//
//  SearchRecentTableViewCell.swift
//  Photos
//
//  Created by 이상범 on 2021/02/11.
//

import UIKit

class SearchRecentTableViewCell: UITableViewCell {
    private let lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupLayout()
        layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with text: String) {
        textLabel?.text = text
    }
}

private extension SearchRecentTableViewCell {
    func setupView() {
        textLabel?.textColor = .white
        textLabel?.font = .boldSystemFont(ofSize: 18)
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    func setupLayout() {
        contentView.addSubview(lineView)
        
        NSLayoutConstraint.activate([
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            lineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            lineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
        ])
    }
}
