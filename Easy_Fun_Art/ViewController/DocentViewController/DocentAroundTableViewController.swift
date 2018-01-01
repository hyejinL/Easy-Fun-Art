//
//  DocentAroundTableViewController.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 1..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class DocentAroundTableViewController: UITableViewController, IndicatorInfoProvider {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "내 주변 전시")
    }


}

extension DocentAroundTableViewController {
    func setUpTableView() {
        self.tableView.register(UINib(nibName: DocentListTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: DocentListTableViewCell.reuseIdentifier)
        self.tableView.tableFooterView = UIView(frame: .zero)
    }
}

extension DocentAroundTableViewController {
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DocentListTableViewCell.reuseIdentifier, for: indexPath) as! DocentListTableViewCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let docentPlayListViewController = UIStoryboard(name: "Docent", bundle: nil).instantiateViewController(withIdentifier: DocentPlayListTableViewController.reuseIdentifier) as! DocentPlayListTableViewController
        self.navigationController?.pushViewController(docentPlayListViewController, animated: true)
    }
    
    
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
