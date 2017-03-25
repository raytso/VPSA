//
//  UserInfoInputTableViewController.swift
//  NoMoreParking
//
//  Created by Ray Tso on 3/9/17.
//  Copyright © 2017 Ray Tso. All rights reserved.
//

import UIKit

class UserInfoInputTableViewController: UITableViewController {

    @IBOutlet var userInfoTableView: UserInfoInputTableView!
    
    var userInfo: UserInformation?
    
    // MARK: - UDFs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint("Loading userinfo table view controller")
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        tableView.backgroundColor = UIColor.clear
        
        if userInfo == nil {
            self.userInfo = UserInformation()
        }
        // Depends on settings, for now is default
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        debugPrint("userInfo tableview will appear")
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }
    struct CellIdentifiers {
        static let UserInfoType = "userInfoType"
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cellForRow(at: indexPath)
        cell = UITableViewCell.init(style: .value2, reuseIdentifier: CellIdentifiers.UserInfoType)
        switch indexPath.row {
        case 0:
            cell?.textLabel?.text = "姓名"
            cell?.detailTextLabel?.text = userInfo?.name
        case 1:
            cell?.textLabel?.text = "地址"
            cell?.detailTextLabel?.text = userInfo?.address
        case 2:
            cell?.textLabel?.text = "電話"
            cell?.detailTextLabel?.text = userInfo?.phone
        case 3:
            cell?.textLabel?.text = "電子郵件"
            cell?.detailTextLabel?.text = userInfo?.email
        default:
            break
        }
        cell?.textLabel?.textColor = UIColor.lightGray
        cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        cell?.detailTextLabel?.textColor = UIColor.lightGray
        cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 14.0)
        cell?.detailTextLabel?.adjustsFontSizeToFitWidth = true
        return cell!
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
