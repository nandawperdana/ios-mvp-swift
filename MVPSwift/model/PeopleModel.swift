//
//  PeopleModel.swift
//  MVPSwift
//  Model Class
//
//  Created by Nanda w Perdana on 1/16/17.
//  Copyright © 2017 Nanda w Perdana. All rights reserved.
//

import Foundation

class PeopleModel {
    var id: String?
    var name: String?
    var email: String?
    var address: String?
    var gender: String?
    var pic: String?
    var phone: PhoneModel?
    
    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject]) {
        if let data = dict["id"] as? String {
            self.id = data
        }
        if let data = dict["name"] as? String {
            self.name = data
        }
        if let data = dict["email"] as? String {
            self.email = data
        }
        if let data = dict["address"] as? String {
            self.address = data
        }
        if let data = dict["gender"] as? String {
            self.gender = data
        }
        if let data = dict["pic"] as? String {
            self.pic = data
        }
        if let data = dict["phone"] as? [String:AnyObject] {
            self.phone = PhoneModel.build(data)
        }
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> PeopleModel {
        let contact = PeopleModel()
        contact.loadFromDictionary(dict)
        return contact
    }
}

class PhoneModel {
    var mobile: String?
    var home: String?
    var office: String?
    
    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject]) {
        if let data = dict["mobile"] as? String {
            self.mobile = data
        }
        if let data = dict["home"] as? String {
            self.home = data
        }
        if let data = dict["office"] as? String {
            self.office = data
        }
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> PhoneModel {
        let phone = PhoneModel()
        phone.loadFromDictionary(dict)
        return phone
    }
}
