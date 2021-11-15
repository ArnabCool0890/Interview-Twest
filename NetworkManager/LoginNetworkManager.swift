////
////  LoginNetworkManager.swift
////  TapDoc
////
////  Created by Hitesh Dhawan on 17/08/18.
////  Copyright © 2018 Varun Tyagi. All rights reserved.
////
//
//import Foundation
//
//
//typealias RegisterCompletionHandler = (_ userData: UserDataModel?, _ message: String) -> Void
//typealias RegistrationFinalCompletionHandler = (_ userData: RegistrationModel?, _ message: String) -> Void
//
//typealias OTPCompletionHandler = (_ status: Int? , _ msg:String?) -> Void
//typealias BOTURLCompletionHandler = (_ url: String?, _ token:String? , _ msg:String?) -> Void
//
//
//class LoginRegisterNetworkManager {
//    //name, mobile, device_type, language_id
//
//    class func saveOTPService(_ mobileNo : String , _ name:String , _ OTP:String  ,  completionHandler: @escaping RegisterCompletionHandler) {
//        let url = Constants.BASEURL + MethodName.saveAfterOtp
//       
//        Server.PostDataInDictionary(url, paramterDic:["mobile":mobileNo,"name":name,"language_id":Constants.getSelectedLanguageId(),"otp":OTP, "device_id" : Constants.Device_UUID!, "device_type" : "iOS", "device_token" : "\(UserDefaults.standard.value(forKey: Constants.DEVICETOKEN) ?? "")"]) { (response) in
//           // response.printJson()
//                    let userDataModel = try? UserDataModel.init(response.json)
//                    if  userDataModel?.status == 1{
//                        completionHandler(userDataModel,userDataModel?.message ?? KSomeError)
//                    }
//                    UserDataModel.sharedUserModel = userDataModel
//                    return completionHandler(nil,userDataModel?.message ?? KSomeError )
//                }
//            }
//    
//   
//    class func registerService(
//         user_id:String,
//         language_id:String,
//         user_type:String,
//         country_name:String,
//         location_name:String,
//         functional_area:String,
//         department:String,
//         sub_department:String,
//         office_name:String,
//         office_department:String,
//         office_sub_department:String,
//         user_unique_code:String,
//         outlet_type:String,
//         zone_type:String ,
//        completionHandler: @escaping RegistrationFinalCompletionHandler) {
//        
//        let url = Constants.BASEURL + MethodName.register
//        
//        var param:[String:Any] = [:]
//       param["user_id"] =                   user_id
//       param["language_id"] =               language_id
//       param["user_type"] =                 user_type
//       param["country_name"] =              country_name
//       param["location_name"] =             location_name
//       param["functional_area"] =           functional_area
//       param["department"] =                department
//       param["sub_department"] =            sub_department
//       param["office_name"] =               office_name
//       param["office_department"] =         office_department
//       param["office_sub_department"] =     office_sub_department
//       param["user_unique_code"] =          user_unique_code
//       param["outlet_type"] =               outlet_type
//       param["zone_type"] =                 zone_type
//        
//        Server.PostDataInDictionary(url, paramterDic:param) { (response) in
//           // response.printJson()
//            let userDataModel = try? RegistrationModel.init(response.json)
//            if  userDataModel?.status == 1{
//                completionHandler(userDataModel,userDataModel?.message ?? KSomeError)
//            }
//            RegistrationModel.sharedModel = userDataModel
//            return completionHandler(nil,userDataModel?.message ?? KSomeError )
//        }
//    }
//
//	class func getOtpService(_ mobileNo : String , _ name:String, _ countryCode:String,_ screenName : String , completionHandler: @escaping OTPCompletionHandler) {
//        let url = Constants.BASEURL + MethodName.requestOtp
//
//		Server.PostDataInDictionary(url, paramterDic: ["mobile":mobileNo,"name":name ,"screen_name":screenName, "country_code":countryCode,"language_id":Constants.getSelectedLanguageId()]) { (response) in
//        
//            //response.printJson()
//           
//            if let _ = response["data"] as? [String:Any] , let status = response["status"] as? Int {//}, let otp = data["otp"] as? Int{
//               return completionHandler(status, response["message"] as? String ?? KSomeError)
//            }else{
//            completionHandler(0, response["message"] as? String ?? KSomeError)
//            }
//           
//        }
//    }
//   
//    class func getUserUrlService(completionHandler: @escaping BOTURLCompletionHandler) {
//        
//        let url = Constants.BASEURL + MethodName.getUserURl
//            //+ "?user_id=\(UserDefaults.standard.value(forKey: Constants.UserID) ?? "0")"
//        let param = [ "device_id" : Constants.Device_UUID!, "device_type" : "iOS", "device_token" : "\(UserDefaults.standard.value(forKey: Constants.DEVICETOKEN) ?? "dsfef")","user_id":"\(UserDefaults.standard.value(forKey: Constants.UserID) ?? "0")"] as [String : Any]
//        
//        Server.PostDataInDictionary(url, paramterDic: param) { (response) in
//            
//            if response.count > 0  {
//                if let botURl = response["data"] as? String{
//                    return completionHandler(botURl , response["token"] as? String,  response["message"] as? String ?? KSomeError)
//                }else{
//                    completionHandler(nil,nil,KSomeError)
//                }
//            }else{
//                completionHandler(nil,nil,KSomeError)
//            }
//        }
////        Server.getRequestWithURL(url) { (response) in
////            if response != nil {
////                if let botURl = response?["data"] as? String{
////                    return completionHandler(botURl , response?["token"] as? String,  response?["message"] as? String ?? KSomeError )
////                }else{
////                    completionHandler(nil,nil,KSomeError)
////                }
////            }else{
////                completionHandler(nil,nil,KSomeError)
////            }
////        }
//        
//    }
//
//
//}
