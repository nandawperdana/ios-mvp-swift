//
//  PeopleAdapter.swift
//  MVPSwift
//
//  Created by Nanda Wisnu Tampan on 05/02/21.
//  Copyright © 2021 Nanda w Perdana. All rights reserved.
//

import UIKit

protocol PeopleAdapterDelegate: AnyObject {
    func didTap(_ item: People)
}

class PeopleAdapter: NSObject, UITableViewDelegate, UITableViewDataSource {
    let identifier = "PeopleInfoCell"
    
    var list: [People]?
    
    weak var delegate: PeopleAdapterDelegate?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! PeopleCell
        cell.item = list?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = list?[indexPath.row] else { return }
        delegate?.didTap(item)
    }
}
