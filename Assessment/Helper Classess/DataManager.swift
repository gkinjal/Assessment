//
// DataManager.swift
//  Assessment
//
//  Created by apple on 27/04/24.
//


import UIKit
import Alamofire
import SwiftyJSON
import KRProgressHUD
import Foundation

class DataManager: NSObject {
    
    typealias completion = (( _ data: JSON?, Data?,  _ error: NSError?, NSDictionary?)->())
    
    class func alamofireGetRequest(urlString: String, viewcontroller: UIViewController?, completion: @escaping (JSON?, Data?, Error?) -> Void) {
        KRProgressHUD.show(withMessage: Constant.PROGRESS_TITLE)
        
        if CommonMethods.isInternetAvailable() {
            AF.request(urlString)
                .validate()
                .responseJSON { response in
                    KRProgressHUD.dismiss()
                    
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        print(json)
                        completion(json, response.data, nil)
                        
                    case .failure(let error):
                        print(error)
                        if let viewController = viewcontroller {
                            CommonMethods.showAlertMessage(title: Constant.BLANK, message: error.localizedDescription, view: viewController)
                        }
                        completion(nil, nil, error)
                    }
            }
        } else {
            KRProgressHUD.dismiss()
            if let viewController = viewcontroller {
                CommonMethods.showAlertMessage(title: Constant.BLANK, message: Constant.MESSAGE_NETWORK, view: viewController)
            }
            completion(nil, nil, NSError(domain: "NetworkError", code: 0, userInfo: [NSLocalizedDescriptionKey: Constant.MESSAGE_NETWORK]))
        }
    }
    
    class func alamofirePostRequest(urlString:String, param:[String:Any],viewcontroller : UIViewController!,completion: @escaping ( _ data: JSON?, Data?,  _ error: NSError?, NSDictionary?)->Void) {
        print(urlString)
        if  CommonMethods.isInternetAvailable() == true {
            AF.request(urlString, method: .post, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { response in
                KRProgressHUD.dismiss()
                switch(response.result) {
                case .success(let value):
                    if let data = value as? [String:Any] {
                        let json = JSON(data)
                        print(json)
                        completion(json, response.data, nil, data as NSDictionary)
                    }
                case .failure(let error):
                    print(error)
                    CommonMethods.showAlertMessage(title: Constant.BLANK, message: (error.localizedDescription), view: viewcontroller)
                }
                
            }
        } else {
            
            CommonMethods.showAlertMessage(title: Constant.BLANK, message: Constant.MESSAGE_NETWORK, view: viewcontroller)
        }
    }
    
    class func alamofirePutRequest(url:String, viewcontroller : UIViewController!, param: Parameters, completion:@escaping completion) {
        KRProgressHUD.show(withMessage: Constant.PROGRESS_TITLE)
        if  CommonMethods.isInternetAvailable() == true {
            AF.request(url, method: .put, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { response in
                KRProgressHUD.dismiss()
                switch(response.result) {
                case .success(let value):
                    if let data = value as? [String:Any] {
                        let json = JSON(data)
                        print(json)
                        completion(json, response.data, nil, data as NSDictionary)
                    }
                case .failure(let error):
                    print(error)
                    CommonMethods.showAlertMessage(title: Constant.BLANK, message: (error.localizedDescription), view: viewcontroller)
                }
                KRProgressHUD.dismiss()
            }
        } else {
            KRProgressHUD.dismiss()
            CommonMethods.showAlertMessage(title: Constant.BLANK, message: Constant.MESSAGE_NETWORK, view: viewcontroller)
        }
    }
    
    class func alamofireUploadImage(urlmethod: String, parameter: [String: Any], userImage: Data!,imageName: String,fileType: String, viewcontroller : UIViewController!, completion:@escaping completion) {
        KRProgressHUD.show(withMessage: Constant.PROGRESS_TITLE)
        if CommonMethods.isInternetAvailable() == true {
            AF.upload(multipartFormData: { multipartFormData in
                for (key, value) in parameter {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                
                let imageData = userImage
                //"image/jpeg"
                if fileType == "image/jpeg" {
                    if let data = imageData {
                        multipartFormData.append(data, withName: imageName, fileName: "imageName" + ".jpeg", mimeType: fileType)
                    }
                } else {
                    if let data = imageData {
                        multipartFormData.append(data, withName: imageName, fileName: "imageName" + ".pdf", mimeType: fileType)
                    }
                }
            }, to: urlmethod, method: .put, headers: nil).responseJSON { response in
                switch(response.result) {
                case .success(let value):
                    if let data = value as? [String:Any]{
                        let json = JSON(data)
                        print(json)
                        completion(json, response.data, nil, data as NSDictionary)
                    }
                case .failure(let error):
                    print(error)
                    CommonMethods.showAlertMessage(title: Constant.BLANK, message: (error.localizedDescription), view: viewcontroller)
                }
                KRProgressHUD.dismiss()
            }
        } else {
            KRProgressHUD.dismiss()
            CommonMethods.showAlertMessage(title: Constant.BLANK, message: Constant.MESSAGE_NETWORK, view: viewcontroller)
        }
    }
    
   
}
