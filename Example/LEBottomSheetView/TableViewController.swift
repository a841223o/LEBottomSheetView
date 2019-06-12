//
//  TableViewController.swift
//  LEBottomSheetView_Example
//
//  Created by DongLunYou on 2019/6/12.
//  Copyright © 2019年 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class TableViewController :UIViewController , UITableViewDelegate , UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Row\(indexPath.row)"
        return cell
    }
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}
