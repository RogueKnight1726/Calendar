//
//  HighlightedDate.swift
//  Calendar
//
//  Created by Next on 19/01/20.
//  Copyright © 2020 Next. All rights reserved.
//

import UIKit


class HighlightedDate: NSObject{
    
    var day: Day!
    var month: Month!
    var year: Year!
    
    convenience init(day: Day, month: Month, year: Year){
        self.init()
        self.day = day
        self.month = month
        self.year = year
    }
}
