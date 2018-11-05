//
//  AddCountryViewController.swift
//  ExperimentingWithReactive
//
//  Created by manoj.gubba on 2018/11/05.
//  Copyright © 2018 manoj.gubba. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

protocol AddCountryViewControllerDelegate: class {
    func onDoneClick(country: String,vat: Float)
}


class AddCountryViewController: UITableViewController {

    @IBOutlet weak var countryText: UITextField!
    @IBOutlet weak var vatText: UITextField!
    @IBOutlet weak var doneOutlet: UIBarButtonItem!
    @IBOutlet weak var cancelOutlet: UIBarButtonItem!
    @IBOutlet weak var validLabel: UILabel!
    
    weak var delegate: AddCountryViewControllerDelegate?
    
    @IBAction func cancelButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func doneButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        delegate?.onDoneClick(country: (countryText?.text)!, vat: Float(vatText.text!)!)
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add Country"
        configureDoneButton()
    }
    
    func configureDoneButton(){
        let countrySignal = countryText.reactive.continuousTextValues
        let vatSignal = vatText.reactive.continuousTextValues
        
        let countryProperty = Property(initial: "", then: countrySignal)
        let vatProperty = Property(initial: "", then: vatSignal)
        
        let isVatValidSignal = vatSignal.map {self.isVatValid(in: $0!)}
        
        let property0 = Property.combineLatest(countryProperty, vatProperty).map {!(($0?.isEmpty)!||($1?.isEmpty)!)}
        let property1 = Property(initial: true, then: isVatValidSignal)
        
        let enable = Property.combineLatest(property0, property1).map{$0 && $1}
        doneOutlet.reactive.isEnabled <~ enable
        validLabel.reactive.isHidden <~ isVatValidSignal
    }
    
    func isVatValid(in text:String) -> Bool{
        if(text.isEmpty){return true}
        guard let number = Float(text) else{return false}
        if (number <= 100 && number >= 0){return true} else {return false}
    }
}
