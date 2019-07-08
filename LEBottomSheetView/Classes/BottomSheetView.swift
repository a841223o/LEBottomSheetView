
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
public enum HorizontalStation{
    case left
    case center
    case right
}

public class BottomSheetView : UIView {
    
    internal var toolBar : UIView!
    var toolBarHeight : CGFloat = 45
    var shadowView : UIView!
    var childView : UIView!
    var barLine : UIImageView!
    var image : UIImage!
    
    var topY : CGFloat = 0
    var bottomY : CGFloat = 0
    var centerY : CGFloat = 0
    var inVisableY : CGFloat  {
        get{
           return  self.superview!.frame.height
        }
    }
    public var topCornerRadius : CGFloat = 5 {
        didSet{
            self.roundCorner(radious: topCornerRadius, rectCorners: [.topLeft,.topRight])
            self.shadowView.layer.cornerRadius = topCornerRadius
        }
    }
    var sheetX : CGFloat = 0
    var barLineW : CGFloat = 60
    var barLineH : CGFloat = 60
    var animationDuration : TimeInterval = 0.3
    var tapBarToStation : SheetStation = .center
    
    public var horizontalStation : HorizontalStation = .left {
        didSet{
            switch horizontalStation {
            case .left :
                sheetX = 0
            case .center :
                sheetX = (self.superview!.width - self.width)/2
            case .right:
                sheetX = (self.superview!.width - self.width)
            }
            updateUI()
        }
    }
    public var station : SheetStation  = .center {
        didSet{
            
            switch station {
            case .top:
                self.frame.origin = CGPoint.init(x: sheetX, y: topY )
                
            case .center:
                self.frame.origin = CGPoint.init(x: sheetX, y: centerY )
                
            case .bottom:
                self.frame.origin = CGPoint.init(x: sheetX, y: bottomY )
                
            case .inVisable:
                self.frame.origin = CGPoint.init(x: sheetX, y: inVisableY)
            }
            
            setChildViewAndSubView()
            
            switch self.barLineStation {
            case .inToolBar:
                self.barLineStation = .inToolBar
            case .outToolBar:
                self.barLineStation = .outToolBar
            case .inVisable:
                break
            }
            
            shadowView.frame = CGRect.init(x: self.frame.origin.x, y: self.frame.origin.y + 2, width: self.width, height: self.frame.height)
        }
    }
    

    public var barLineStation : BarLineStation = .inToolBar {
        didSet{
            switch barLineStation {
            case .inToolBar:
                barLine.removeFromSuperview()
                barLine.center = CGPoint.init(x: sheetX+self.width*0.5, y: self.toolBar.y + 15)
                self.addSubview(barLine)
            case .outToolBar:
                barLine.removeFromSuperview()
                barLine.center = CGPoint.init(x: sheetX+self.width*0.5, y: self.y - 15)
                self.superview?.addSubview(barLine)
            case .inVisable:
                barLine.removeFromSuperview()
            }
        }
    }

