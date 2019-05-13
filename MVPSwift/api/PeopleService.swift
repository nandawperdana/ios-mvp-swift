//
//  PeopleService.swift
//  MVPSwift
//  The Interactor class, contains: API call for specific endpoint to be called in The Presenter;
//      local data storing logic.
//
//  Created by Nanda w Perdana on 1/17/17.
//  Copyright © 2017 Nanda w Perdana. All rights reserved.
//

import Foundation

class PeopleService {
    public func callAPIGetPeople(onSuccess successCallback: ((_ people: [PeopleModel]) -> Void)?,
                                 onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APICallManager.instance.callAPIGetPeople(
            onSuccess: { (people) in
                successCallback?(people)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
}
