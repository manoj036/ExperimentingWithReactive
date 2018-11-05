//
//  CountriesDataSource.swift
//  ExperimentingWithReactive
//
//  Created by manoj.gubba on 2018/11/05.
//  Copyright © 2018 manoj.gubba. All rights reserved.
//

import UIKit

final class CountriesDataSource: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var vatCountries = ["India","Japan","Bangladesh","Pakisthan","Brazil","Australia","United States"]
    var vatValues:[Float] = [25,32.11,35,35,34,28.5,21]
    
    func addCountry(country: String,with vat: Float){
        vatCountries.append(country)
        vatValues.append(vat)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return vatCountries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return vatCountries[row]
    }
}
