//
//  User.swift
//  grocery
//
//  Created by Yasin Ehsan on 3/31/20.
//  Copyright © 2020 Helal. All rights reserved.
//

import Foundation

struct User{
//    create shared singlton instance
//    static let sharedInstance = User()
    
    static var name: String?
    static var phoneNum: String?
    

//  MARK:- global arrays
    static var requestedList: [Item] = [Item]()
// map from firbase UID to delivery requested list
    static var deliveryList: [String: [Item]]?
}

