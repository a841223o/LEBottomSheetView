
//  BottomSheetView.swift
//  TEMPHAWK
//
//  Created by DongLunYou on 2019/6/4.
//  Copyright © 2019年 FoxCat.co. All rights reserved.
//

import Foundation
import UIKit

public enum SheetStation {
    case top
    case center
    case bottom
    case inVisable
}
public enum BarLineStation{
    case inToolBar
    case outToolBar
    case inVisable
}
public class BottomSheetView : UIView {
    
    var toolBar : UIView!
    var toolBarHeight : CGFloat = 30
    var childView : UIView!
    var barLine : UIImageView!
    var image : UIImage!
    
    var topY : CGFloat = 0
    var bottomY : CGFloat = 0
    var centerY : CGFloat = 0
    var inVisableY : CGFloat =  0
    var topCornerRadius : Double = 20
    
    public var station : SheetStation = .center {
        didSet{
            switch station {
            case .top:
                self.frame.origin = CGPoint.init(x: 0, y: topY )
            case .center:
                self.frame.origin = CGPoint.init(x: 0, y: centerY )
            case .bottom:
                self.frame.origin = CGPoint.init(x: 0, y: bottomY )
            case .inVisable:
                self.frame.origin = CGPoint.init(x: 0, y: inVisableY)
            }
        }
    }
    
    public var barLineStation : BarLineStation = .inToolBar {
        didSet{
            switch barLineStation {
            case .inToolBar:
                barLine.removeFromSuperview()
                barLine.center = CGPoint.init(x: self.width*0.5, y: self.toolBar.y + 15)
                self.addSubview(barLine)
            case .outToolBar:
                barLine.removeFromSuperview()
                barLine.center = CGPoint.init(x: self.width*0.5, y: self.y - 15)
                self.superview?.addSubview(barLine)
            case .inVisable:
                barLine.removeFromSuperview()
            }
        }
    }
    
    public init(frame: CGRect , superview : UIView) {
        super.init(frame: frame)
        superview.addSubview(self)
        
        setupToolBar()
        setupChildView()
        setupBarLine()
        
        self.roundCorner(radious: topCornerRadius, rectCorners: [.topLeft,.topRight])
        self.bottomY = superview.frame.height - self.toolBar.frame.height
        self.centerY = bottomY - self.frame.height/2
        self.topY = bottomY - self.childView.frame.height
        self.inVisableY = superview.frame.height
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupToolBar(){
        toolBar = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.width, height: toolBarHeight))
        toolBar.backgroundColor = UIColor.white
        self.addSubview(toolBar)
        let panGesture = UIPanGestureRecognizer.init(target: self, action: #selector(handel(recognizer:)))
        toolBar.addGestureRecognizer(panGesture)
    }
    
    func setupChildView(){
        childView = UIView.init(frame: CGRect.init(x: 0, y: toolBar.frame.height, width: self.frame.width, height: self.frame.height-toolBar.frame.height))
        childView.backgroundColor  =  UIColor.white
        self.addSubview(childView)
    }
    
    func setupBarLine(){
        image = UIImage.bundledImage(named: "barLine")
        
        barLine = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 60 , height: 30))
        barLine.image = image
        barLine.tintColor = UIColor.white
        barLine.center = CGPoint.init(x: self.width*0.5, y: self.toolBar.y + 15)
        barLine.contentMode = .scaleAspectFill
        self.addSubview(barLine)
    }
    public func setBarLineColor(color :UIColor){
        image =  image.tint(color, blendMode: .destinationIn)
    }
    
    public func setChildeViewBackgroundColor(color : UIColor){
        self.childView.backgroundColor = color
    }
    
    public  func setToolBarBackgroundColor(color : UIColor){
        self.toolBar.backgroundColor = color
    }
    public func setBottomSheetViewBackgroundColor(color : UIColor){
        self.toolBar.backgroundColor = color
        self.childView.backgroundColor = color
    }
    
    @objc func handel(recognizer:UIPanGestureRecognizer){
        
        let translation = recognizer.translation(in: self)
        if self.frame.origin.y + translation.y <= topY {
            self.frame.origin = CGPoint.init(x: 0, y: topY )
            
        }else if self.frame.origin.y + translation.y >= bottomY {
            self.frame.origin = CGPoint.init(x: 0, y: bottomY)
            
        }else{
            self.frame.origin = CGPoint.init(x: 0, y: self.frame.origin.y + translation.y)
            
            //            setChildeViewBackgroundColor(color: UIColor.themeColor.lighten().withAlphaComponent(0.7+0.4*((self.frame.height-self.frame.origin.y)/self.frame.height)))
            //            setToolBarBackgroundColor(color: UIColor.themeColor.lighten().withAlphaComponent(0.7+0.4*((self.frame.height-self.frame.origin.y)/self.frame.height)))
        }
        if barLineStation == .outToolBar{
            self.barLineStation =  .outToolBar
        }
        
        recognizer.setTranslation(CGPoint.zero, in: self.superview)
        
        if recognizer.state == UIGestureRecognizer.State.ended {
            let height =  abs(self.frame.origin.y - self.topY)
            let bottom =  abs(self.frame.origin.y - self.bottomY)
            let center =  abs(self.frame.origin.y - self.centerY)
            print("\(height),\(bottom),\(center)")
            if self.frame.origin.y < self.centerY {
                switch height < center {
                case true :
                    UIView.animate(withDuration: 0.1, animations: {
                        self.station = .top
                    } )
                case false :
                    UIView.animate(withDuration: 0.1, animations: {
                        self.station = .center
                    } )
                    
                }
            }else{
                switch bottom < center {
                case true :
                    UIView.animate(withDuration: 0.1, animations: {
                        self.station = .bottom
                    } )
                    
                case false :
                    UIView.animate(withDuration: 0.1, animations: {
                        self.station = .center
                    } )
                }
            }
            if barLineStation == .outToolBar{
                self.barLineStation =  .outToolBar
            }
        }
        
        
    }
    
}
