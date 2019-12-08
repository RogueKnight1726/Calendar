//
//  DayOffsetHelper.swift
//  Calendar
//
//  Created by Next on 07/12/19.
//  Copyright © 2019 Next. All rights reserved.
//

import UIKit

class DayOffsetHelper{
    static let instance = DayOffsetHelper()
    let schoolTimeZone = TimeZone.init(identifier: "Pacific/Kiritimati")
    
//    func getFirstDayOfMonthOffset(date: Date) -> Int{
//        let calendar = Calendar.current
//        var dateComponents: DateComponents? = calendar.dateComponents([.day,.month,.year,.weekday], from: date)
//        dateComponents?.day = 2
//        let firstDateOfMonth: Date? = calendar.date(from: dateComponents!)
//        return getFirstDayOfMonth(firstDateOfMonth!) ?? 0
//    }
    
    func getFirstDayOfMonth(_ date: Date) -> Int {
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: date)
        return weekDay
    }
    
    func getCurrentMonthIndex()->Int{
        let calendar = Calendar.current
        return calendar.dateComponents([.month], from: Date()).month ?? 0
    }
}


//You will need this
//let dateComponents = DateComponents(year: 2019, month: 2)
//let calendar = Calendar.current
//let experimentDate = calendar.date(from: dateComponents)!
