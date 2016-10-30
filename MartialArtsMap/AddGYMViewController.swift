//
//  AddGYMViewController.swift
//  MartialArtsMap
//
//  Created by denny on 10/30/16.
//  Copyright © 2016 denny. All rights reserved.
//

import UIKit

class AddGYMViewController: UIViewController {
    @IBOutlet weak var gymName: UITextField!
    
    @IBOutlet weak var gymAddress: UITextField!
    
    @IBOutlet weak var gymWebsite: UITextField!
    
    @IBOutlet weak var gymDescription: UITextView!
    
    var gymInfo:GYMInfo?
    
    @IBAction func okAction(_ sender: AnyObject) {
        if gymInfo != nil{
            gymInfo?.name = gymName.text
            gymInfo?.description = gymDescription.text
            gymInfo?.imageSite = ""
            gymInfo?.website = gymWebsite.text
            gymInfo?.address = gymAddress.text
        }
        else{
            let gymInfo = GYMInfo()
            gymInfo.name = gymName.text
            gymInfo.description = gymDescription.text
            gymInfo.imageSite = ""
            gymInfo.website = gymWebsite.text
            gymInfo.address = gymAddress.text
            GYMManager.getInstance().add(gymInfo)
        }
        let _ = self.navigationController?.popViewController(animated: true)
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
