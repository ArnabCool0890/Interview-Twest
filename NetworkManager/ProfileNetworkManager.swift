
import Foundation
import  UIKit
import SVProgressHUD

typealias truckCompletionHandler = (_ truckData:[TruckModels]?, _ message:String) -> Void

class TruckNetworkManager{
    class func getTruckService( _ completionHandler: @escaping truckCompletionHandler) {
      
        let url = "https://api.mystral.in/tt/mobile/logistics/searchTrucks?auth-company=PCH&companyId=33&deactivated=false&key=g2qb5jvucg7j8skpu5q7ria0mu&q-expand=true&q-include=lastRunningState,lastWaypoint"
        
        Server.getRequestWithURL(url) { (response) in
            if response != nil {
                if (response?.json) != nil{
                    var countryCodeArr: [TruckModels] = []
                    
                    if let countryCodeDicArr =  response!["data"] as? [[String:Any]] {
                        for countryDic in countryCodeDicArr {
                            
                            do{
                                let countryMod = try TruckModels.init(countryDic.json)
                                countryCodeArr.append(countryMod)
                                print(countryMod)
                            }catch{
                                debugPrint(error.localizedDescription)
                            }
                            
                        }
                    }
                    completionHandler(countryCodeArr, "")
                    
                }else{
                    completionHandler([],"Error occured")
                }
            }else{
                completionHandler([],"Error occured")
            }
        }
        
    }
   
    

}


extension Dictionary {
    
    var json: String {
        let invalidJson = ""
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
    
    func printJson() {
        print(json)
    }
    
    
}
extension String {
     func join(_ value:String) -> String {
        return "\(self)\(value)"
    }
}
extension Array {
    
    var json: String {
        let invalidJson = ""
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
    
    func printJson() {
        print(json)
    }
    
}
