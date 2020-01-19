//
//  File.swift
//  Calendar
//
//  Created by Next on 07/12/19.
//  Copyright © 2019 Next. All rights reserved.
//

import UIKit

class DayCell: UICollectionViewCell{
    
    
    var selectionBaseView: BaseView!
    var label: UILabel!
    
    
    
    var intValue: Int?{
        didSet{
            guard let _ = intValue else { return }
            label.text = intValue! == 0 ? "" : "\(intValue!)"
        }
    }
    
    override open var isSelected: Bool{
        didSet{
            selectionBaseView.shapeColor = isSelected ? .orange : .white
            label.textColor = isSelected ? .white : .black
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !subviews.contains(label){
            selectionBaseView = BaseView.init(with: .white, circular: true, shadow: false, borderColor: .clear, borderThickness: 0)
            self.addSubview(selectionBaseView)
            selectionBaseView.translatesAutoresizingMaskIntoConstraints = false
            [selectionBaseView.widthAnchor.constraint(equalToConstant: self.bounds.width - 10),
            selectionBaseView.heightAnchor.constraint(equalToConstant: self.bounds.width - 10),
            selectionBaseView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            selectionBaseView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0)].forEach({$0.isActive = true})
            self.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            [label.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
             label.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0)].forEach({$0.isActive = true})
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        label = UILabel()    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
