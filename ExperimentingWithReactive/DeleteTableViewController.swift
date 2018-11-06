//
//  DeleteTableViewController.swift
//  ExperimentingWithReactive
//
//  Created by manoj.gubba on 2018/11/06.
//  Copyright © 2018 manoj.gubba. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        countriesDataSource = CountriesDataSource()
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
        return countriesDataSource!.countries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeleteCell", for: indexPath)
        if let label = cell.viewWithTag(100) as? UILabel {
            label.text = countriesDataSource!.countries[indexPath.row].name
        }
        return cell
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
