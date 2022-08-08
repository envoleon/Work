//
//  BaseSize.swift
//  Currency Converter
//
//  Created by Александр Лебедев on 27.07.2022.
//

import UIKit

final class BaseSize{

    static let shared = BaseSize()

    private var scaleWidth: CGFloat?
    private let width: CGFloat = 376
    private let height: CGFloat = 670

    private init () {}

    func initScale(_ width: CGFloat) {
        scaleWidth = width / self.width
    }

    func scale(_ size: CGFloat) -> CGFloat {
        scaleWidth! * size
    }
}
