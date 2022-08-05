//
//  KeyboardCollectionViewCell.swift
//  Currency Converter
//
//  Created by Александр Лебедев on 26.07.2022.
//

import UIKit

protocol CollectionViewDelegate: AnyObject {}

class KeyboardCollectionViewCell: UICollectionViewCell {

    var delegate: CollectionViewDelegate?

    var symbol: String?
    var sizeSymbol: CGSize?

    private lazy var text: UILabel = {

        let font = UIFont.systemFont(ofSize: frame.height / 2)

        let fontAttributes = [NSAttributedString.Key.font: font]
        sizeSymbol = (symbol! as NSString).size(withAttributes: fontAttributes as [NSAttributedString.Key : Any])

        let label = UILabel()
        label.text = symbol
        label.font = font
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)

        backgroundColor = UIColor(named: "ColorGray5")
        layer.cornerRadius = frame.height / 2
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createUI() {
        [
            text
        ].forEach(){
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }

    func layout() {
        NSLayoutConstraint.activate([
            text.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            text.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: (frame.height - sizeSymbol!.width) / 2)
        ])
    }

}
