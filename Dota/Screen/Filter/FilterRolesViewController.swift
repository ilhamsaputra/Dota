//
//  FilterRolesViewController.swift
//  Dota
//
//  Created by ilhamsaputra on 09/10/20.
//  Copyright © 2020 ilhamsaputra. All rights reserved.
//

import UIKit

protocol FilterRolesViewControllerDelegate: class {
    func selectedRole(role:String)
}

class FilterRolesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate:FilterRolesViewControllerDelegate?
    var roleFilters:[String] = []
    
    convenience init(roles:[String]) {
        self.init()
        self.roleFilters = roles
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTableView()
    }
}

// MARK: - Setup UI
extension FilterRolesViewController{
    func initTableView(){
        self.tableView.register(UINib(nibName: "RoleTableViewCell", bundle: nil), forCellReuseIdentifier: "RoleTableViewCell")
        self.tableView.tableFooterView = UIView()
        self.tableView.reloadData()
    }
}

// MARK: - tableView
extension FilterRolesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roleFilters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoleTableViewCell") as! RoleTableViewCell
        cell.roleLabel.text = roleFilters[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true) { [weak self] in
            self?.delegate?.selectedRole(role: self?.roleFilters[indexPath.row] ?? "All")
        }
    }
}


