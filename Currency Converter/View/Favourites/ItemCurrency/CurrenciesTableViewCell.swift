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
    var currencieTable: CurrencieTable?

    private lazy var iconCurrencie: UIImageView = {

        var image = UIImage(named: currencieTable!.charCode)
        let width = (46 * scaleWidth!) / (image?.size.height)! * (image?.size.width)!
        image = image!.resize(CGSize(width: width, height: 46 * scaleWidth!))
        let imageView = UIImageView(image: image)
        imageView.layer.cornerRadius = 48 * scaleWidth! / 2
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 2 * scaleWidth!
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

        button.titleLabel?.font = UIFont(name: "Currency-Converter", size: 24 * scaleWidth!)
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
            iconCurrencie.widthAnchor.constraint(equalToConstant: (baseSize?.scale(48))!),
            iconCurrencie.heightAnchor.constraint(equalToConstant: (baseSize?.scale(48))!),
            iconCurrencie.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: (baseSize?.scale(21))!),
            iconCurrencie.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            nameCurrencie.heightAnchor.constraint(equalToConstant: (baseSize?.scale(22))!),
            nameCurrencie.leadingAnchor.constraint(equalTo: iconCurrencie.trailingAnchor, constant: (baseSize?.scale(16))!),
            nameCurrencie.trailingAnchor.constraint(equalTo: exchangeRate.leadingAnchor, constant: -(baseSize?.scale(16))!),
            nameCurrencie.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            exchangeRate.heightAnchor.constraint(equalToConstant: (baseSize?.scale(21))!),
            exchangeRate.trailingAnchor.constraint(equalTo: iconFavourite.leadingAnchor),
            exchangeRate.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            iconFavourite.widthAnchor.constraint(equalToConstant: (baseSize?.scale(56))!),
            iconFavourite.topAnchor.constraint(equalTo: contentView.topAnchor),
            iconFavourite.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            iconFavourite.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -(baseSize?.scale(3))!),
            iconFavourite.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }

    @objc
    private func handleAddFavourite() {

        for i in 0..<currencieTables!.count {
            if currencieTables![i].name == currencieTable?.name {
                if currencieTables![i].isFavourite {
                    iconFavourite.setTitle("B", for: .normal)
                    iconFavourite.setTitleColor(UIColor.white, for: .normal)
                    currencieTables![i].isFavourite = false
                } else {
                    iconFavourite.setTitle("F", for: .normal)
                    iconFavourite.setTitleColor(UIColor(named: "ColorOrange"), for: .normal)
                    currencieTables![i].isFavourite = true
                }
            }
        }

        favouritesCurrencieTables = currencieTables!.filter{ $0.isFavourite }

        var names: [String] = []
        for i in favouritesCurrencieTables! {
            names.append(i.name)
        }

        UserDefaults.standard.set(names, forKey: "favourites")

        delegate?.fetchTableCellFavourites()

    }

}

