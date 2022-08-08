//
//  LoadSize.swift
//  Currency Converter
//
//  Created by Александр Лебедев on 08.08.2022.
//

import UIKit

final class LoadSize {

    static let shared = LoadSize()
    private let baseSize = BaseSize.shared

    lazy var font: CGFloat = { baseSize.scale(24) }()

    private init () {}
}
