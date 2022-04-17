//
//  APICallManager.swift
//  MVPSwift
//  Populate all API caller methods.
//
//  Created by Nanda w Perdana on 1/16/17.
//  Copyright © 2017 Nanda w Perdana. All rights reserved.
//

import Alamofire
import SwiftyJSON
import Foundation

let API_BASE_URL = "https://nandawperdana.com"

class APICallManager {
    static let instance = APICallManager()
    
    enum RequestMethod {
        case get
        case post
    }
    
    enum Endpoint: String {
        case People = "/people.json"
    }
    
    // MARK: People API
    func callAPIGetPeople(onSuccess successCallback: ((_ people: [People]) -> Void)?,
                          onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        
        // Build URL
        let url = API_BASE_URL + Endpoint.People.rawValue
        
        // call API
        self.createRequest(
            url, method: .get, headers: nil, parameters: nil,
            onSuccess: {(responseObject: JSON) -> Void in
                // Create dictionary
                if let responseDict = responseObject["data"].arrayObject {
                    let peopleDict = responseDict as! [[String:AnyObject]]
                    
                    // Create object
                    var data = [People]()
                    for item in peopleDict {
                        let single = People.build(item)
                        data.append(single)
                    }
                    
                    // Fire callback
                    successCallback?(data)
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
        onFailure failureCallback: ((String) -> Void)?
    ) {
        
        AF.request(url, method: method).response { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value as Any)
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
