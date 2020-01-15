//
//  YearCollectionContainer.swift
//  Calendar
//
//  Created by Next on 08/12/19.
//  Copyright © 2019 Next. All rights reserved.
//

import UIKit

class YearCollectionContainer: UIView{
    
    
    var layout: UICollectionViewFlowLayout!
    var yearCollectionView: UICollectionView!
    var yearArray: [Int] = Array(1990...2030)
    var delegate: MonthSelectionDelegate?
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if layout == nil{
            layout = UICollectionViewFlowLayout()
            layout!.itemSize = CGSize.init(width: self.bounds.width / 3, height: 60)
            layout!.minimumInteritemSpacing = 0
            layout.scrollDirection = .horizontal
            layout!.minimumLineSpacing = 0
//            layout.sectionInset = UIEdgeInsets.init(top: 0, left: (self.bounds.width / 2) - 60, bottom: 0, right: (self.bounds.width / 2) - 60)
            layout.sectionInset = UIEdgeInsets.init(top: 0, left: self.bounds.width - (2 * self.bounds.width / 3),bottom: 0, right: (self.bounds.width / 2) - 60)
            yearCollectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout!)
            yearCollectionView.backgroundColor = .white
            yearCollectionView.showsHorizontalScrollIndicator = false
            self.addSubview(yearCollectionView)
            
            yearCollectionView.translatesAutoresizingMaskIntoConstraints = false
            [yearCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
             yearCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
             yearCollectionView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
             yearCollectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0)].forEach({$0.isActive = true})
            yearCollectionView.register(MonthCollectionCell.self, forCellWithReuseIdentifier: "SomeIdentifier")
            yearCollectionView.delegate = self
            yearCollectionView.dataSource = self
            yearCollectionView.clipsToBounds = false
//            yearCollectionView.isPagingEnabled = true
            
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


extension YearCollectionContainer: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return yearArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SomeIdentifier", for: indexPath) as! MonthCollectionCell
        cell.monthName = "\(yearArray[indexPath.row])"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        delegate?.selectedYear(year: yearArray[indexPath.row])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.x)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    }
    
}
