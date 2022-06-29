//
//  Extensions.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 25/06/22.
//

import Foundation
import UIKit

extension UILabel{
    func setPokemonTitle(){
        guard let customFont = UIFont(name: "Pokemon Solid", size: 40) else {
            fatalError("""
                Failed to load the "Pokemon Hollow" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        self.font = UIFontMetrics(forTextStyle: .largeTitle).scaledFont(for: customFont)
        self.adjustsFontForContentSizeCategory = true
    }
}

extension Encodable {
    func asDictionary() throws -> [String: Any] {
      let data = try JSONEncoder().encode(self)
      guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
        throw NSError()
      }
      return dictionary
    }
}

extension UIView{
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 13, scale: Bool = true) {
        self.layer.cornerRadius = 6.0
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
