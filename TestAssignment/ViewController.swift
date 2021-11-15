//
//  ViewController.swift
//  TestAssignment
//
//  Created by Arnab Maity on 13/11/21.
//

import UIKit
import SVProgressHUD
class ViewController: UIViewController {
    
    //MARK:- OUTLETS
    
    @IBOutlet weak var truckTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    //MARK:- PROPERTIES
    
    var trucksArr:[TruckModels] = Array()
    var searchController:AZSearchViewController!
    
    var resultArray:[String] = []
    var filtteredArray:[TruckModels] = []
    
    
    //MARK:- Life CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        truckTableView.delegate = self
        truckTableView.dataSource = self
        self.truckApiCall()
        searchContoller()
//        searchTextField.delegate = self
        
    }
    
    @IBAction func mapViewAction(_ sender: UIButton) {
        let singleBookingVC = Constants.mainStoryBoard.instantiateViewController(withIdentifier: "GoogleMapViewController") as! GoogleMapViewController
        singleBookingVC.trucksArr = filtteredArray
        self.navigationController?.pushViewController(singleBookingVC, animated: true)
    }
    
    @IBAction func searchAction(_ sender: UIButton) {
        
    
        searchController.show(in: self)
        
    }
    @IBAction func refreshCall(_ sender: UIButton) {
        
        self.truckApiCall()
    }
    
    @objc func close(sender:AnyObject?){
        searchController.dismiss(animated: true)
    }
    func pushWithTitle(text: String){
        let controller = UIViewController()
        controller.title = text
        controller.view.backgroundColor = UIColor.white
        self.dismiss(animated: true, completion: nil)
    }
    
    func searchContoller(){
        self.searchController = AZSearchViewController()
        
        //add setup delegate and data source
        self.searchController.delegate = self
        self.searchController.dataSource = self
        
        /*
         preform optional customizations
         */
        
        //The search bar's placeholder text
        self.searchController.searchBarPlaceHolder = "Truck Number"
        
        
        self.searchController.navigationBarClosure = { bar in
            //The navigation bar's background color
            bar.barTintColor = #colorLiteral(red: 0.7983670831, green: 0.3675372601, blue: 0.3040015996, alpha: 1)
            
            //The tint color of the navigation bar
            bar.tintColor = UIColor.lightGray
        }
        
        //The search bar's (text field) background color
        self.searchController.searchBarBackgroundColor = .white
        
        //The status bar's color (light or dark)
        self.searchController.statusBarStyle = .lightContent
        
        //Keyboard appearnce (dark,light or default)
        self.searchController.keyboardAppearnce = .dark
        
        //The tableview's seperator color
        self.searchController.separatorColor = .clear
        
 
    }
    
}
//MARK:- FOR SETUP INITIAL VIEW AND API CALL

extension ViewController{
    func truckApiCall(){
        
        TruckNetworkManager.getTruckService { (truckModel,msg) in
            DispatchQueue.main.async {
                self.trucksArr = truckModel!
                self.filtteredArray = self.trucksArr
                self.truckTableView.reloadData()
               
            }
        }
    }
    
    func getcurrentdate(timeStamp :Double) -> Date {
        let time = Double(timeStamp) / 1000
        let date = Date(timeIntervalSince1970: time)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM YYYY"
        return date
    }
    
    
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtteredArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TruckViewCell", for: indexPath) as! TruckViewCell
        cell.truckNumberLabel.text = filtteredArray[indexPath.row].truckNumber
        cell.kmLabel.text = "\(filtteredArray[indexPath.row].lastWaypoint?.speed?.rounded() ?? 0)  Km/h"
        
        if filtteredArray[indexPath.row].lastWaypoint?.ignitionOn == false{
            cell.truckIdelImage.image = #imageLiteral(resourceName: "batteryDrain")
        }else{
            cell.truckIdelImage.image = #imageLiteral(resourceName: "truck")
        }
        
        let strDate = getcurrentdate(timeStamp: Double(filtteredArray[indexPath.row].lastWaypoint?.createTime ?? 0))
        
        cell.DayLabel.text = Date().offsetFrom(from: strDate)
        let i = filtteredArray[indexPath.row]
       
