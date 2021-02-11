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
    
    private lazy var headerView = SearchRecentHeaderView(frame: tableView.frame)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func make() -> SearchRecentView {
        let recentView = SearchRecentView()
        recentView.translatesAutoresizingMaskIntoConstraints = false
        
        return recentView
    }
}

private extension SearchRecentView {
    func setupView() {
        setupTableView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "recentCell")
    }
    
    func setupLayout() {
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            headerView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

extension SearchRecentView: UITableViewDelegate {}

extension SearchRecentView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    // TODO: Cell 만들어야겠다. cell 누르면 해당 text 가 text 창에 입력 되게 한다.
    // TODO: Cell 밑에 라인 만들기..
    // TODO: custom 하게 바꾸기..
    // TODO: UserDefaults 사용하기..
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recentCell", for: indexPath)
        cell.textLabel?.text = String(indexPath.row)
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
}
