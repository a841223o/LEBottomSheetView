//
//  BottomSheetView+BackgroundView.swift
//  LEBottomSheetView
//
//  Created by DongLunYou on 2019/6/13.
//

import Foundation


public class BottomSheetBackgroundView : BottomSheetView {
    var backgroundView : UIView!
    var backgroundViewColor: UIColor = UIColor.darkGray.withAlphaComponent(0.9)
    
    override public init(frame: CGRect, superview: UIView) {
        super.init(frame: frame, superview: superview)
        backgroundView = UIView(frame: self.superview!.frame)
        self.superview?.addSubview(backgroundView)
        let backgroundGesture =  UITapGestureRecognizer.init(target: self, action: #selector(backgroundTapHandle))
        backgroundView.addGestureRecognizer(backgroundGesture)
        
    }
       
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func presentAction(station: SheetStation) {
        super.presentAction(station: station)
        switch station{
        case .top:
        backgroundView.isHidden = false
        backgroundView.backgroundColor = backgroundViewColor
        self.superview?.bringSubviewToFront(self)
        case .center:
        backgroundView.isHidden = false
        backgroundView.backgroundColor = backgroundViewColor
        self.superview?.bringSubviewToFront(self)
        default:
        backgroundView.isHidden = true
        }
    }
    @objc func backgroundTapHandle(){
        present(station: .bottom , duration: animationDuration)
    }
    public func setBackgroundViewColor(color : UIColor){
        backgroundViewColor = color
    }
}
