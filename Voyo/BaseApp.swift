//
//  BaseApp.swift
//  FigoSales
//
//  Created by Admin on 23/11/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit
import SwiftyJSON

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}

let Density = 7.85

    public func simpleAlert(message: String) {
        
        let alert = UIAlertView()
        alert.title = getPrefName(key: "AppName", value: "VOYO")
        alert.message = message
        alert.addButton(withTitle: "Ok")
        alert.show()
        
    }
    
    public func showOverlay() {
        
        FTIndicator.setIndicatorStyle(UIBlurEffect.Style.dark)
        FTIndicator.showProgressWithmessage("loading")
        
    }

    public func hideOverlayView() {
        
        FTIndicator.dismissProgress()
        
    }

    func viewTransition() -> CATransition {
        
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromRight
        
        return transition
    }

    
   public func backToview(viewController : UIViewController) {
        let transition: CATransition = CATransition()
        transition.duration = 0.5
    transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    transition.type = CATransitionType.reveal
    transition.subtype = CATransitionSubtype.fromLeft
        viewController.view.window!.layer.add(transition, forKey: nil)
    viewController.dismiss(animated: false, completion: {
       // hideOverlayView()
    })
    }
    

    

func getPrefArray(key: NSString,value: NSDictionary) ->NSDictionary{
    if let outData = UserDefaults.standard.data(forKey: key as String){
        let dict = NSKeyedUnarchiver.unarchiveObject(with: outData)
        return dict as! NSDictionary
    }
    else{
        let test : NSDictionary = NSDictionary()
        return  test
    }
    
}
func updatePrefArray (key: NSString,value: NSDictionary){
    let data = NSKeyedArchiver.archivedData(withRootObject: value)
    UserDefaults.standard.set(data, forKey: key as String)
    
}


//func getPrefArr(key: String,value: [OrderItemModel]) ->[OrderItemModel]{
//    
//    if let outData = UserDefaults.standard.data(forKey: key as String){
//        let dict = NSKeyedUnarchiver.unarchiveObject(with: outData)
//        return dict as! [OrderItemModel]
//    }
//    else{
//        return value
//    }
//  
//}
//
//func updatePrefArr(key: String,value: [OrderItemModel]){
//    
//    let currentDefaults = UserDefaults.standard
//    let data = NSKeyedArchiver.archivedData(withRootObject: value)
//    currentDefaults.set(data, forKey: key)
//    
//}

func getPrefName(key: String,value: String) ->String{
    let prefDefault = UserDefaults.standard
    if let keyVal: AnyObject = prefDefault.object(forKey: key as String) as AnyObject?{
        return keyVal as! String
    }else{
        return  value
    }
}
func getPrefInt(key: String,value: Int) ->Int{
    
    let prefDefault = UserDefaults.standard
    
    if let keyVal: Int = prefDefault.object(forKey: key) as! Int? {
        return keyVal
    }else {
        return value
    }
 
}



func imageWithColor(color: UIColor, image: UIImage, imageView: UIImageView) -> UIImage {
    var newImage = image.withRenderingMode(.alwaysTemplate)
    UIGraphicsBeginImageContextWithOptions((image.size), false, (newImage.scale))
    
    color.set()
    newImage.draw(in: CGRect(x: 0, y: 0, width: (imageView.image?.size.width)!, height: (imageView.image?.size.height)!))
    newImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return newImage
    
}

func updatePrefInt(key: String,value: Int){
    let prefDefault = UserDefaults.standard
    prefDefault.set(value, forKey: key)
}

func updatePref(key: String,value: String){
    let prefDefault = UserDefaults.standard
    prefDefault.set(value, forKey: key)
}
func dateToString(myDate:Date)-> String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM-dd-yyyy" //format style. Browse online to get a format that fits your needs.
    let dateString = dateFormatter.string(from: myDate)
    return dateString
}
func convertSortDate(params:String)->NSDate{

    let dateFormate = DateFormatter()
    dateFormate.timeZone = NSTimeZone(name: "UTC") as TimeZone!
    
    dateFormate.dateFormat = "yyyy-MM-dd"
    let myDate = dateFormate.date(from: params)
    return myDate! as NSDate
}
func convertDate(params:NSDate)->String{
    let date = params
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MMM.yyyy"
    let result = formatter.string(from: date as Date)
    
    return result
}

