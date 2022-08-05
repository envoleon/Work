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
        mainView.exportLabel.text = calcCurrency()
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
        for i in 0..<inputCurrencieTables!.count {
            if inputCurrencieTables![i].isCurrent {

                if !(inputCurrencieTables![i].num.contains(".") && keyboardList.keyArray[indexPath.item] == ".") {
                    //let other = (i != 0) ? 0 : 1
                    inputCurrencieTables![i].num = inputCurrencieTables![i].num + keyboardList.keyArray[indexPath.item]
                    mainView.exportLabel.text = calcCurrency()
                    mainView.inputTableView.reloadData()
                    break
                }
            }
        }
    }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDelegateFlowLayout {

    private var widthButton: CGFloat { floor((baseSize?.scale(84))!) }
    private var leftRightWidth: CGFloat { floor((baseSize?.scale(20))!) }
    private var topHeight: CGFloat { (baseSize?.scale(13))! }
    private var bottomHeight: CGFloat { (baseSize?.scale(24))! + (baseSize?.scale(84))! - widthButton }
    private var verticalWidthSpacing: CGFloat { floor((baseSize?.scale(42))!) }
    private var horizontalWidthSpacing: CGFloat { (baseSize?.scale(18))! + (baseSize?.scale(84))! - widthButton }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if indexPath.item == 9 {
            return CGSize(width: widthButton * 2 + verticalWidthSpacing, height: widthButton)
        }

        return CGSize(width: widthButton, height: widthButton)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       horizontalWidthSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        verticalWidthSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: topHeight, left: leftRightWidth, bottom: bottomHeight, right: leftRightWidth)
    }

}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource, MainInputTableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MainInputTableViewCell()

        cell.inputCurrencieTable = inputCurrencieTables![indexPath.row]
        cell.contentView.backgroundColor = inputCurrencieTables![indexPath.row].isCurrent ? UIColor(named: "ColorGray4") : UIColor(named: "ColorGray3")
        cell.delegate = self
        cell.createUI()
        cell.layout()
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let outher = (indexPath.row != 0) ? 0 : 1
        inputCurrencieTables![outher].isCurrent = false
        inputCurrencieTables![indexPath.row].isCurrent = true
        mainView.exportLabel.text = calcCurrency()
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
        (baseSize?.scale(101))!
    }
}
