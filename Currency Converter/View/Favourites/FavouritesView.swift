//
//  FavouritesView.swift
//  Currency Converter
//
//  Created by Александр Лебедев on 31.07.2022.
//

import UIKit

protocol FavouritesViewDelegate: AnyObject {
    func fetchButtonFavourites()
}

class FavouritesView: UIView {

    private weak var delegate: FavouritesViewDelegate?

    private lazy var button: UIButton = {
        let width = (baseSize?.scale(12.83))!
        let button = UIButton()
        button.backgroundColor = UIColor(named: "ColorOrange")
        button.layer.cornerRadius = (baseSize?.scale(48))! / 2
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(named: "ColorGray6")?.cgColor
        button.setTitle("D", for: .normal)
        button.titleLabel?.font = UIFont(name: "Currency-Converter", size: width)
        button.addTarget(self, action: #selector(self.handleAddCurrencie), for: .touchUpInside)
        return button
    }()

    lazy var currenciesTableView: UITableView = {

        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(named: "ColorGray4")

        return tableView
    }()

    init(delegate: FavouritesViewDelegate?) {
        self.delegate = delegate
        super.init(frame: .zero)

        createUI()
        layout()

        backgroundColor = UIColor(named: "ColorGray6")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createUI() {
        [
            currenciesTableView,
            button
        ].forEach() {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }

    private func layout() {
        let safeArea = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: (baseSize?.scale(48))!),
            button.heightAnchor.constraint(equalToConstant: (baseSize?.scale(48))!),
            button.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -(baseSize?.scale(20))!),
            button.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -(baseSize?.scale(20))!),

            currenciesTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            currenciesTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            currenciesTableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            currenciesTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
    }

    @objc
    private func handleAddCurrencie() {
        delegate?.fetchButtonFavourites()
    }

    func setupTableView(dataSource: UITableViewDataSource, delegate: UITableViewDelegate) {

        currenciesTableView.dataSource = dataSource
        currenciesTableView.delegate = delegate
    }

}
