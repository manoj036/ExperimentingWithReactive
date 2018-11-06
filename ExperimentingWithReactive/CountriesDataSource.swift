//
//  CountriesDataSource.swift
//  ExperimentingWithReactive
//
//  Created by manoj.gubba on 2018/11/05.
//  Copyright © 2018 manoj.gubba. All rights reserved.
//

import UIKit

final class CountriesDataSource: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var countries = [Country]()
    
    func addCountry(name:String,vat:Float){
        let country = Country(entity: Country.entity(), insertInto: context)
        country.name = name
        country.vat = vat
        countries.append(country)
        appDelegate.saveContext()
    }
    
    func deleteCountry(at row:Int){
        let obj = countries[row]
        countries.remove(at: row)
        context.delete(obj)
        appDelegate.saveContext()
    }
    
    override init() {
        super.init()
        do{
            countries = try context.fetch(Country.fetchRequest())
        }catch let error as NSError {
            print("Could not fetch. \(error),\(error.userInfo)")
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row].name
    }
}
