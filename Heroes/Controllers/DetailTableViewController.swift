//
//  DetailTableViewController.swift
//  Heroes
//
//  Created by mac mini on 6/8/22.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    var hero: Hero?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = hero?.name
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "heroCell", for: indexPath)
        
        cell.textLabel?.text = "This is row \(indexPath.row)"
        
        return cell
    }
}
