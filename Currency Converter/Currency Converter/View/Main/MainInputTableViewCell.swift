//
//  MainInputLabel.swift
//  Currency Converter
//
//  Created by Александр Лебедев on 26.07.2022.
//

import UIKit

protocol MainInputTableViewDelegate: AnyObject {
    func buttonUpInside(_ charCode: String)
}

class MainInputTableViewCell: UITableViewCell {

    var delegate: MainInputTableViewDelegate?
    var inputCurrencieTable: CurrencieTables.InputTableSetting?
    private let mainSize = MainSize.shared

    private lazy var iconCurrencie: UIImageView = {
        var image = UIImage(named: inputCurrencieTable!.table.charCode)
        let width = mainSize.widthIconImage / (image?.size.height)! * (image?.size.width)!
        image = image!.resize(CGSize(width: width, height: mainSize.widthIconImage))
        let imageView = UIImageView(image: image)
        imageView.layer.cornerRadius = mainSize.cornerRadiusIcon
        imageView.layer.borderColor = inputCurrencieTable!.isCurrent ? UIColor(named: "ColorOrange")?.cgColor : UIColor.white.cgColor

        imageView.layer.borderWidth = mainSize.borderWidthIcon
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.backgroundColor = UIColor.white.cgColor
        return imageView
    }()

    private lazy var charCode: UILabel = {
        let label = UILabel()
        label.text = inputCurrencieTable!.table.charCode
        label.font = UIFont.systemFont(ofSize: mainSize.fontCharCode)
        label.textColor = inputCurrencieTable!.isCurrent ? UIColor(named: "ColorOrange") : .white
        return label
    }()

    private lazy var buttonCurrencie: UIButton = {
        let button = UIButton()
        [
            iconCurrencie,
            charCode
        ].forEach(){
            $0.translatesAutoresizingMaskIntoConstraints = false
            button.addSubview($0)
        }
        button.addTarget(self, action: #selector(handleAddCurrencie), for: .touchUpInside)
        return button
    }()


    lazy var textInput: UILabel = {
        let label = UILabel()
        label.text = String(inputCurrencieTable!.num)
        label.font = UIFont.systemFont(ofSize: mainSize.fontTextInput)
        label.textColor = inputCurrencieTable!.isCurrent ? UIColor(named: "ColorOrange") : .white
        return label
    }()

    private let borderLabel: UILabel = {
        let label = UILabel()
        label.layer.backgroundColor = UIColor(named: "ColorGray7")?.cgColor
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let bgColorView = UIView()
        bgColorView.backgroundColor = .none
        selectedBackgroundView = bgColorView
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createUI() {
        [
            buttonCurrencie,
            textInput,
            borderLabel
        ].forEach(){
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }

    func layout() {
        NSLayoutConstraint.activate([

            buttonCurrencie.widthAnchor.constraint(equalToConstant: mainSize.widthButton),
            buttonCurrencie.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            buttonCurrencie.topAnchor.constraint(equalTo: contentView.topAnchor),
            buttonCurrencie.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            iconCurrencie.widthAnchor.constraint(equalToConstant: mainSize.widthIcon),
            iconCurrencie.heightAnchor.constraint(equalToConstant: mainSize.heightIcon),
            iconCurrencie.leadingAnchor.constraint(equalTo: buttonCurrencie.leadingAnchor, constant: mainSize.leadingIcon),
            iconCurrencie.topAnchor.constraint(equalTo: buttonCurrencie.topAnchor, constant: mainSize.topIcon),

            charCode.bottomAnchor.constraint(equalTo: buttonCurrencie.bottomAnchor, constant: mainSize.bottomCharCode),
            charCode.centerXAnchor.constraint(equalTo: iconCurrencie.centerXAnchor),

            textInput.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: mainSize.trailingTextInput),
            textInput.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            borderLabel.heightAnchor.constraint(equalToConstant: 1),
            borderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            borderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            borderLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

    @objc
    private func handleAddCurrencie() {
        delegate?.buttonUpInside(inputCurrencieTable!.table.charCode)
    }
}