        let truckTime = getcurrentdate(timeStamp: Double(i.lastRunningState?.stopStartTime ?? 0)).hours(from: Date())
        
        
        if i.lastRunningState?.truckRunningState == 1{
            cell.truckDescriptionLabel.text = "Running since last \(Date().offsetFrom(from: strDate))"
        }else if i.lastWaypoint?.ignitionOn == false &&  i.lastRunningState?.truckRunningState == 0{
            cell.truckDescriptionLabel.text = "Stopped since last \(Date().offsetFrom(from: strDate))"
        }else if i.lastWaypoint?.ignitionOn == true && i.lastRunningState?.truckRunningState == 0{
            cell.truckDescriptionLabel.text = "Stopped since last \(Date().offsetFrom(from: strDate))"
        }else if truckTime >= 4{
            cell.truckDescriptionLabel.text = "Stopped since last \(Date().offsetFrom(from: strDate))"
        }
        
        
     
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
        
    }
}



extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offsetFrom(from date: Date) -> String {
        if years(from: date)   > 0 {
            if years(from: date) == 1{
                return "\(years(from: date)) year "
            }
            return "\(years(from: date)) years "
        }
        if months(from: date)  > 0 {
            if months(from: date)  == 1{
                return "\(months(from: date)) month "
            }
            return "\(months(from: date)) months "
        }
        if weeks(from: date)   > 0 {
            if weeks(from: date) == 1{
                return "\(weeks(from: date)) week "
            }
            return "\(weeks(from: date)) weeks "
        }
        if days(from: date)    > 0 {
            if days(from: date) == 1{
                return "\(days(from: date)) day "
            }
            return "\(days(from: date)) days "
        }
        if hours(from: date)   > 0 {
            if hours(from: date) == 1{
                return "\(hours(from: date)) hour "
            }
            return "\(hours(from: date)) hours "
        }
        if minutes(from: date) > 0 {
            if minutes(from: date) == 1{
                return "\(minutes(from: date)) minute "
            }
            return "\(minutes(from: date)) minutes "
        }
        if seconds(from: date) > 0 {
            if seconds(from: date) == 1{
                return "\(seconds(from: date)) second "
            }
            return "\(seconds(from: date)) seconds "
        }
        return ""
    }
}

extension String {
    static func convertDateString(dateString : String, fromFormat sourceFormat : String, toFormat desFormat : String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = sourceFormat
        let date = dateFormatter.date(from: dateString) ?? Date()
        dateFormatter.dateFormat = desFormat
        return dateFormatter.string(from: date)
    }
    func toDateString( inputDateFormat inputFormat  : String,  ouputDateFormat outputFormat  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = outputFormat
        return dateFormatter.string(from: date ?? Date())
    }
    
    func timeConversion12(inputDateFormat inputFormat  : String,  ouputDateFormat outputFormat  : String ) -> String {
        
        let dateFormatter = DateFormatter()
 
        dateFormatter.dateFormat = inputFormat
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = outputFormat
        return dateFormatter.string(from: date ?? Date())
    }
    
    
}

extension ViewController:AZSearchViewDelegate{
    func searchView(_ searchView: AZSearchViewController, didSearchForText text: String) {
        self.filtteredArray = self.trucksArr.filter({ truck in
            
            if truck.truckNumber?.lowercased().contains(text.lowercased()) ?? false{
                 return true
            }else{
                return false
            }
        })
        searchView.dismiss(animated: false, completion: nil)
        truckTableView.reloadData()
    }
    func searchView(_ searchView: AZSearchViewController, didSelectResultAt index: Int, text: String) {
        self.searchController.dismiss(animated: true, completion: {
          
        })
    }
    func searchView(_ searchView: AZSearchViewController, tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func searchView(_ searchView: AZSearchViewController, didTextChangeTo text: String, textLength: Int) {
        
        if text.count == 0{
            self.filtteredArray = trucksArr
        }else{
            self.filtteredArray = self.trucksArr.filter({ truck in
                
                if truck.truckNumber?.lowercased().contains(text.lowercased()) ?? false{
                     return true
                }else{
                    return false
                }
            })

        }
        truckTableView.reloadData()
    }
}

extension ViewController: AZSearchViewDataSource{
    
    func statusBarStyle() -> UIStatusBarStyle {
        return .lightContent
    }
    
    func results() -> [String] {
        
        return self.resultArray
    }
    func searchView(_ searchView: AZSearchViewController, tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //      let course:LibraryCourse = courses[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: searchView.cellIdentifier)
        cell?.textLabel?.text =  self.resultArray[indexPath.row]
        cell?.imageView?.tintColor = UIColor.gray
        cell?.contentView.backgroundColor = .white
        return cell!
    }
    func searchView(_ searchView: AZSearchViewController, tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

