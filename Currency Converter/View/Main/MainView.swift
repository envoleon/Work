//
//  MainView.swift
//  Currency Converter
//
//  Created by Александр Лебедев on 31.07.2022.
//

import UIKit

protocol MainViewDelegate: AnyObject {
    func fetchButtonTapped()
}

class MainView: UIView {

    private weak var delegate: MainViewDelegate?

    lazy var inputTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(named: "ColorGray3")
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    lazy var exportLabel: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: (baseSize?.scale(16))!)
        textView.text = calcCurrency()
        textView.textColor = UIColor(named: "ColorGreen")
        textView.textAlignment = .center
        textView.backgroundColor = UIColor(named: "ColorGray1")
        textView.isEditable = false
        let deadSpace = textView.bounds.size.height - textView.contentSize.height
        let inset = max(0, deadSpace/2.0)
        textView.contentInset = UIEdgeInsets(top: inset, left: textView.contentInset.left, bottom: inset, right: textView.contentInset.right)
        return textView
    }()

    private lazy var keyboardCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(KeyboardCollectionViewCell.self, forCellWithReuseIdentifier: KeyboardCollectionViewCell.idintifier)
        collectionView.backgroundColor = UIColor(named: "ColorGray4")
        collectionView.isScrollEnabled = false
        return collectionView
    }()

    init(delegate: MainViewDelegate?) {
        self.delegate = delegate
        super.init(frame: .zero)

        createUI()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createUI() {
        [
            inputTableView,
            exportLabel,
            keyboardCollectionView
        ].forEach(){
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }

    private func layout() {

        let safeArea = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            inputTableView.heightAnchor.constraint(equalToConstant: (baseSize?.scale(202))!),
            inputTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            inputTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            inputTableView.topAnchor.constraint(equalTo: safeArea.topAnchor),

            exportLabel.heightAnchor.constraint(equalToConstant: (baseSize?.scale(40))!),
            exportLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            exportLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            exportLabel.topAnchor.constraint(equalTo: inputTableView.bottomAnchor),

            keyboardCollectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            keyboardCollectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            keyboardCollectionView.topAnchor.constraint(equalTo: exportLabel.bottomAnchor),
            keyboardCollectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
    }

    func setupCollectionView(dataSource: UICollectionViewDataSource, delegate: UICollectionViewDelegate) {

        keyboardCollectionView.dataSource = dataSource
        keyboardCollectionView.delegate = delegate
    }

    func setupTableView(dataSource: UITableViewDataSource, delegate: UITableViewDelegate) {

        inputTableView.dataSource = dataSource
        inputTableView.delegate = delegate
    }

}
