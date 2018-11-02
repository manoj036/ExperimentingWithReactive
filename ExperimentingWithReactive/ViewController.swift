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

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var priceSlider: UISlider!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var VATLabel: UILabel!
    @IBOutlet weak var VATAmoutLabel: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    
    let VATCountries = ["India","Japan","Bangladesh","Pakisthan","Brazil","Australia","United States"]
    let VATValues:[Float] = [25,32.11,35,35,34,28.5,21]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        
        let initalPrice = priceSlider.value
        let initialVAT = VATValues[pickerView.selectedRow(inComponent: 0)]
        
        let pickerSignal = pickerView.reactive.selections
        let sliderSignal = priceSlider.reactive.values
        
        let priceProperty = Property(initial: initalPrice, then: sliderSignal)
        let vatProperty = Property(initial: initialVAT, then: pickerSignal.map{(row,_) in self.VATValues[row]})
        let vatValueProperty = Property.combineLatest(priceProperty, vatProperty).map {$0 * $1 / 100}
        let totalProperty = Property.combineLatest(vatProperty, priceProperty).map{$0 + $1}
        
        VATLabel.reactive.text <~ vatProperty.map{"\($0)%"}
        priceLabel.reactive.text <~ priceProperty.map{String($0)}
        VATAmoutLabel.reactive.text <~ vatValueProperty.map{String($0)}
        totalAmount.reactive.text <~ totalProperty.map{String($0)}
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return VATCountries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return VATCountries[row]
    }
}
