//
//  Style.swift
//  DiscourseClient
//
//  Created by Ivan Llopis Guardado on 29/05/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//


import UIKit


extension UIColor {

  @nonobjc class var tangerine: UIColor {
    return UIColor(red: 243.0 / 255.0, green: 144.0 / 255.0, blue: 0.0, alpha: 1.0)
  }

  @nonobjc class var pumpkin: UIColor {
    return UIColor(red: 221.0 / 255.0, green: 99.0 / 255.0, blue: 0.0, alpha: 1.0)
  }

  @nonobjc class var brownGrey: UIColor {
    return UIColor(white: 135.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var white82: UIColor {
    return UIColor(white: 248.0 / 255.0, alpha: 0.82)
  }

  @nonobjc class var white: UIColor {
    return UIColor(white: 246.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var black: UIColor {
    return UIColor(white: 12.0 / 255.0, alpha: 1.0)
  }

}

extension UIFont {

    class var degradado: UIFont {
        return UIFont(name: "Monaco", size: 60.0)!
    }

    class var largeTitle2Bold1Light1LabelColor1LeftAligned: UIFont {
        return UIFont.systemFont(ofSize: 34.0, weight: .bold)
    }

    class var textStyle4: UIFont {
        return UIFont.systemFont(ofSize: 22.0, weight: .bold)
    }

    class var textStyle5: UIFont {
        return UIFont.systemFont(ofSize: 17.0, weight: .semibold)
    }

    class var style27: UIFont {
        return UIFont.systemFont(ofSize: 17.0, weight: .semibold)
    }

    class var titularPequeO: UIFont {
        return UIFont.systemFont(ofSize: 16.0, weight: .semibold)
    }

    class var avatar: UIFont {
        return UIFont.systemFont(ofSize: 15.0, weight: .medium)
    }

    class var textStyle: UIFont {
        return UIFont.systemFont(ofSize: 15.0, weight: .regular)
    }

    class var textStyle3: UIFont {
        return UIFont.systemFont(ofSize: 14.0, weight: .bold)
    }

    class var textoPequeO: UIFont {
        return UIFont.systemFont(ofSize: 12.0, weight: .medium)
    }

    class var menu: UIFont {
        return UIFont.systemFont(ofSize: 11.0, weight: .medium)
    }

    class var textStyle7: UIFont {
        return UIFont.systemFont(ofSize: 14.0, weight: .regular)
    }
    
    class var textStyle2: UIFont {
      return UIFont.systemFont(ofSize: 14.0, weight: .bold)
    }
    
    class var textStyle8: UIFont {
      return UIFont.systemFont(ofSize: 17.0, weight: .regular)
    }

}
