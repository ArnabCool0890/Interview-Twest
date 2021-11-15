//
//  Constant.swift
//  TestAssignment
//
//  Created by Arnab Maity on 14/11/21.
//

import Foundation
import UIKit

let APPBARBGCOLOR = hexStringToUIColor(hex: Bundle.main.object(forInfoDictionaryKey: "BARBGCOLOR") as? String ?? "#007AFF")
let APPBARCOLOR = hexStringToUIColor(hex: Bundle.main.object(forInfoDictionaryKey: "BARCOLOR") as? String ?? "#ffffff")
struct Constants {
    
    static let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)


}

func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if cString.hasPrefix("#") {
        cString.remove(at: cString.startIndex)
    }
    
    if cString.count != 6 {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
