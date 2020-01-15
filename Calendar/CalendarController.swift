//
//  ViewController.swift
//  Calendar
//
//  Created by Next on 30/11/19.
//  Copyright © 2019 Next. All rights reserved.
//

import UIKit

class CalendarController: UIViewController {

    var guide                   : UILayoutGuide!
    var yearLabel               = UILabel()
    
    var daysCollectionView      : UICollectionView!
    var daysCollectionLayout    : UICollectionViewFlowLayout!
    var weekdaysContainer       : WeekDysCollectionContainer!
    
    var monthsContainer         : MonthsCollectionContainer!
    
    var yearContainer           : YearCollectionContainer!
    var selectedYear            = Calendar.current.dateComponents([.year], from: Date()).year
    var selectedMonthIndex      = 12
    
    
    
    var selectedCalendar                : Calendar!
    var selectedCalendarDaysArray       : [Int]!{
        didSet{
            daysCollectionView.reloadData()
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        initViews()
    }
    
    
    func initViews(){
        guide = view.safeAreaLayoutGuide
        
        yearContainer = YearCollectionContainer()
        view.addSubview(yearContainer)
        yearContainer.translatesAutoresizingMaskIntoConstraints = false
        [yearContainer.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
         yearContainer.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
         yearContainer.topAnchor.constraint(equalTo: guide.topAnchor, constant: 20),
         yearContainer.heightAnchor.constraint(equalToConstant: 60)].forEach({ $0.isActive = true })
        yearContainer.delegate = self
        yearContainer.clipsToBounds = false
        
        monthsContainer = MonthsCollectionContainer()
        view.addSubview(monthsContainer)
        monthsContainer.translatesAutoresizingMaskIntoConstraints = false
        [monthsContainer.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
         monthsContainer.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
         monthsContainer.topAnchor.constraint(equalTo: yearContainer.bottomAnchor, constant: 0),
         monthsContainer.heightAnchor.constraint(equalToConstant: 60)].forEach({ $0.isActive = true })
        monthsContainer.delegate = self
        
        weekdaysContainer = WeekDysCollectionContainer()
        view.addSubview(weekdaysContainer)
        weekdaysContainer.translatesAutoresizingMaskIntoConstraints = false
        [weekdaysContainer.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
         weekdaysContainer.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
         weekdaysContainer.topAnchor.constraint(equalTo: monthsContainer.bottomAnchor, constant: 0),
         weekdaysContainer.heightAnchor.constraint(equalToConstant: view.bounds.width / 7)].forEach({$0.isActive = true})
        
        
        daysCollectionLayout = UICollectionViewFlowLayout.init()
        daysCollectionLayout.itemSize = CGSize.init(width: view.bounds.width / 7, height: view.bounds.width / 7)
        daysCollectionLayout.minimumInteritemSpacing = 0
        daysCollectionLayout.minimumLineSpacing = 0
        daysCollectionView = UICollectionView.init(frame: .zero, collectionViewLayout: daysCollectionLayout)
        view.addSubview(daysCollectionView)
        daysCollectionView.translatesAutoresizingMaskIntoConstraints = false
        [daysCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
        daysCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
        daysCollectionView.topAnchor.constraint(equalTo: weekdaysContainer.bottomAnchor, constant: 0),
        daysCollectionView.heightAnchor.constraint(equalToConstant: (view.bounds.width / 7) * 6 )].forEach({$0.isActive = true})
        daysCollectionView.backgroundColor = .white
        
        daysCollectionView.register(DayCell.self, forCellWithReuseIdentifier: "SomeIdentifier")
        daysCollectionView.delegate = self
        daysCollectionView.dataSource = self
        
        changeMonthAndYear(month: 12, year: 2019)
        
        
        
        
        
    }
    
    func changeMonthAndYear(month: Int,year: Int){
        let dateComponents = DateComponents(year: year, month: month)
        let calendar = Calendar.current
        let experimentDate = calendar.date(from: dateComponents)!


        selectedCalendarDaysArray = []
        daysCollectionView.reloadData()
        selectedCalendar = Calendar.current
        let range = selectedCalendar.range(of: .day, in: .month, for: experimentDate)
        selectedCalendarDaysArray = Array(range!)
        
        for _ in 0..<DayOffsetHelper.instance.getFirstDayOfMonth(experimentDate) - 1{
            selectedCalendarDaysArray.insert(0, at: 0)
        }
        daysCollectionView.reloadData()
    }


}



extension CalendarController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedCalendarDaysArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SomeIdentifier", for: indexPath) as! DayCell
        cell.intValue = selectedCalendarDaysArray[indexPath.row]
        return cell
    }
    
    
}



extension CalendarController: MonthSelectionDelegate{
    func selectedYear(year: Int) {
        selectedYear = year
        changeMonthAndYear(month: selectedMonthIndex + 1, year: selectedYear!)
    }
    
    func selectedMonthAt(index: Int) {
        if let _ = selectedYear{
            selectedMonthIndex = index
            changeMonthAndYear(month: index + 1, year: selectedYear!)
        }
    }
}
