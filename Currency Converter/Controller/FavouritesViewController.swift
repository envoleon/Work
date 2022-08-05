//
//  FavouritesViewController.swift
//  Currency Converter
//
//  Created by Александр Лебедев on 26.07.2022.
//

import UIKit

class FavouritesViewController: UIViewController {

    private lazy var mainView = FavouritesView(delegate: self)
    var charCode: String?

    override func loadView() {
        super.loadView()
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = UIColor(named: "ColorOrange")
        navigationController?.setNavigationBarHidden(false, animated: true)
        mainView.setupTableView(dataSource: self, delegate: self)
        title = "Favourites"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.currenciesTableView.reloadData()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        charCode = nil
    }
}

// MARK: - FavouritesViewDelegate

extension FavouritesViewController: FavouritesViewDelegate {

    func fetchButtonFavourites() {

        let viewController = CurrenciesViewController()
        
        if let text = charCode {

            viewController.charCode = text
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension FavouritesViewController: UITableViewDataSource, CellCurrencyDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favouritesCurrencieTables!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CurrenciesTableViewCell()
        cell.currencieTable = favouritesCurrencieTables![indexPath.row]
        cell.delegate = self
        cell.createUI()
        cell.layout()
        return cell
    }

    func fetchTableCellFavourites() {
        mainView.currenciesTableView.reloadData()
    }
}

// MARK: - UITableViewDelegate

extension FavouritesViewController: UITableViewDelegate {

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
