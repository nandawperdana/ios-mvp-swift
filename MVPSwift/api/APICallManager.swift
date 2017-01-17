//
//  APICallManager.swift
//  MVPSwift
//
//  Created by Nanda w Perdana on 1/16/17.
//  Copyright © 2017 Nanda w Perdana. All rights reserved.
//

import Alamofire
import SwiftyJSON
import Foundation

let API_BASE_URL = "http://api.androidhive.info"

class APICallManager {
    static let instance = APICallManager()
    
    enum RequestMethod {
        case get
        case post
    }
    
    enum Endpoint: String {
        case Contacts = "/contacts"
    }
    
    // MARK: Contact
    func callAPIGetContacts(
        onSuccess successCallback: ((_ contacts: [ContactsModel]) -> Void)?,
        onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        
        // Build URL
        let url = API_BASE_URL + Endpoint.Contacts.rawValue
        
        // call API
        self.createRequest(
            url, method: .get, headers: nil, parameters: nil,
            onSuccess: {(responseObject: JSON) -> Void in
                // Create dictionary
                if let responseDict = responseObject["contacts"].arrayObject {
                    let contactDict = responseDict as! [[String:AnyObject]]
                    
                    // Create object
                    var contacts = [ContactsModel]()
                    for item in contactDict {
                        let contact = ContactsModel.build(item)
                        contacts.append(contact)
                    }
                    
                    // Fire callback
                    successCallback?(contacts)
                } else {
                    failureCallback?("An error has occured.")
                }
        },
            onFailure: {(errorMessage: String) -> Void in
                failureCallback?(errorMessage)
        }
        )
    }
    
    // MARK: Request Handler
    // Create request
    func createRequest(
        _ url: String,
        method: HTTPMethod,
        headers: [String: String]?,
        parameters: AnyObject?,
        onSuccess successCallback: ((JSON) -> Void)?,
        onFailure failureCallback: ((String) -> Void)?) {
        
        Alamofire.request(url, method: method).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                successCallback?(json)
            case .failure(let error):
                if let callback = failureCallback {
                    // Return
                    callback(error.localizedDescription)
                }
            }
        }
    }
}
