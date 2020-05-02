//
//  AlarmVC.swift
//  Alarm
//
//  Created by Appinventiv on 12/04/20.
//  Copyright © 2020 Appinventiv. All rights reserved.
//

import UIKit

class AlarmVC: UIViewController {

    // MARK:- Outlets
    @IBOutlet weak var titleTxtFld: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var btnSave: UIButton!
    
    var completition: (()->())?
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        titleTxtFld.addTarget(self, action: #selector(textFieldEditingChanged(textField:)), for: .editingChanged)
        datePicker.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
        datePicker.minimumDate = Date()
        
        btnSaveState(enable: false)
    }
    
    // MARK:- Actions
    @objc func datePickerChanged(picker: UIDatePicker) {
        print(picker.date)
    }
    
    @objc func textFieldEditingChanged(textField: UITextField) {
        btnSaveState(enable: true)
    }
    
    @IBAction func btnSaveTap(_ sender: UIButton) {
    
        scehduleAlarm()
        completition?()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnClose(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Functions
    private func scehduleAlarm() {
        
        let completeDate = datePicker.date
        let dateStr = completeDate.toString(dateFormat: "dd-MM-yyyy")
        let time = completeDate.toString(dateFormat: "HH:mm")

        AlarmController.sharedAlarm.scheduleAlarm(dateStr: dateStr, time: time, title: "Alarm", subject: titleTxtFld.text ?? "")
    }
    
    private func btnSaveState(enable: Bool) {
        btnSave.isEnabled = enable
        btnSave.alpha = enable ? 1.0 : 0.5
    }
}
