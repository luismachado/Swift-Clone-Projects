//
//  Tweet.swift
//  TwitterLBTA
//
//  Created by Brian Voong on 1/24/17.
//  Copyright © 2017 Lets Build That App. All rights reserved.
//

import Foundation
import SwiftyJSON
import TRON

struct Tweet: JSONDecodable {
    let user: User
    let message: String
    
    init(json: JSON) {
        let userJson = json["user"]
        self.user = User(json: userJson)
        
        self.message = json["message"].stringValue
    }
}
