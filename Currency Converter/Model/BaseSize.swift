//
//  BaseSize.swift
//  Currency Converter
//
//  Created by Александр Лебедев on 27.07.2022.
//

import UIKit

class BaseSize {

    var scaleWidth: CGFloat?

    let width = 376
    let height = 670

    init (_ width: CGFloat) {
        scaleWidth = Double(width) / Double(self.width)
    }

    func scale(_ size: CGFloat) -> CGFloat {
        scaleWidth! * size
    }
}





