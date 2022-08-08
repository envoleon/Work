//
//  MainViewController.swift
//  Currency Converter
//
//  Created by Александр Лебедев on 26.07.2022.
//

import UIKit

class MainViewController: UIViewController {

    private let nc = NotificationCenter.default
    private lazy var mainView = MainView(delegate: self)
    private let mainSize = MainSize.shared
    private var currencieTables = CurrencieTables.shared


    let keyboardList = KeyboardList()

    override func loadView() {
        super.loadView()
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.setupCollectionView(dataSource: self, delegate: self)
        mainView.setupTableView(dataSource: self, delegate: self)


        view.backgroundColor = UIColor(named: "ColorOrange")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        mainView.inputTableView.reloadData()
        mainView.exportLabel.text = currencieTables.calcCurrency()
    }

}

// MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource, CollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        11
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyboardCollectionViewCell.idintifier, for: indexPath) as! KeyboardCollectionViewCell

        cell.symbol = keyboardList.keyArray[indexPath.item]
        cell.delegate = self

        cell.createUI()
        cell.layout()
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for i in 0..<currencieTables.inputCurrencie!.count {
            if currencieTables.inputCurrencie![i].isCurrent {

                let isContainsDot = currencieTables.inputCurrencie![i].num.contains(".")
                let isAddDot = keyboardList.keyArray[indexPath.item] == "."

                if !(isContainsDot && isAddDot) {

                    let numFloat = Float(currencieTables.inputCurrencie![i].num)!

                    if !isAddDot {
                        let item = Int(keyboardList.keyArray[indexPath.item])!
                        currencieTables.inputCurrencie![i].num = (isContainsDot || isAddDot) ? currencieTables.inputCurrencie![i].num + String(item) : String(Int(numFloat) * 10 + item)

                    } else {
                        currencieTables.inputCurrencie![i].num += keyboardList.keyArray[indexPath.item]
                    }

                    mainView.exportLabel.text = currencieTables.calcCurrency()
                    mainView.inputTableView.reloadData()
                    break
                }
            }
        }
    }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        mainSize.keyButton(indexPath.item)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        mainSize.keyHorizontalWidthSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        mainSize.keyVerticalWidthSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        mainSize.keyEdgeInsets
    }

}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource, MainInputTableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MainInputTableViewCell()

        cell.inputCurrencieTable = currencieTables.inputCurrencie![indexPath.row]
        cell.contentView.backgroundColor = currencieTables.inputCurrencie![indexPath.row].isCurrent ? UIColor(named: "ColorGray4") : UIColor(named: "ColorGray3")
        cell.delegate = self
        cell.createUI()
        cell.layout()
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let outher = (indexPath.row != 0) ? 0 : 1
        currencieTables.inputCurrencie![outher].isCurrent = false
        currencieTables.inputCurrencie![indexPath.row].isCurrent = true
        mainView.exportLabel.text = currencieTables.calcCurrency()
        tableView.reloadData()
    }

    func buttonUpInside(_ charCode: String) {
        let viewController = FavouritesViewController()
        viewController.charCode = charCode
        navigationController?.pushViewController(viewController, animated: true)
    }

}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate, MainViewDelegate {

    func fetchButtonTapped() {
        mainView.inputTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        mainSize.cellHeight
    }
}
