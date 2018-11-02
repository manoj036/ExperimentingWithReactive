//
//  PickerView.swift
//  ExperimentingWithReactive
//
//  Created by manoj.gubba on 2018/11/01.
//  Copyright © 2018 manoj.gubba. All rights reserved.
//

import UIKit

class PickerView: UIPickerView, UIPickerViewDataSource {
   
    let VATInCountries = ["India":25,"Japan":32.11,"Bangladesh":35,"Pakisthan":35,"Brazil":34,"Australia":28.5,"United States":21]
    
//    override weak var dataSource: UIPickerViewDataSource? {
//        get{
////            return VATInCountries.keys
//        }
//        set{}
//    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return VATInCountries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return VATInCountries.count
    }
    


}
