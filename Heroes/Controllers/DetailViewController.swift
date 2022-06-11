//
//  DetailViewController.swift
//  Heroes
//
//  Created by mac mini on 6/9/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "heroCell")
        return tableView
    }()
    
    var hero: Hero?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        let header = HeaderView(
            frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width))
        header.setImage(with: hero)
        tableView.tableHeaderView = header
        

        self.navigationItem.title = hero?.name
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }

}
// MARK: - UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate

extension DetailViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "heroCell", for: indexPath)
        cell.textLabel?.text = hero?.name
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let header = tableView.tableHeaderView as? HeaderView else { return }
        header.scrollViewDidScroll(scrollView: tableView)
    }

}
