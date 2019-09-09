//
//  ViewController.swift
//  BareBasic
//
//  Created by 김효원 on 09/07/2019.
//  Copyright © 2019 HyowonKim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var currencySegment: UISegmentedControl!
    @IBOutlet weak var sourceMoneyField: UITextField!
    @IBOutlet weak var targetMoneyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func convertMoney(_ sender: Any) {
        guard let mCurrency
            = Currency(rawValue: currencySegment.selectedSegmentIndex) else {
                targetMoneyLabel.text = "환율 정보를 선택해 주세요."
                return
        }
        guard let sourceAmount
            = Double(sourceMoneyField.text!) else {
                targetMoneyLabel.text = "환율 값을 입력해 주세요."
                return
        }
        
        
        let sourceMoney = Money(sourceAmount, currency: mCurrency)
        var targetMoneyString = ""
        
        for i in 0..<4{
            targetMoneyString
                += sourceMoney.valueInCurrency(currency: Currency.init(rawValue: i)!)
            targetMoneyString += "\r\n"
        }
        
        targetMoneyLabel.text = targetMoneyString
    }
    
}

