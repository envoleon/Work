//
//  CurrenciesTableViewCell.swift
//  Currency Converter
//
//  Created by Александр Лебедев on 01.08.2022.
//

import UIKit

protocol CellCurrencyDelegate: AnyObject {
    func fetchTableCellFavourites()
}

class CurrenciesTableViewCell: UITableViewCell {

    weak var delegate: CellCurrencyDelegate?
    private let currenciesSize = CurrenciesSize.shared
    private var currencieTables = CurrencieTables.shared
    var currencieTable: CurrencieTables.CurrencieTable?

    private lazy var iconCurrencie: UIImageView = {

        var image = UIImage(named: currencieTable!.charCode)
        let width = currenciesSize.widthIconImage / (image?.size.height)! * (image?.size.width)!
        image = image!.resize(CGSize(width: width, height: currenciesSize.widthIconImage))
        let imageView = UIImageView(image: image)
        imageView.layer.cornerRadius = currenciesSize.cornerRadiusIcon
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = currenciesSize.borderWidthIcon
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.backgroundColor = UIColor.white.cgColor
        return imageView
    }()

    private lazy var nameCurrencie: UILabel = {
        let label = UILabel()
        label.text = currencieTable?.name
        return label
    }()

    private lazy var exchangeRate: UILabel = {
        let label = UILabel()
        label.text = "\(round(currencieTable!.value / Float(currencieTable!.nominal) * 100)/100) RUB"
        label.textColor = UIColor(named: "ColorGreen")
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    }()

    private lazy var iconFavourite: UIButton = {
        let button = UIButton()

        if currencieTable!.isFavourite {
            button.setTitle("F", for: .normal)
            button.setTitleColor(UIColor(named: "ColorOrange"), for: .normal)
        } else {
            button.setTitle("B", for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
        }

        button.titleLabel?.font = UIFont(name: "Currency-Converter", size: currenciesSize.fontFavourite)
        button.addTarget(self, action: #selector(self.handleAddFavourite), for: .touchUpInside)

        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = UIColor(named: "ColorGray6")
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(named: "ColorGray6")
        selectedBackgroundView = bgColorView

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createUI() {
        [
            iconCurrencie,
            nameCurrencie,
            exchangeRate,
            iconFavourite
        ].forEach(){
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }

    func layout() {


        NSLayoutConstraint.activate([
            iconCurrencie.widthAnchor.constraint(equalToConstant: currenciesSize.widthIcon),
            iconCurrencie.heightAnchor.constraint(equalToConstant: currenciesSize.heightIcon),
            iconCurrencie.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: currenciesSize.leadingIcon),
            iconCurrencie.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            nameCurrencie.heightAnchor.constraint(equalToConstant: currenciesSize.heightName),
            nameCurrencie.leadingAnchor.constraint(equalTo: iconCurrencie.trailingAnchor, constant: currenciesSize.leadingName),
            nameCurrencie.trailingAnchor.constraint(equalTo: exchangeRate.leadingAnchor, constant: currenciesSize.trailingName),
            nameCurrencie.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            exchangeRate.heightAnchor.constraint(equalToConstant: currenciesSize.heightRate),
            exchangeRate.trailingAnchor.constraint(equalTo: iconFavourite.leadingAnchor),
            exchangeRate.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconFavourite.widthAnchor.constraint(equalToConstant: currenciesSize.widthFavourite),
            iconFavourite.topAnchor.constraint(equalTo: contentView.topAnchor),
            iconFavourite.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            iconFavourite.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: currenciesSize.trailingFavourite),
            iconFavourite.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }

    @objc
    private func handleAddFavourite() {

        for i in 0..<currencieTables.currencie!.count {
            if currencieTables.currencie![i].name == currencieTable?.name {
                if currencieTables.currencie![i].isFavourite {
                    iconFavourite.setTitle("B", for: .normal)
                    iconFavourite.setTitleColor(UIColor.white, for: .normal)
                    currencieTables.currencie![i].isFavourite = false
                } else {
                    iconFavourite.setTitle("F", for: .normal)
                    iconFavourite.setTitleColor(UIColor(named: "ColorOrange"), for: .normal)
                    currencieTables.currencie![i].isFavourite = true
                }
            }
        }

        currencieTables.favourites = currencieTables.currencie!.filter{ $0.isFavourite }

        var names: [String] = []
        for i in currencieTables.favourites! {
            names.append(i.name)
        }

        UserDefaults.standard.set(names, forKey: "favourites")

        delegate?.fetchTableCellFavourites()

    }

}

