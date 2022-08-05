//
//  CurrenciesViewController.swift
//  Currency Converter
//
//  Created by Александр Лебедев on 30.07.2022.
//

import UIKit

class CurrenciesViewController: UIViewController {


    lazy var mainView = CurrenciesView()
    var charCode: String?

    private let nc = NotificationCenter.default

    private var isFiltering: Bool {
        return mainView.searchController.isActive && !mainView.searchBarIsEmpty
    }

    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.setupTableView(dataSource: self, delegate: self)
        mainView.setupSearchController(searchResultsUpdater: self)
        navigationItem.searchController = mainView.searchController
        definesPresentationContext = true

        title = "Currencies"
        view.backgroundColor = UIColor(named: "ColorGray6")
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = UIColor(named: "ColorOrange")
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.currenciesTableView.reloadData()
        nc.addObserver(self, selector: #selector(kdbShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(kdbHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        nc.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)

        charCode = nil
    }

    @objc
    private func kdbShow(notification: NSNotification) {
        if let kbdSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {

            let edgeInsets: UIEdgeInsets = .init(top: 0, left: 0, bottom: kbdSize.height - view.safeAreaInsets.bottom, right: 0)
            mainView.currenciesTableView.contentInset = edgeInsets
            mainView.currenciesTableView.scrollIndicatorInsets = edgeInsets
        }
    }

    @objc
    private func kdbHide() {
        mainView.currenciesTableView.contentInset = .zero
        mainView.currenciesTableView.verticalScrollIndicatorInsets = .zero
    }
}

// MARK: - UISearchResultsUpdating

extension CurrenciesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }

    private func filterContentForSearchText(_ searchText: String) {

        let startSearchTables = currencieTables!.filter({ (currencie: CurrencieTable) -> Bool in
            return currencie.name.lowercased().starts(with: searchText.lowercased())
        })

        let endSearchTables = currencieTables!.filter({ (currencie: CurrencieTable) -> Bool in
            return !currencie.name.lowercased().starts(with: searchText.lowercased())
        })

        filteredCurrencieTables = endSearchTables.filter({ (currencie: CurrencieTable) -> Bool in
            return currencie.name.lowercased().contains(searchText.lowercased())
        })

        filteredCurrencieTables! = startSearchTables + filteredCurrencieTables!
        mainView.currenciesTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension CurrenciesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCurrencieTables!.count
        }
        return currencieTables!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CurrenciesTableViewCell()
        cell.currencieTable = isFiltering ? filteredCurrencieTables![indexPath.row] : currencieTables![indexPath.row]
        cell.delegate = self
        cell.createUI()
        cell.layout()
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CurrenciesViewController: UITableViewDelegate, CellCurrencyDelegate {
    func fetchTableCellFavourites() {
        mainView.currenciesTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        (48 + 16) * scaleWidth!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if charCode != nil {
            let currentCell = tableView.cellForRow(at: indexPath) as! CurrenciesTableViewCell

            for i in 0..<inputCurrencieTables!.count {

                if inputCurrencieTables![i].table.charCode == charCode {
                    let other = (i != 0) ? 0 : 1

                    if inputCurrencieTables![other].table.charCode == currentCell.currencieTable!.charCode {
                        inputCurrencieTables![other].table = inputCurrencieTables![i].table
                    }
                    inputCurrencieTables![i].table = currentCell.currencieTable!
                    navigationController?.popToRootViewController(animated: true)
                    break
                }
            }
        }
    }
}


