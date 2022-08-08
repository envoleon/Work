//
//  UIImage+Extension.swift
//  Currency Converter
//
//  Created by Александр Лебедев on 05.08.2022.
//

import UIKit

extension UIImage {
    func resize(_ targetSize: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size:targetSize).image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
}
