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
        calendar.timeZone = Date().getTimeZone()
        
        
        var dateComponents: DateComponents? = calendar.dateComponents([.day,.month,.year], from: Date())
        
        dateComponents?.day = 2
        dateComponents?.month = 11
        return calendar.date(from: dateComponents!)!
    }

    struct currentTimeZone{
        static var selectedTimeZone: TimeZone?
    }
    
    func getTimeZone()->TimeZone{
        return Date.currentTimeZone.selectedTimeZone ?? TimeZone.init(abbreviation: "UTC")!
    }
    
    func getMonthNameFrom(index: Int) -> String{
        let monthsArray = Calendar.selectedCalendar.monthSymbols
        let monthName = monthsArray[index - 1]
        return monthName
    }
}


extension Calendar{
    
    static var selectedCalendar: Calendar = {
        var calendar = Calendar.current
        calendar.timeZone = Date().getTimeZone()
        return calendar
    }()
}


protocol DaySelectionProtocol: AnyObject{
    func selectedDateFromCalendar()
}
