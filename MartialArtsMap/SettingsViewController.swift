//
//  SettingsViewController.swift
//  MartialArtsMap
//
//  Created by denny on 10/28/16.
//  Copyright © 2016 denny. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBAction func resetAction(_ sender: AnyObject) {
        GYMManager.getInstance().reset()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
