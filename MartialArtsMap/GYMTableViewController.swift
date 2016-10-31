//
//  GYMTableViewController.swift
//  MartialArtsMap
//
//  Created by denny on 10/24/16.
//  Copyright © 2016 denny. All rights reserved.
//

import UIKit

class GYMTableViewController: UITableViewController {
    
    var gymManager = GYMManager.getInstance()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return gymManager.count()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gymEntry", for: indexPath)

        // Configure the cell...
        let item = gymManager.getItem(row: indexPath.row)
        cell.textLabel?.text = item.name

        return cell
    }
 

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let addAction = UITableViewRowAction(style: .normal, title: "insert") { (action, indexPath) in
            self.performSegue(withIdentifier: "addGYM", sender: nil)
        }
        
        let deleteAction = UITableViewRowAction(style: .default, title: "delete") { (action, indexPath) in
            self.gymManager.delete(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        return [addAction, deleteAction]
    }
//    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            gymManager.delete(indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            tableView.insertRows(at: [indexPath], with: .fade)
//        }
//    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let item = gymManager.getItem(row: fromIndexPath.row)
        gymManager.delete(fromIndexPath.row)
        gymManager.insert(row: to.row, item: item)
    }
 

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
 

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.destination is GYMDetailViewController{
            let controller = segue.destination as! GYMDetailViewController
            let indexPath = tableView.indexPathForSelectedRow!
            controller.gymInfo = gymManager.getItem(row: indexPath.row)
        }
    }
 

}
