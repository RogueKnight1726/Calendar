//
//  Extensions.swift
//  Calendar
//
//  Created by Next on 07/12/19.
//  Copyright © 2019 Next. All rights reserved.
//

import UIKit

extension Date{
    
    func getFirstDateOfMonth() -> Date{
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.init(abbreviation: "UTC")!
        
        var dateComponents: DateComponents? = calendar.dateComponents([.day,.month,.year], from: Date())
        
        dateComponents?.day = 2
        dateComponents?.month = 11
        return calendar.date(from: dateComponents!)!
    }
}
