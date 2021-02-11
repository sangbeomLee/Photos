//
//  SearchRecentView.swift
//  Photos
//
//  Created by 이상범 on 2021/02/11.
//

import UIKit

class SearchRecentView: UIView {
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    private lazy var headerView = SearchRecentHeaderView()
    
    private var searchList: [String] {
        UserDefaults.standard.object(forKey: "recentSearchList") as? [String] ?? []
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupLayout()
        headerView.buttonAction = setClearButtonAction
    }
    
    var recentCellAction: ((_ text: String) -> Void)?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func make() -> SearchRecentView {
        let recentView = SearchRecentView()
        recentView.translatesAutoresizingMaskIntoConstraints = false
        
        return recentView
    }
    
    func show(_ isShowing: Bool) {
        if isShowing {
            tableView.reloadData()
            isHidden = false
        } else {
            isHidden = true
        }
    }
}

private extension SearchRecentView {
    func setupView() {
        setupTableView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchRecentTableViewCell.self, forCellReuseIdentifier: "SearchRecentTableViewCell")
        tableView.rowHeight = 40
    }
    
    func setupLayout() {
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    func setClearButtonAction() {
        UserDefaults.standard.removeObject(forKey: "recentSearchList")
        tableView.reloadData()
    }
}

extension SearchRecentView: UITableViewDelegate {}

extension SearchRecentView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recentCellAction?(searchList[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchList.count
    }
    
    // TODO: UserDefaults 사용하기..
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchRecentTableViewCell", for: indexPath) as? SearchRecentTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: searchList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
}
