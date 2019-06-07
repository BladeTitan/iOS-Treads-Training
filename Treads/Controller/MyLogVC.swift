//
//  SecondViewController.swift
//  Treads
//
//  Created by Armand Kamffer on 2019/06/06.
//  Copyright © 2019 Armand Kamffer. All rights reserved.
//

import UIKit
import RealmSwift

class MyLogVC: UIViewController {
    //***************************************************
    //MARK:- IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //***************************************************
    //MARK:- Lifecycle Hook Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "LogTBC", bundle: nil), forCellReuseIdentifier: "logTBC")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension MyLogVC: UITableViewDelegate, UITableViewDataSource {
    //***************************************************
    //MARK:- UITableViewDelegate & UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Run.getAllRuns()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "logTBC") as? LogTBC {
            guard let run = Run.getAllRuns()?[indexPath.row] else {
                return LogTBC()
            }
            
            cell.setupCell(run: run)
            return cell
        }
        
        return UITableViewCell()
    }
}