func hexStringToUIColor (hex:String) -> UIColor {
    
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.characters.count) != 6) {
        return UIColor.white
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

func getDayOfWeek(todayDate:NSDate)->Int {
    
    let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
    let myComponents = myCalendar.components(.day, from: todayDate as Date)
    let weekDay = myComponents.day
    return weekDay!
}
func isValidEmail(testStr:String) -> Bool {
    // print("validate calendar: \(testStr)")
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}

func convertStringToDate( paramDate:String)-> NSDate{
    var paramDate = paramDate
    if(paramDate == "0000-00-00 00:00:00"){
        paramDate = "1970-01-01 00:00:00"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myDate = dateFormatter.date(from: paramDate)
        return myDate! as NSDate
    }else{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myDate = dateFormatter.date(from: paramDate)
        return myDate! as NSDate
    }
}

//func presentTabbar(viewController : UIViewController) {
//    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//    let resultViewController = storyBoard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
//    //                resultViewController.selectedIndex = 0
//    viewController.present(resultViewController, animated:false, completion:nil)
//}


extension UIView {
    func makeToast(_ message : String)  {
        FTIndicator.setIndicatorStyle(UIBlurEffect.Style.dark)
        FTIndicator.showToastMessage(message)
    }
}
public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    
}

extension String {
    
//    var length: Int {
//        return self.characters.count
//    }
//
//    subscript (i: Int) -> String {
//        return self[Range(i ..< i + 1)]
//    }
//
//    func substring(from: Int) -> String {
//        return self[Range(min(from, length) ..< length)]
//    }
//
//    func substring(to: Int) -> String {
//        return self[Range(0 ..< max(0, to))]
//    }
//
//    subscript (r: Range<Int>) -> String {
//        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
//                                            upper: min(length, max(0, r.upperBound))))
//        let start = index(startIndex, offsetBy: range.lowerBound)
//        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
//        return String(self[Range(start ..< end)])
//    }
    
}

