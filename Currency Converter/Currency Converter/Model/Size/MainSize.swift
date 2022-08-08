//
//  MainSize.swift
//  Currency Converter
//
//  Created by Александр Лебедев on 08.08.2022.
//

import UIKit

final class MainSize {

    static let shared = MainSize()
    private let baseSize = BaseSize.shared


    // MARK: - MainView Size

    // exportLabel
    lazy var exportFont: CGFloat = { baseSize.scale(16) }()
    lazy var exportHeight: CGFloat = { baseSize.scale(40) }()


    // MARK: - Keyboard Size

    private var keyWidthButton: CGFloat { floor(baseSize.scale(84)) }
    private var keyLeftRightWidth: CGFloat { floor(baseSize.scale(20)) }
    private var keyTopHeight: CGFloat { baseSize.scale(13) }
    private var keyBottomHeight: CGFloat { baseSize.scale(24) + baseSize.scale(84) - keyWidthButton }

    var keyVerticalWidthSpacing: CGFloat { floor(baseSize.scale(42)) }
    var keyHorizontalWidthSpacing: CGFloat { baseSize.scale(18) + baseSize.scale(84) - keyWidthButton }
    lazy var keyEdgeInsets = UIEdgeInsets(top: keyTopHeight, left: keyLeftRightWidth, bottom: keyBottomHeight, right: keyLeftRightWidth)

    lazy var keyButton: (Int) -> CGSize = { [self] in
        if $0 == 9 {
            return CGSize(width: keyWidthButton * 2 + keyVerticalWidthSpacing, height: keyWidthButton)
        }
        return CGSize(width: keyWidthButton, height: keyWidthButton)
    }

    // MARK: - TableView Size

    // TableViewCell Height
    lazy var cellHeight: CGFloat = { baseSize.scale(101) }()

    // TableView
    lazy var tableHeight: CGFloat = { baseSize.scale(202) }()

    // MARK: - TableViewCell View Size

    // iconCurrencie
    lazy var widthIconImage: CGFloat = { baseSize.scale(46) }()
    lazy var cornerRadiusIcon: CGFloat = { baseSize.scale(48) / 2 }()
    lazy var borderWidthIcon: CGFloat = { baseSize.scale(2)}()
    lazy var widthIcon: CGFloat = { baseSize.scale(48) }()
    lazy var heightIcon: CGFloat = { baseSize.scale(48) }()
    lazy var leadingIcon: CGFloat = { baseSize.scale(21) }()
    lazy var topIcon: CGFloat = { baseSize.scale(21) }()
    // charCode
    lazy var fontCharCode: CGFloat = { baseSize.scale(16) }()
    lazy var bottomCharCode: CGFloat = { baseSize.scale(-8) }()
    // textInput
    lazy var fontTextInput: CGFloat = { baseSize.scale(32) }()
    lazy var trailingTextInput: CGFloat = { baseSize.scale(-19) }()
    // buttonCurrencie: CGFloat = { baseSize.scale(101) }()
    lazy var widthButton: CGFloat = { baseSize.scale(21 + 48 + 21) }()


    private init () {}
}
