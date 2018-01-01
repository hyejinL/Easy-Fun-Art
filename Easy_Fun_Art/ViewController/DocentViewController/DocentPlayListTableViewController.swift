//
//  DocentPlayListTableViewController.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 1..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class DocentPlayListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        setUpTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 5
        } else if section == 1 {
            return 2
        } else {
            return 3
        }
    }
}

extension DocentPlayListTableViewController {
    func setUpTableView() {
        self.tableView.register(UINib(nibName: DocentPlayListHeaderCell.reuseIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: DocentPlayListHeaderCell.reuseIdentifier)
        self.tableView.tableFooterView = UIView(frame: .zero)
    }
}

extension DocentPlayListTableViewController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: DocentPlayListHeaderCell.reuseIdentifier) as! DocentPlayListHeaderCell
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 46.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DocentPlayListTableViewCell.reuseIdentifier, for: indexPath) as! DocentPlayListTableViewCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let docentPlayerViewController = UIStoryboard(name: "Docent", bundle: nil).instantiateViewController(withIdentifier: DocentPlayerViewController.reuseIdentifier) as! DocentPlayerViewController
        self.present(docentPlayerViewController, animated: true, completion: nil)
    }
}
