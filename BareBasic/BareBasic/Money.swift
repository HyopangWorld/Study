//
//  Money.swift
//  BareBasic
//
//  Created by 김효원 on 09/07/2019.
//  Copyright © 2019 HyowonKim. All rights reserved.
//

import Foundation

enum Currency:Int{
    case USD = 0, KRW, JPY, EUR
    
    var ratio:Double{
        get{
            switch self {
            case .USD: return 1.0
            case .KRW: return 1178.5
            case .JPY: return 122.45
            case .EUR: return 0.92
            }
        }
    }
    
    var simbol:String{
        get{
            switch self {
            case .USD: return "$"
            case .KRW: return "₩"
            case .JPY: return "¥"
            case .EUR: return "£"
            }
        }
    }
}

struct Money{
    var usDallor = 0.0
    
    init(_ _usDallor: Double) {
        usDallor = _usDallor
    }
    
    init(_ amount: Double, currency: Currency){
        usDallor = amount / currency.ratio
    }
    
    func valueInCurrency(currency: Currency) -> String{
        var val = round((usDallor * currency.ratio) * 100)
        return "\(currency.simbol)" + "\(val/100)"
    }
}

