//
//  SecondViewController.swift
//  Treads
//
//  Created by Armand Kamffer on 2019/06/06.
//  Copyright © 2019 Armand Kamffer. All rights reserved.
//

import UIKit

class MyLogVC: UIViewController {
    //***************************************************
    //MARK:- IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //***************************************************
    //MARK:- Lifecycle Hook Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "LogTBC", bundle: nil), forCellReuseIdentifier: "logTBC")
    }


}

