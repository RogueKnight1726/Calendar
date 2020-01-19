//
//  ViewController.swift
//  Calendar
//
//  Created by Next on 30/11/19.
//  Copyright © 2019 Next. All rights reserved.
//

import UIKit

class CalendarController: UIViewController {

    var guide                           : UILayoutGuide!
    var yearLabel                       = UILabel()
    
    var daysCollectionView              : UICollectionView!
    var daysCollectionLayout            : UICollectionViewFlowLayout!
    var weekdaysContainer               : WeekDysCollectionContainer!
    var monthsContainer                 : MonthsCollectionContainer!
    var yearContainer                   : YearCollectionContainer!
    var selectedYear                    = Calendar.current.dateComponents([.year], from: Date()).year
    var selectedMonthIndex              = 12
    var selectedCalendar                : Calendar!
    var selectedCalendarDaysArray       : [Int]!{
        didSet{
            daysCollectionView.reloadData()
        }
    }
    
    var selectionTYpe: SelectionType = .Single
    
    var highlightedDate: HighlightedDate! {
        didSet{
            
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        setInitialValue()
        initViews()
    }
    
    
    func setInitialValue(){
        let calendar = Calendar.selectedCalendar
        let dateComponents: DateComponents! = calendar.dateComponents([.day,.month,.year], from: Date())
        print(Date().getMonthNameFrom(index: dateComponents.month ?? 14))
        let day = Day.init(with: dateComponents.day ?? 1)
        let year = Year.init(with: dateComponents.year ?? 2020)
        let month = Month.init(with: Date().getMonthNameFrom(index: dateComponents.month ?? 11))
        let highlightedDate = HighlightedDate.init(day: day, month: month, year: year)
        self.highlightedDate = highlightedDate
    }
    
    
    func changeMonthAndYear(){
        let dateComponents = DateComponents(year: highlightedDate.year.value, month: highlightedDate.month?.getMonthIndex())
        let calendar = Calendar.current
        let experimentDate = calendar.date(from: dateComponents)!
        selectedCalendarDaysArray = []
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch selectionTYpe{
        case .Single:
            break
        case .Multiple:
            break
        }
    }
    
    
}

extension CalendarController: DaySelectionProtocol{
    func selectedDateFromCalendar() {
        print("Day selected is : \(highlightedDate.day!) - \(highlightedDate.month!) - \(highlightedDate.year!)")
        changeMonthAndYear()
    }
}



extension CalendarController{
    
    
    func initViews(){
        guide = view.safeAreaLayoutGuide
        
        yearContainer = YearCollectionContainer()
        yearContainer.highlightedDate = self.highlightedDate
        view.addSubview(yearContainer)
        yearContainer.translatesAutoresizingMaskIntoConstraints = false
        [yearContainer.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
         yearContainer.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
         yearContainer.topAnchor.constraint(equalTo: guide.topAnchor, constant: 20),
         yearContainer.heightAnchor.constraint(equalToConstant: 60)].forEach({ $0.isActive = true })
        yearContainer.delegate = self
        yearContainer.clipsToBounds = false
        
        monthsContainer = MonthsCollectionContainer()
        monthsContainer.highlightedDate = highlightedDate
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
        changeMonthAndYear()
    }
}
