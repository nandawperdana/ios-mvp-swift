//
//  PeoplePresenter.swift
//  MVPSwift
//  The ViewController's presenter, contains:
//      - View: The ViewController's contract.
//      - Presenter: The ViewController's main logic (call API, populate data, show data, etc.)
//
//  Created by Nanda w Perdana on 1/17/17.
//  Copyright © 2017 Nanda w Perdana. All rights reserved.
//

import Foundation

struct PeopleViewData{
    let name: String
    let email: String
}

protocol PeopleView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setPeople(people: [PeopleViewData])
    func setEmptyPeople()
}

class PeoplePresenter {
    private let peopleService:PeopleService
    weak private var peopleView : PeopleView?
    
    init(peopleService:PeopleService) {
        self.peopleService = peopleService
    }
    
    func attachView(view:PeopleView) {
        peopleView = view
    }
    
    func detachView() {
        peopleView = nil
    }
    
    func getPeople() {
        self.peopleView?.startLoading()
        peopleService.callAPIGetPeople(
            onSuccess: { (people) in
                self.peopleView?.finishLoading()
                if (people.count == 0){
                    self.peopleView?.setEmptyPeople()
                } else {
                    let mappedUsers = people.map {
                        return PeopleViewData(name: "\($0.name!)", email: "\($0.email!)")
                    }
                    self.peopleView?.setPeople(people: mappedUsers)
                }
            },
            onFailure: { (errorMessage) in
                self.peopleView?.finishLoading()
            }
        )
    }
}
