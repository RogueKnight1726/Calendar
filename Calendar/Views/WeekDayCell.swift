//
//  WeekDayCell.swift
//  Calendar
//
//  Created by Next on 07/12/19.
//  Copyright © 2019 Next. All rights reserved.
//

import UIKit


class WeekDayCollectionCell: UICollectionViewCell{
    
    
    
    var label: UILabel!
    
    var dayName: String?{
        didSet{
            guard let _ = dayName else { return }
            label.text = dayName?.uppercased()
        }
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.translatesAutoresizingMaskIntoConstraints = false
        [label.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
         label.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0)].forEach({$0.isActive = true})
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
