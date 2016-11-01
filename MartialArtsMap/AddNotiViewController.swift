//
//  AddNotiViewController.swift
//  MartialArtsMap
//
//  Created by denny on 11/1/16.
//  Copyright © 2016 denny. All rights reserved.
//

import UIKit
import NotificationCenter
class AddNotiViewController: UIViewController {
    @IBOutlet weak var myEvent: UITextField!
    @IBOutlet weak var myDatePicker: UIDatePicker!
    @IBOutlet weak var myDetail: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneAction(_ sender: AnyObject) {
        let date = myDatePicker.date
        let event = myEvent.text!
        let detail = myDetail.text!
        let item = NotiItem(date: date, event: event, detail: detail)
        MyNotiManager.getInstance().addNoti(notiItem: item)
        self.navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
