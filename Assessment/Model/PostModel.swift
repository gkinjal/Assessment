//
// PostModel.swift
//  Assessment
//
//  Created by apple on 27/04/24.
//

import Foundation
import SwiftyJSON

struct PostModel {
    let id: Int
    let title: String
    let body: String

    init(json: JSON) {
        self.id = json["id"].intValue
        self.title = json["title"].stringValue
        self.body = json["body"].stringValue
    }
}

