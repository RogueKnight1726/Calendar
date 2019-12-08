//
//  WeekdaysCollectionContainer.swift
//  Calendar
//
//  Created by Next on 07/12/19.
//  Copyright © 2019 Next. All rights reserved.
//

import UIKit

class WeekDysCollectionContainer: UIView{
    
    var weekdays = Calendar.current.shortWeekdaySymbols
    var weekdaysCollectionView: UICollectionView!
    var layout: UICollectionViewFlowLayout?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if layout == nil{
            layout = UICollectionViewFlowLayout()
            layout!.itemSize = CGSize.init(width: self.bounds.width / 7, height: self.bounds.width / 7)
            layout!.minimumInteritemSpacing = 0
            layout!.minimumLineSpacing = 0
            weekdaysCollectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout!)
            weekdaysCollectionView.backgroundColor = .white
            self.addSubview(weekdaysCollectionView)
        }
        weekdaysCollectionView.translatesAutoresizingMaskIntoConstraints = false
        [weekdaysCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
        weekdaysCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
        weekdaysCollectionView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
        weekdaysCollectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0)].forEach({$0.isActive = true})
        weekdaysCollectionView.register(WeekDayCollectionCell.self, forCellWithReuseIdentifier: "SomeIdentifier")
        weekdaysCollectionView.delegate = self
        weekdaysCollectionView.dataSource = self
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}


extension WeekDysCollectionContainer: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weekdays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SomeIdentifier", for: indexPath) as! WeekDayCollectionCell
        cell.dayName = weekdays[indexPath.row]
        return cell
    }
    
    
}
