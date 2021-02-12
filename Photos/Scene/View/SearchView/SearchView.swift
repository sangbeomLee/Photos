//
//  SearchView.swift
//  Photos
//
//  Created by 이상범 on 2021/02/09.
//

import UIKit

private enum Constant {
    static var searchButtonTitle: String { "Search" }
    static var placeHolder: String { "Search" }
}

private enum Design {
    static let radius: CGFloat = 8.0
    static let cancleButtonWidth: CGFloat = 60.0
    static let textFieldFont = UIFont.boldSystemFont(ofSize: 18.0)
    static let searchImage = UIImage(named: "searchIcon")
}

protocol SearchViewDelegate: AnyObject {
    func searchButtonDidTapped(text: String?)
    func textFieldDidChange(text: String?)
}

class SearchView: UIView {
    weak var delegate: SearchViewDelegate?
    
    var text: String? {
        get {
            textField.text
        }
        
        set {
            textField.text = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Make
    
    static func make() -> SearchView {
        let searchView = SearchView()
        searchView.translatesAutoresizingMaskIntoConstraints = false
        
        return searchView
    }
    
    // MARK: - Components
    
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
        stackView.spacing = 10
        
        return stackView
    }()
    
    private var searchAreaView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.clipsToBounds = true
        view.layer.cornerRadius = Design.radius
        
        return view
    }()

    // TODO: - convension 찾아보자.
    private var searchImageView: UIImageView = {
        let imageView = UIImageView(image: Design.searchImage?.withRenderingMode(.alwaysTemplate))
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
                
        return imageView
    }()

    private var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.font = Design.textFieldFont
        textField.textColor = .white
        textField.placeholder = Constant.placeHolder
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        return textField
    }()
    
    private var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constant.searchButtonTitle, for: .normal)
        button.backgroundColor = .blue
        button.clipsToBounds = true
        button.layer.cornerRadius = Design.radius
        button.addTarget(self, action: #selector(buttonDidTapped), for: .touchUpInside)
        
        return button
    }()
}

// MARK: - Setup

private extension SearchView {
    func setupLayout() {
        addSubview(container)
        container.addArrangedSubview(searchAreaView)
        container.addArrangedSubview(searchButton)
        searchAreaView.addSubview(searchContainer)
        searchContainer.addArrangedSubview(searchImageView)
        searchContainer.addArrangedSubview(textField)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            searchContainer.topAnchor.constraint(equalTo: searchAreaView.topAnchor, constant: 2),
            searchContainer.bottomAnchor.constraint(equalTo: searchAreaView.bottomAnchor, constant: -2),
            searchContainer.leadingAnchor.constraint(equalTo: searchAreaView.leadingAnchor, constant: 4),
            searchContainer.trailingAnchor.constraint(equalTo: searchAreaView.trailingAnchor, constant: -4),
            
            searchImageView.widthAnchor.constraint(equalTo: searchImageView.heightAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: Design.cancleButtonWidth)
        ])
    }
}

// MARK: - Objc func

@objc
private extension SearchView {
    func buttonDidTapped(button: UIButton) {
        guard let text = text, !text.isEmpty else { return }
        
        var recentSearchList = UserDefaults.standard.object(forKey: UserDefaultsKeys.recentSearchList) as? [String] ?? []
        recentSearchList.append(text)
        UserDefaults.standard.set(recentSearchList, forKey: UserDefaultsKeys.recentSearchList)

        delegate?.searchButtonDidTapped(text: text)
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        delegate?.textFieldDidChange(text: text)
    }
}
