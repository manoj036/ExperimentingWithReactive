//
//  DeleteTableViewController.swift
//  ExperimentingWithReactive
//
//  Created by manoj.gubba on 2018/11/06.
//  Copyright © 2018 manoj.gubba. All rights reserved.
//

import UIKit

protocol DeleteTableViewControllerDelegate: class {
    func deleteItems(at rows:[Int])
}

class DeleteTableViewController: UITableViewController {

    @IBAction func deleteItems(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
        if let indexPaths = tableView.indexPathsForSelectedRows{
            let rowsSorted = indexPaths.map {$0.row}
            var sortedRows = rowsSorted.sorted()
            sortedRows = sortedRows.reversed()
        
            delegate?.deleteItems(at: sortedRows)
        }
    }
   
    var countriesDataSource: CountriesDataSource?
    weak var delegate: DeleteTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ""
        self.tableView.allowsMultipleSelection = true
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesDataSource!.countries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeleteCell", for: indexPath)
        if let label = cell.viewWithTag(100) as? UILabel {
            label.text = countriesDataSource!.countries[indexPath.row].name
        }
        return cell
    }
}
