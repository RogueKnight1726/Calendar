//
//  BaseView.swift
//  Calendar
//
//  Created by Next on 01/12/19.
//  Copyright © 2019 Next. All rights reserved.
//
import UIKit


class BaseView: UIView{
    
    
    var roundedShape: CAShapeLayer!
    var curvedPath: UIBezierPath!
    var shapeColor: UIColor!{
        didSet{
            roundedShape.fillColor = shapeColor.cgColor
        }
    }
    var circular: Bool!
    var shadow: Bool!
    var shadowLayer: CAShapeLayer!
    //    var borderColor: UIColor?
    var borderColor: CGColor?
    var borderThickness: CGFloat?
    
    
    
    convenience init(with backgroundTheme: UIColor, circular: Bool, shadow: Bool){
        self.init()
        shapeColor = backgroundTheme
        self.circular = circular
        self.shadow = shadow
    }
    convenience init(with backgroundTheme: UIColor, circular: Bool, shadow: Bool,borderColor: UIColor){
        self.init()
        shapeColor = backgroundTheme
        self.circular = circular
        self.shadow = shadow
        self.borderColor = borderColor.cgColor
    }
    
    convenience init(with backgroundTheme: UIColor, circular: Bool, shadow: Bool,borderColor: UIColor?,borderThickness: Int?){
        self.init()
        shapeColor = backgroundTheme
        self.circular = circular
        self.shadow = shadow
        self.borderThickness = CGFloat(borderThickness ?? 0)
        self.borderColor = borderColor?.cgColor
        
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        curvedPath = UIBezierPath.init(roundedRect: self.bounds, cornerRadius: self.circular ? self.bounds.height / 2 : 15)
        roundedShape = CAShapeLayer()
        roundedShape.path = curvedPath.cgPath
        roundedShape.fillColor = shapeColor.cgColor
        if let unwrappedBorderColor = self.borderColor {
            roundedShape.borderWidth = 2
            roundedShape.borderColor = unwrappedBorderColor
        }
        self.layer.insertSublayer(roundedShape, at: 0)
        if shadow{
            shadowLayer = CAShapeLayer()
            shadowLayer.shadowColor = UIColor.gray.cgColor
            shadowLayer.shadowRadius = 4
            shadowLayer.shadowOpacity = 0.6
            shadowLayer.shadowOffset = CGSize(width: 0, height: 6)
            shadowLayer.path = curvedPath.cgPath
            //            shadowLayer.fillColor = UIColor.white.cgColor
            layer.insertSublayer(shadowLayer, below: roundedShape)
        }
        
        
    }
}

