//
//  Month.swift
//  Calendar
//
//  Created by Next on 01/12/19.
//  Copyright © 2019 Next. All rights reserved.
//

import UIKit

struct Month{
    
    var name: String!
    
    init(with monthValue: String){
        name = monthValue
    }
    
    func getMonthIndex() -> Int{
        return Calendar.current.monthSymbols.firstIndex(of: name) ?? 1
    }
}
