
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
            self.childView.frame.size = CGSize.init(width: self.frame.width, height: self.frame.height - self.frame.origin.y - self.toolBar.frame.height )
            if  self.childView.subviews.count > 0 {
                self.childView.subviews[0].frame.size = self.childView.frame.size
            }
            switch self.barLineStation {
            case .inToolBar:
                self.barLineStation = .inToolBar
            case .outToolBar:
                self.barLineStation = .outToolBar
            case .inVisable:
                break
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
        self.setTopCenterBottom(topY: 50 ,
                                centerY:  self.frame.height/2,
                                bottomY: superview.frame.height-70)
        self.roundCorner(radious: topCornerRadius, rectCorners: [.topLeft,.topRight])
        self.setTootBarHeihgt(height: 60)
        self.inVisableY = superview.frame.height
   
    }
    func setupToolBar(){
        toolBar = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.width, height: toolBarHeight))
        toolBar.backgroundColor = UIColor.white
        let panGesture =  UIPanGestureRecognizer.init(target: self, action: #selector(handel(recognizer:)))
        toolBar.addGestureRecognizer(panGesture)
        self.addSubview(toolBar)
    }
    
    func setupChildView(){
        childView = UIView.init(frame: CGRect.init(x: 0, y: toolBar.frame.height,width: self.frame.width, height: self.frame.height - self.frame.origin.y - self.toolBar.frame.height))
        childView.backgroundColor  =  UIColor.white
        self.addSubview(childView)
        let lineGesture =  UIPanGestureRecognizer.init(target: self, action: #selector(handel(recognizer:)))
        childView.addGestureRecognizer(lineGesture)
    }
    
    func setupBarLine(){
        image = UIImage.bundledImage(named: "barLine")
        image = image.tint(.gray, blendMode: .destinationIn)
        barLine = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 60 , height: 30))
        barLine.image = image
        barLine.center = CGPoint.init(x: self.width*0.5, y: self.toolBar.y + 15)
        barLine.contentMode = .scaleAspectFill
        self.addSubview(barLine)
    }
    
    func updateUI(){
        toolBar.frame = CGRect.init(x: 0, y: 0, width: self.frame.width, height: toolBarHeight)
        childView.frame = CGRect.init(x: 0, y: toolBar.frame.height,width: self.frame.width, height: self.frame.height - self.frame.origin.y - self.toolBar.frame.height)
        barLine.frame = CGRect.init(x: 0, y: 0, width: 60 , height: 30)
        switch self.station {
        case .bottom:
            self.station = .bottom
        case .top:
            self.station = .top
        case .center:
            self.station = .center
        case .inVisable:
            self.station = .inVisable
        }
    }
    
    public func setTootBarHeihgt(height : CGFloat){
        self.toolBarHeight  =  height
        updateUI()
//        self.bottomY = self.superview!.frame.height - self.toolBar.frame.height
//        self.centerY = bottomY - self.frame.height/2
//        self.topY = bottomY - self.childView.frame.height
    }
    
    //MARK: fix bottomY < toolBar  is error
    public func setTopCenterBottom(topY : CGFloat , centerY : CGFloat , bottomY : CGFloat){
        self.bottomY = bottomY
        self.centerY = centerY
        self.topY = topY
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    public func setBarLineImage(color : UIColor? = nil , size : CGSize? = nil , image: UIImage? = nil ){
       
        if let size = size {
            self.barLine.frame.size =  size
            switch self.barLineStation {
            case .inToolBar:
                self.barLineStation = .inToolBar
            case .outToolBar:
                self.barLineStation = .outToolBar
            case .inVisable:
                break
            }
        }
        if let image = image {
            self.barLine.image = image
        }
        if let color = color {
            self.barLine.image = self.barLine.image?.tint(color, blendMode: .destinationIn)
        }
    }
    
    public func setChildView(view : UIView){
        self.childView.addSubview(view)
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
        self.childView.frame.size = CGSize.init(width: self.frame.width, height: self.frame.height - self.frame.origin.y - self.toolBar.frame.height )
        self.childView.subviews[0].frame.size = self.childView.frame.size
        
        switch self.barLineStation {
        case .inToolBar:
            self.barLineStation = .inToolBar
        case .outToolBar:
            self.barLineStation = .outToolBar
        case .inVisable:
            break
        }
        
        recognizer.setTranslation(CGPoint.zero, in: self.superview)
        
        guard isMagnetic() else{
            return
        }
        
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
            
        }
        
        
    }
    func isMagnetic() -> Bool {
        return true
    }
}