    public init(frame: CGRect , superview : UIView) {
        super.init(frame : frame)
        
        setupShadowView(superview: superview)
        superview.addSubview(self)
        setupToolBar()
        setupChildView()
        setupBarLine()
        
        self.setTopCenterBottom(topY: UIApplication.shared.statusBarFrame.height ,
                                centerY:  self.frame.height/2,
                                bottomY: superview.frame.height-toolBarHeight)
        self.station = .bottom
        self.roundCorner(radious: topCornerRadius, rectCorners: [.topLeft,.topRight])
        updateUI()
    }
    func setupShadowView(superview : UIView){
        shadowView  = UIView(frame : frame)
        shadowView.layer.cornerRadius = CGFloat(topCornerRadius)
        shadowView.backgroundColor = UIColor.red
        shadowView.setShadow(size: CGSize.init(width: 0, height: 0),opacity: 1 , radius: CGFloat(self.topCornerRadius), cgColor: UIColor.shadowColor)
        superview.addSubview(shadowView)
    }
    public func setShadowView(offset:CGSize = CGSize(width: 0, height: 0) , opacity: Float, cgColor: CGColor) {
        if topCornerRadius != 0{
            shadowView.setShadow(size: offset ,opacity: opacity , radius: CGFloat(self.topCornerRadius), cgColor: cgColor)
        }else{
            shadowView.setShadow(size: offset ,opacity: opacity , radius: CGFloat(5), cgColor: cgColor)
        }
        
    }
    func setupToolBar(){
        toolBar = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.width, height: toolBarHeight))
        toolBar.backgroundColor = UIColor.white
        let panGesture =  UIPanGestureRecognizer.init(target: self, action: #selector(handel(recognizer:)))
        toolBar.addGestureRecognizer(panGesture)
        let barTapGesture =  UITapGestureRecognizer.init(target: self, action: #selector(barTapHandle))
        toolBar.addGestureRecognizer(barTapGesture)
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
        barLine.frame = CGRect.init(x: 0, y: 0, width: barLineH , height: barLineH)
        
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
    }
    
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
            self.barLineH = barLine.frame.height
            self.barLineW = barLine.frame.width
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
    public func slidAction(translation : CGPoint){
        if self.frame.origin.y + translation.y <= topY {
            self.frame.origin = CGPoint.init(x: sheetX, y: topY )
            
        }else if self.frame.origin.y + translation.y >= bottomY {
            self.frame.origin = CGPoint.init(x: sheetX, y: bottomY)
            
        }else{
            self.frame.origin = CGPoint.init(x: sheetX, y: self.frame.origin.y + translation.y)
            
            //            setChildeViewBackgroundColor(color: UIColor.themeColor.lighten().withAlphaComponent(0.7+0.4*((self.frame.height-self.frame.origin.y)/self.frame.height)))
            //            setToolBarBackgroundColor(color: UIColor.themeColor.lighten().withAlphaComponent(0.7+0.4*((self.frame.height-self.frame.origin.y)/self.frame.height)))
        }
        
        shadowView.frame = CGRect.init(x: self.frame.origin.x, y: self.frame.origin.y + 2, width: self.width, height: self.frame.height)
       
        setChildViewAndSubView()
        
        switch self.barLineStation {
        case .inToolBar:
            self.barLineStation = .inToolBar
        case .outToolBar:
            self.barLineStation = .outToolBar
        case .inVisable:
            break
        }
        
    }
    func endAction(){
        let height =  abs(self.frame.origin.y - self.topY)
        let bottom =  abs(self.frame.origin.y - self.bottomY)
        let center =  abs(self.frame.origin.y - self.centerY)
        print("\(height),\(bottom),\(center)")
        if self.frame.origin.y < self.centerY {
            switch height < center {
            case true :
                UIView.animate(withDuration: animationDuration, animations: {
                    self.station = .top
                   
                } )
            case false :
                UIView.animate(withDuration: animationDuration, animations: {
                    self.station = .center
                   
                } )
                
            }
        }else{
            switch bottom < center {
            case true :
                UIView.animate(withDuration:animationDuration, animations: {
                    self.station = .bottom
                    
                } )
                
            case false :
                UIView.animate(withDuration: animationDuration, animations: {
                    self.station = .center
                    
                } )
            }
        }
    }
    @objc internal func handel(recognizer:UIPanGestureRecognizer){
        
        let translation = recognizer.translation(in: self)
        
        slidAction(translation: translation)
        
        recognizer.setTranslation(CGPoint.zero, in: self.superview)
        
        guard isMagnetic() else{
            return
        }
        
        if recognizer.state == UIGestureRecognizer.State.ended {
            
            endAction()
    
        }
        
        
    }
    @objc internal func barTapHandle(){
        switch station {
        case .bottom:
            present(station: tapBarToStation ,duration: animationDuration)
        default:
            present(station: .bottom ,duration: animationDuration)
        }
    }
    func isMagnetic() -> Bool {
        return true
    }
    
    // fix bottomY < toolBar.height
    func setChildViewAndSubView(){
            if self.y + self.toolBar.frame.height < self.superview!.frame.height{
                self.childView.frame.size = CGSize.init(width: self.frame.width, height: self.frame.height - self.frame.origin.y - self.toolBar.frame.height )
                if  self.childView.subviews.count > 0 {
                    self.childView.subviews[0].frame.size = self.childView.frame.size
                }
        }
    }
    public func present(station : SheetStation , duration:TimeInterval){
        UIView.animate(withDuration: duration) {
            self.presentAction(station: station)
        }
    }
    public func present(station : SheetStation ){
        UIView.animate(withDuration: animationDuration) {
            self.presentAction(station: station)
        }
    }
    internal func presentAction(station : SheetStation){
        self.station = station
    }
    
    public func dismiss(){
        self.removeFromSuperview()
        self.shadowView.removeFromSuperview()
    }
}
