//
//  ViewController.swift
//  ExperimentingWithReactive
//
//  Created by manoj.gubba on 2018/11/01.
//  Copyright © 2018 manoj.gubba. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Foundation
import Result

class ViewController: UIViewController  {
    
    @IBOutlet weak var priceSlider: UISlider!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var vatLabel: UILabel!
    @IBOutlet weak var vatAmountLabel: UILabel!
    @IBOutlet weak var totalAmount: UILabel!

    let countriesDataSource = CountriesDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        pickerView.dataSource = countriesDataSource
        pickerView.delegate = countriesDataSource
        
        //see if pickerView contains any data
        if (pickerView.numberOfRows(inComponent: 0) > 0) {
            //initial values for properties
            let initialVAT = countriesDataSource.countries[pickerView.selectedRow(inComponent: 0)].vat
            let initalPrice = priceSlider.value
            
            //Signals for properties
            let vatSignal = pickerView.reactive.selections
            let priceSignal = priceSlider.reactive.values
            
            //Properties
            let priceProperty = Property(initial: initalPrice, then: priceSignal)
            let vatProperty = Property(initial: initialVAT, then: vatSignal.map{(row,_) in self.countriesDataSource.countries[row].vat})
            let vatValueProperty = Property.combineLatest(priceProperty, vatProperty).map {$0 * $1 / 100}
            let totalProperty = Property.combineLatest(vatValueProperty, priceProperty).map{$0 + $1}
            
            vatLabel.reactive.text <~ vatProperty.map{"\($0)%"}
            priceLabel.reactive.text <~ priceProperty.map{String($0)}
            vatAmountLabel.reactive.text <~ vatValueProperty.map{String($0)}
            totalAmount.reactive.text <~ totalProperty.map{String($0)}
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nav = segue.destination as? AddCountryViewController{
            nav.delegate = self
        }
        if let nav = segue.destination as? DeleteTableViewController{
            nav.delegate = self
            nav.countriesDataSource = countriesDataSource
        }
    }
}

extension ViewController:AddCountryViewControllerDelegate{
    func onDoneClick(name: String, vat: Float) {
        countriesDataSource.addCountry(name: name, vat: vat)
        pickerView.reloadAllComponents()
    }
}

extension ViewController:DeleteTableViewControllerDelegate{
    func deleteItems(at rows: [Int]) {
        for row in rows{
            countriesDataSource.deleteCountry(at: row)
            pickerView.reloadAllComponents()
        }
    }
}

