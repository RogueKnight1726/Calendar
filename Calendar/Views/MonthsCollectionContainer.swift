//
//  MonthsCollectionContainer.swift
//  Calendar
//
//  Created by Next on 08/12/19.
//  Copyright © 2019 Next. All rights reserved.
//

import UIKit


class MonthsCollectionContainer: UIView{
    
    var layout: UICollectionViewFlowLayout!
    var monthCollectionVieW: UICollectionView!
    var monthsArray = Calendar.current.monthSymbols
    var delegate: MonthSelectionDelegate?
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if layout == nil{
            layout = UICollectionViewFlowLayout()
            layout!.itemSize = CGSize.init(width: 120, height: 60)
            layout!.minimumInteritemSpacing = 0
            layout.scrollDirection = .horizontal
            layout!.minimumLineSpacing = 16
            layout.sectionInset = UIEdgeInsets.init(top: 0, left: (self.bounds.width / 2) - 60, bottom: 0, right: (self.bounds.width / 2) - 60)
            monthCollectionVieW = UICollectionView.init(frame: .zero, collectionViewLayout: layout!)
            monthCollectionVieW.backgroundColor = .white
            monthCollectionVieW.showsHorizontalScrollIndicator = false
            self.addSubview(monthCollectionVieW)
            
            monthCollectionVieW.translatesAutoresizingMaskIntoConstraints = false
            [monthCollectionVieW.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
             monthCollectionVieW.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
             monthCollectionVieW.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
             monthCollectionVieW.topAnchor.constraint(equalTo: self.topAnchor, constant: 0)].forEach({$0.isActive = true})
            monthCollectionVieW.register(MonthCollectionCell.self, forCellWithReuseIdentifier: "SomeIdentifier")
            monthCollectionVieW.delegate = self
            monthCollectionVieW.dataSource = self
            
//            monthCollectionVieW.selectItem(at: IndexPath.init(row: DayOffsetHelper.instance.getCurrentMonthIndex() - 1, section: 0), animated: false, scrollPosition: .centeredHorizontally)
//            monthCollectionVieW.scrollToItem(at: IndexPath.init(row: DayOffsetHelper.instance.getCurrentMonthIndex() - 1, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}



extension MonthsCollectionContainer: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return monthsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SomeIdentifier", for: indexPath) as! MonthCollectionCell
        cell.monthName = monthsArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        delegate?.selectedMonthAt(index: indexPath.row)
    }
}


protocol MonthSelectionDelegate{
    func selectedMonthAt(index: Int)
    func selectedYear(year: Int)
}
