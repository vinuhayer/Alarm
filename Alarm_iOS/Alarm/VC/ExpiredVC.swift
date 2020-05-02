//
//  ExpiredVC.swift
//  Alarm
//
//  Created by Appinventiv on 12/04/20.
//  Copyright © 2020 Appinventiv. All rights reserved.
//

import UIKit

class ExpiredVC: UIViewController {

    // MARK:- Outlets
    @IBOutlet weak var mainTableView: UITableView!
    
    // MARK:- Varibales
    var expiredAlarms : [AlarmModel] = []
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.registerCell(with: AlarmTableCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        expiredAlarms = AlarmController.sharedAlarm.fetchAlarms(type: .expired)
        mainTableView.reloadData()
    }
    
    // MARK:- Actions
    @IBAction func btnAddTap(_ sender: UIButton) {
        let alarmScene = AlarmVC.instantiate(fromAppStoryboard: .Main)
        alarmScene.completition = {[weak self] in
            self?.expiredAlarms = AlarmController.sharedAlarm.fetchAlarms(type: .expired)
            self?.mainTableView.reloadData()
        }
        self.present(alarmScene, animated: true, completion: nil)
    }
}

//MARK:- TABLE VIEW
extension ExpiredVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expiredAlarms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: AlarmTableCell.self)
        cell.populate(model: expiredAlarms[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

