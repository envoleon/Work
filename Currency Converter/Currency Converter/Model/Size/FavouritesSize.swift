//
//  FavouritesSize.swift
//  Currency Converter
//
//  Created by Александр Лебедев on 08.08.2022.
//

import UIKit

final class FavouritesSize {

    static let shared = FavouritesSize()
    private let baseSize = BaseSize.shared

    // MARK: - FavouritesView

    // button
    lazy var fontButton: CGFloat = { baseSize.scale(12.83) }()
    lazy var cornerRadiusButton: CGFloat = { baseSize.scale(48) / 2 }()
    lazy var widthButton: CGFloat = { baseSize.scale(48) }()
    lazy var heightButton: CGFloat = { baseSize.scale(48) }()
    lazy var trailingButton: CGFloat = { -baseSize.scale(20) }()
    lazy var bottomButton: CGFloat = { -baseSize.scale(20) }()

    // MARK: - TableView Size

    // TableViewCell Height
    lazy var cellHeight: CGFloat = { baseSize.scale(48 + 16) }()


    private init () {}
}
