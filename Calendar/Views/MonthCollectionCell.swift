//
//  MonthCollectionCell.swift
//  Calendar
//
//  Created by Next on 01/12/19.
//  Copyright © 2019 Next. All rights reserved.
//

import UIKit


class MonthCollectionCell: UICollectionViewCell{
    
    var monthNameLabel : UILabel!
    var backgroundBaseView: BaseView!
    var monthName: String!{
        didSet{
            monthNameLabel?.text = monthName
        }
    }
    
    override open var isSelected: Bool{
        didSet{
            if isSelected{
                backgroundBaseView.shapeColor = .blue
                monthNameLabel.textColor = .white
                return
            }
            backgroundBaseView.shapeColor = .white
            monthNameLabel.textColor = .black
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !subviews.contains(monthNameLabel) {
            backgroundBaseView = BaseView.init(with: .white, circular: false, shadow: false, borderColor: .green, borderThickness: 2)
            self.addSubview(backgroundBaseView)
            backgroundBaseView.translatesAutoresizingMaskIntoConstraints = false
            [backgroundBaseView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            backgroundBaseView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            backgroundBaseView.heightAnchor.constraint(equalToConstant: 50),
            backgroundBaseView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0)].forEach({$0.isActive = true})
            self.addSubview(monthNameLabel!)
            monthNameLabel!.translatesAutoresizingMaskIntoConstraints = false
            [monthNameLabel!.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
             monthNameLabel!.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0)].forEach({$0.isActive = true})
            monthNameLabel!.font = UIFont.systemFont(ofSize: 18, weight: .black)
            
        
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        monthNameLabel = UILabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
