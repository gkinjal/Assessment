import Foundation
import UIKit
import SwiftyJSON
import KRProgressHUD


        
    class PostVM: NSObject {
            
        class func callPostWS(viewController: UIViewController, parameters: NSDictionary, completion: @escaping ([PostModel]) -> Void) {
            let paramString = convertDictionaryToString(parameters)
            DataManager.alamofireGetRequest(urlString: postsURL + "?" + paramString, viewcontroller: viewController) { data, responseObject, error in
                if let data = responseObject {
                    do {
                        let json = try JSON(data: data)
                        let profiles = parsePost(from: json)
                        completion(profiles)
                    } catch {
                        print("Error parsing JSON: \(error)")
                        completion([])
                    }
                } else {
                    print("Data is nil.")
                    completion([])
                }
            }
            
            func convertDictionaryToString(_ parameters: NSDictionary) -> String {
                var paramString = ""
                for (key, value) in parameters {
                    if let keyString = key as? String, let valueString = value as? String {
                        if !paramString.isEmpty {
                            paramString += "&"
                        }
                        paramString += keyString + "=" + valueString
                    }
                }
                return paramString
            }
        }

        private class func parsePost(from json: JSON) -> [PostModel] {
            guard let jsonArray = json.array else {
                return []
            }

            var profiles: [PostModel] = []

            for item in jsonArray {
                let profile = PostModel(json: item)
                profiles.append(profile)
            }

            return profiles
        }
        
       
    }