func compressImage(image:UIImage) -> NSData {
    // Reducing file size to a 10th
    
    var actualHeight : CGFloat = image.size.height
    var actualWidth : CGFloat = image.size.width
    let maxHeight : CGFloat = 1000.0
    let maxWidth : CGFloat = 640.0
    var imgRatio : CGFloat = actualWidth/actualHeight
    let maxRatio : CGFloat = maxWidth/maxHeight
    var compressionImageQuality : CGFloat = 0.5
    
    if (actualHeight > maxHeight || actualWidth > maxWidth){
        if(imgRatio < maxRatio){
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        }
        else if(imgRatio > maxRatio){
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        }
        else{
            actualHeight = maxHeight;
            actualWidth = maxWidth;
            compressionImageQuality = 1;
        }
    }
    else {
        //                actualHeight = maxHeight;
        //                actualWidth = maxWidth;
        compressionImageQuality = 1
    }
    
    let rect = CGRect(x:0.0, y: 0.0, width: actualWidth, height: actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    image.draw(in: rect)
    let img = UIGraphicsGetImageFromCurrentImageContext();
//    let imageData = UIImageJPEGRepresentation(img!, compressionQuality);
    let imageData = UIImage.jpegData(img!)(compressionQuality: compressionImageQuality)
    UIGraphicsEndImageContext();
    
    return imageData as! NSData;
}

extension UIView {
    // Name this function in a way that makes sense to you...
    // slideFromLeft, slideRight, slideLeftToRight, etc. are great alternative names
    func slideInFromLeft(duration: TimeInterval = 0.5, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        //        if let delegate: AnyObject = completionDelegate {
        //            slideInFromLeftTransition.delegate = delegate
        //        }
        
        // Customize the animation's properties
        slideInFromLeftTransition.type = CATransitionType.push
        slideInFromLeftTransition.subtype = CATransitionSubtype.fromLeft
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromLeftTransition.fillMode = CAMediaTimingFillMode.removed
        // Add the animation to the View's layer
        self.layer.add(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
    }
    func slideInFromRight(duration: TimeInterval = 0.5, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        //        if let delegate: AnyObject = completionDelegate {
        //            slideInFromLeftTransition.delegate = delegate
        //        }
        
        // Customize the animation's properties
        slideInFromLeftTransition.type = CATransitionType.push
        slideInFromLeftTransition.subtype = CATransitionSubtype.fromRight
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromLeftTransition.fillMode = CAMediaTimingFillMode.removed
        // Add the animation to the View's layer
        self.layer.add(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
    }
    func slideInFromBottom(duration: TimeInterval = 0.5, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        //        if let delegate: AnyObject = completionDelegate {
        //            slideInFromLeftTransition.delegate = delegate
        //        }
        
        // Customize the animation's properties
        slideInFromLeftTransition.type = CATransitionType.push
        slideInFromLeftTransition.subtype = CATransitionSubtype.fromBottom
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromLeftTransition.fillMode = CAMediaTimingFillMode.removed
        // Add the animation to the View's layer
        self.layer.add(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
    }
    func slideInFromTop(duration: TimeInterval = 0.5, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        //        if let delegate: AnyObject = completionDelegate {
        //            slideInFromLeftTransition.delegate = delegate
        //        }
        
        // Customize the animation's properties
        slideInFromLeftTransition.type = CATransitionType.push
        slideInFromLeftTransition.subtype = CATransitionSubtype.fromTop
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromLeftTransition.fillMode = CAMediaTimingFillMode.removed
        // Add the animation to the View's layer
        self.layer.add(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
    }
    func slideCrossDisclose(duration: TimeInterval = 0.5, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        //        if let delegate: AnyObject = completionDelegate {
        //            slideInFromLeftTransition.delegate = delegate
        //        }
        
        // Customize the animation's properties
        slideInFromLeftTransition.type = CATransitionType.reveal
        slideInFromLeftTransition.subtype = CATransitionSubtype.fromBottom
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromLeftTransition.fillMode = CAMediaTimingFillMode.removed
        // Add the animation to the View's layer
        self.layer.add(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
    }
    
    
}

extension UITextField {
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
}

func topViewController() -> UIViewController {
    return topViewControllerWithRootViewController(rootViewController: UIApplication.shared.keyWindow!.rootViewController!)
}

func topViewControllerWithRootViewController(rootViewController: UIViewController) -> UIViewController {
    if (rootViewController is UITabBarController) {
        let tabBarController: UITabBarController = (rootViewController as! UITabBarController)
        return topViewControllerWithRootViewController(rootViewController: tabBarController.selectedViewController!)
    }
    else if (rootViewController is UINavigationController) {
        let navigationController: UINavigationController = (rootViewController as! UINavigationController)
        return topViewControllerWithRootViewController(rootViewController: navigationController.visibleViewController!)
    }
    else if (rootViewController.presentedViewController != nil) {
        let presentedViewController: UIViewController = rootViewController.presentedViewController!
        return topViewControllerWithRootViewController(rootViewController: presentedViewController)
    }
    else {
        return rootViewController
    }
}

func getJobEntryDateAndTime(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let dateString: String = dateFormatter.string(from: date)
    return dateString
}


//func pushNotificationUpdate() {
//
//    if WebApiCallBack.isConnectedToNetwork() != true {
//            simpleAlert(message: Const.check_internet)
//            return
//        }
//
//    var deviceToken = ""
//    #if TARGET_IPHONE_SIMULATOR
//        deviceToken = "APA91bFdrsZ238P1E29caE3J9e2S93nUcg7lA_heQTKTAtTCCZ5fsrp_jEkX202vVzlscs-9XI4YrWGumy2xWKnrAFIiTJRQa68aIktQjM41VBWvbwDdpofzVUY86Br_Wq2PZU0a9gvy"
//    #else
//        deviceToken = deveiceTokenID
//    #endif
//
//    let myParam = [:] as [String : Any]
//    let mobile_no = getPrefName(key: "mobile_no", value: "")
//    let strURL = "http://www.creativedemo.net/zymedapp/ws/update_device.php?bulk_data=[{\"mobile\":\"\(mobile_no)\",\"device_type\":\"iphone\",\"push_registration_id\":\"\(deviceToken)\"}]"
//    let encoded = strURL.addingPercentEscapes(using: String.Encoding.ascii)
//
//    WebApiCallBack.requestApi(webUrl:encoded!, paramData: myParam as NSObject, completionHandler: { (responseObject, error) -> () in
//
//        print("responseObject = \(responseObject); error = \(error)")
//        if responseObject != nil {
//
//            let mresponse = JSON(responseObject!)
//
//        }
//
//    })
//
//}



