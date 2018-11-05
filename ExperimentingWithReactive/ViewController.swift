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

class ViewController: UIViewController {
    
    @IBOutlet weak var priceSlider: UISlider!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var VATLabel: UILabel!
    @IBOutlet weak var VATAmoutLabel: UILabel!
    @IBOutlet weak var totalAmount: UILabel!

    let countriesDataSource = CountriesDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.dataSource = countriesDataSource
        pickerView.delegate = countriesDataSource
    
        //Initial Values of properties
        let initalPrice = priceSlider.value
        let initialVAT = countriesDataSource.vatValues[pickerView.selectedRow(inComponent: 0)]
        
        //Signals for properties
        let vatSignal = pickerView.reactive.selections
        let priceSignal = priceSlider.reactive.values
        
        //Properties
        let priceProperty = Property(initial: initalPrice, then: priceSignal)
        let vatProperty = Property(initial: initialVAT, then: vatSignal.map{(row,_) in self.countriesDataSource.vatValues[row]})
        let vatValueProperty = Property.combineLatest(priceProperty, vatProperty).map {$0 * $1 / 100}
        let totalProperty = Property.combineLatest(vatValueProperty, priceProperty).map{$0 + $1}
        
        VATLabel.reactive.text <~ vatProperty.map{"\($0)%"}
        priceLabel.reactive.text <~ priceProperty.map{String($0)}
        VATAmoutLabel.reactive.text <~ vatValueProperty.map{String($0)}
        totalAmount.reactive.text <~ totalProperty.map{String($0)}
        print("Hello")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nav = segue.destination as? AddCountryViewController{
            nav.delegate = self
        }
    }
}

extension ViewController:AddCountryViewControllerDelegate{
    func onDoneClick(country: String, vat: Float) {
        countriesDataSource.addCountry(country: country, with: vat)
        pickerView.reloadAllComponents()
    }
}
