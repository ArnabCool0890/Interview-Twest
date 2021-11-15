//
//  Helper.swift
//  NBA
//
//  Created by HiteshDhawan on 12/04/16.
//  Copyright © 2016 Neuronimbus. All rights reserved.
//

import UIKit
import SystemConfiguration
import Foundation

//import 'CommonCrypto/CommonDigest.h'

class Helper: NSObject {

    static func getDateString() -> String {
        let formatter = DateFormatter.init()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return formatter.string(from: Date.init())
    }
    
    
    static func isValidEmail(_ emailString:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailString)
    }
    
    static  func isValidPhoneNumber(phoneNumber: String) -> Bool {

        let PHONE_REGEX = "[0-9]{10}"//"^\\d{3}\\d{3}\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result = phoneTest.evaluate(with: phoneNumber)
       
        return result
    }
    
    static  func isValidPinCode(pinnumber: String) -> Bool {
        
        let PHONE_REGEX = "^[1-9][0-9]{5}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result = phoneTest.evaluate(with: pinnumber)
        return result
    }
    
    static  func isValidPasword(pass: String) -> Bool {
        
        let PHONE_REGEX = "(?=.*[0-9])(?=.*[a-z]).{6,}"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result = phoneTest.evaluate(with: pass)
        return result
    }

    static  func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        
        return (isReachable && !needsConnection)
    }
    

    static func ToConvertDateFromOneFormatToAnotherFormat(dateStr:String,sourceFormat:String,destinationFormat:String) -> String{
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = sourceFormat

        dateFormat.locale = Locale(identifier: "en_US_POSIX")

        let date = dateFormat.date(from: dateStr)
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = destinationFormat
        let strNew = dateFormatter2.string(from: date!)
        return strNew
    }

    
    class func SetBalnkViewForEmptyTableView(tblView:UITableView,message:String){
        let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tblView.bounds.size.width, height: tblView.bounds.size.height))
        noDataLabel.text          = message
        noDataLabel.numberOfLines = 0
        noDataLabel.textColor     = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        noDataLabel.textAlignment = .center
        tblView.backgroundView    = noDataLabel
        tblView.separatorStyle    = .none
    }

    static func setImageOntextField(_ textField: UITextField, imagename: String, mode: Bool, frame: CGRect){
        
        let imageV = UIImageView(frame:frame)
        imageV.image = UIImage.init(named: imagename)
        
        if mode {
            textField.leftViewMode = UITextField.ViewMode.always
            textField.leftViewRect(forBounds: frame)
            textField.leftView = imageV
        }
        else
        {
            textField.rightViewMode = UITextField.ViewMode.always
            textField.rightViewRect(forBounds: frame)
            textField.rightView = imageV
        }
    }
    
    static func activatetextField(_ lineLabel:UILabel, height : NSLayoutConstraint){
        
        height.constant = 2.0
    }
    
    static func deActivatetextField(_ lineLabel:UILabel, height : NSLayoutConstraint){
        
        height.constant = 1.0
        
    }
    
    static func loadImageFromUrlWithIndicator(_ url: String, view: UIImageView, indic : UIActivityIndicatorView){
        
        // Create Url from string
        let url = URL(string: url)!
        
        // Download task:
        // - sharedSession = global NSURLCache, NSHTTPCookieStorage and NSURLCredentialStorage objects.
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (responseData, responseUrl, error) -> Void in
            // if responseData is not null...
            if let data = responseData{
                
                // execute in UI thread
                DispatchQueue.main.async(execute: { () -> Void in
                    view.image = UIImage(data: data)
                    indic.stopAnimating()
                })
            }
        }) 
        
        // Run task
        task.resume()
    }

    static func resizeImage(_ image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.height
        let newHeight = image.size.width * scale
        UIGraphicsBeginImageContext(CGSize(width: newHeight,height: newWidth))
        image.draw(in: CGRect(x: 0, y: 0, width: newHeight, height: newWidth))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    

    
    static func giveShadowToView(_ shadowView : UIView) {
//        shadowView.layer.shadowColor = Colors.ShadowColor.cgColor//UIColor.red.cgColor
        shadowView.layer.shadowOpacity = 1.0
        shadowView.layer.shadowOffset = CGSize.zero
        shadowView.layer.shadowRadius = 5
        shadowView.layer.cornerRadius = 8
        shadowView.layer.masksToBounds = true
        shadowView.layer.shadowPath = UIBezierPath(rect: shadowView.bounds).cgPath

        //return shadowView
    }
    
    static func getHeightForText(_ text : String , fon : UIFont, width : CGFloat) -> CGFloat{
        
        
        let label_new:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label_new.numberOfLines = 0
        label_new.lineBreakMode = NSLineBreakMode.byWordWrapping //byTruncatingTail
        label_new.font = fon
        label_new.text = text
        label_new.sizeToFit()
        return label_new.frame.height
        
    }
//    static func getWidthForText(_ text : String , fon : UIFont , height : CGFloat) -> CGFloat{
//
//        let label_new:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: 50))
//        label_new.numberOfLines = 0
//        label_new.lineBreakMode = NSLineBreakMode.byWordWrapping
//        label_new.font = fon
//        label_new.text = text
//        label_new.sizeToFit()
//        return label_new.frame.width + 20
//
//    }
    
    static func saveDataInNsDefault(object:AnyObject, key:String){
        let dataSave = NSKeyedArchiver.archivedData(withRootObject: object)
        UserDefaults.standard.set(dataSave, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    static func getDataFromNsDefault(key:String) -> Dictionary<String, AnyObject> {
        if let dataSave = UserDefaults.standard.object(forKey: key) as? NSData{
        let dict = NSKeyedUnarchiver.unarchiveObject(with: dataSave as Data) as! Dictionary<String,AnyObject>
        return dict
        }else{
            return [:]
        }
    }
    
    static func getDataFromNsDefaultAsAnyObject(key:String) -> AnyObject {
        let dataSave = UserDefaults.standard.object(forKey: key) as! NSData
        let dict = NSKeyedUnarchiver.unarchiveObject(with: dataSave as Data) as AnyObject
        return dict
    }
    static func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
    
    static func GetDateFromString(dateStr : String) -> String {
        let datearr = dateStr.components(separatedBy: "T")
        let mydate = datearr[0]
        return mydate
    }
  static  func compareDate(date1:Date, date2:Date) -> Bool {
        let order = Calendar.current.compare(date1, to: date2, toGranularity: .day)
        switch order {
        case .orderedSame:
            return true
        default:
            return false
        }
    }
//    static func addLeftSidePadding(_ fieldArray :  [UITextField]){
//        for field in fieldArray{
//            field.setLeftPaddingPoints()
//        }
//    }
//    static func addDropDownArrow(_ fieldArray :  [UITextField]){
//        for field in fieldArray{
//            field.addDownArrowAccessery()
//        }
//    }
}



extension Date {

func getElapsedInterval() -> String {

    let interval = Calendar.current.dateComponents([.year, .month, .day], from: self, to: Date())

    if let year = interval.year, year > 0 {
        return year == 1 ? "(year)" + " " + "year ago" :
            "(year)" + " " + "years ago"
    } else if let month = interval.month, month > 0 {
        return month == 1 ? "(month)" + " " + "month ago" :
            "(month)" + " " + "months ago"
    } else if let day = interval.day, day > 0 {
        return day == 1 ? "(day)" + " " + "day ago" :
            "(day)" + " " + "days ago"
    } else {
        return "a moment ago"

    }

 }
}

