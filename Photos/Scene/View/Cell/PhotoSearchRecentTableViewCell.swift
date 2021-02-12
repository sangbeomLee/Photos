//
//  SearchRecentTableViewCell.swift
//  Photos
//
//  Created by 이상범 on 2021/02/11.
//

import UIKit

private enum Design {
    static let cellTextSize: CGFloat = 18.0
    static let lineThickness: CGFloat = 1.0
    static let lineSpace: CGFloat = 15.0
}

class PhotoSearchRecentTableViewCell: UITableViewCell {
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

// MARK: - Setup

private extension PhotoSearchRecentTableViewCell {
    func setupView() {
        textLabel?.textColor = .white
        textLabel?.font = .boldSystemFont(ofSize: Design.cellTextSize)
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    func setupLayout() {
        contentView.addSubview(lineView)
        
        NSLayoutConstraint.activate([
            lineView.heightAnchor.constraint(equalToConstant: Design.lineThickness),
            lineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            lineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Design.lineSpace),
            lineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Design.lineSpace),
        ])
    }
}
