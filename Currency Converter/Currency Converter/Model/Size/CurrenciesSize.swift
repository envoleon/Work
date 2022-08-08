//
//  CurrenciesSize.swift
//  Currency Converter
//
//  Created by Александр Лебедев on 08.08.2022.
//

import UIKit

final class CurrenciesSize {

    static let shared = CurrenciesSize()
    private let baseSize = BaseSize.shared

    // MARK: - CurrenciesView

    // searchController
    lazy var cornerRadiusSearch: CGFloat = { baseSize.scale(8) }()
    lazy var fontSearch: CGFloat = { baseSize.scale(16) }()


    // MARK: - TableView Size

    // TableViewCell Height
    lazy var cellHeight: CGFloat = { baseSize.scale(48 + 16) }()

    // MARK: - TableViewCell View Size

    // iconCurrencie
    lazy var widthIconImage: CGFloat = { baseSize.scale(46) }()
    lazy var cornerRadiusIcon: CGFloat = { baseSize.scale(48) / 2 }()
    lazy var borderWidthIcon: CGFloat = { baseSize.scale(2)}()
    lazy var widthIcon: CGFloat = { baseSize.scale(48) }()
    lazy var heightIcon: CGFloat = { baseSize.scale(48) }()
    lazy var leadingIcon: CGFloat = { baseSize.scale(21) }()
    lazy var topIcon: CGFloat = { baseSize.scale(21) }()

    // iconFavourite
    lazy var fontFavourite: CGFloat = { baseSize.scale(24) }()
    lazy var widthFavourite: CGFloat = { baseSize.scale(56) }()
    lazy var trailingFavourite: CGFloat = { -baseSize.scale(3) }()

    // nameCurrencie
    lazy var heightName: CGFloat = { baseSize.scale(22) }()
    lazy var leadingName: CGFloat = { baseSize.scale(16) }()
    lazy var trailingName: CGFloat = { -baseSize.scale(16) }()

    // exchangeRate
    lazy var heightRate: CGFloat = { baseSize.scale(21) }()

    private init () {}
}
