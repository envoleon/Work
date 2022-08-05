//
//  CurrenciesLabel.swift
//  Currency Converter
//
//  Created by Александр Лебедев on 30.07.2022.
//

import UIKit


class CurrenciesView: UIView {

    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: .none)
        searchController.isActive = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.searchTextField.font = UIFont.systemFont(ofSize: (baseSize?.scale(16))!)
        searchController.searchBar.searchTextField.layer.cornerRadius = (baseSize?.scale(8))!

        searchController.searchBar.searchTextField.backgroundColor = UIColor(named: "ColorGray3")

        searchController.searchBar.searchTextField.leftView?.tintColor = UIColor(named: "ColorOrange")
        return searchController
    }()

    lazy var currenciesTableView: UITableView = {

        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(named: "ColorGray4")

        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        createUI()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createUI() {
        [
            currenciesTableView
        ].forEach(){
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }

    private func layout() {

        let safeArea = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            currenciesTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            currenciesTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            currenciesTableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            currenciesTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
    }

    func setupSearchController(searchResultsUpdater: UISearchResultsUpdating) {
        searchController.searchResultsUpdater = searchResultsUpdater
        
    }

    func setupTableView(dataSource: UITableViewDataSource, delegate: UITableViewDelegate) {

        currenciesTableView.dataSource = dataSource
        currenciesTableView.delegate = delegate
    }

}

extension CurrenciesView: CellCurrencyDelegate {
    func fetchTableCellFavourites() {
        currenciesTableView.reloadData()
    }
}
