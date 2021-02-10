//
//  SearchView.swift
//  Photos
//
//  Created by 이상범 on 2021/02/09.
//

import UIKit

protocol SearchViewDelegate: AnyObject {
    func searchButtonDidTapped(text: String?)
}

class SearchView: UIView {
    weak var delegate: SearchViewDelegate?
    
    var text: String? {
        textField.text
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func make() -> SearchView {
        let searchView = SearchView()
        searchView.translatesAutoresizingMaskIntoConstraints = false
        
        return searchView
    }
    
    // MARK: - components
    
    private var container: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        
        return stackView
    }()
    
    private var searchContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private var searchAreaView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        
        return view
    }()

    // TODO: - convension 찾아보자.
    private var searchImageView: UIImageView = {
       let imageView = UIImageView(image: UIImage(named: "search"))
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    // TODO: - place holder
    // TODO: - 가운데 정렬하기
    // TODO: - TextFiled 로 변경 해야할지..?
    private var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.font = .systemFont(ofSize: 20)
        textField.textColor = .white
        textField.placeholder = "Search"
        
        return textField
    }()
    
    private var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        button.backgroundColor = .blue
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(buttonDidTapped), for: .touchUpInside)
        
        return button
    }()
}

private extension SearchView {
    func setupLayout() {
        addSubview(container)
        container.addArrangedSubview(searchAreaView)
        container.addArrangedSubview(searchButton)
        searchAreaView.addSubview(searchContainer)
        searchContainer.addArrangedSubview(searchImageView)
        searchContainer.addArrangedSubview(textField)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3),
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            searchContainer.topAnchor.constraint(equalTo: searchAreaView.topAnchor, constant: 2),
            searchContainer.bottomAnchor.constraint(equalTo: searchAreaView.bottomAnchor, constant: -2),
            searchContainer.leadingAnchor.constraint(equalTo: searchAreaView.leadingAnchor, constant: 4),
            searchContainer.trailingAnchor.constraint(equalTo: searchAreaView.trailingAnchor, constant: -4),
            
            searchImageView.widthAnchor.constraint(equalTo: searchImageView.heightAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
}

private extension SearchView {
    @objc
    func buttonDidTapped(button: UIButton) {
        delegate?.searchButtonDidTapped(text: text)
    }
}

extension SearchView: UITextFieldDelegate {
    
}
