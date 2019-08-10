//
//  ViewController.swift
//  LEBottomSheetView
//
//  Created by a841223o on 06/10/2019.
//  Copyright (c) 2019 a841223o. All rights reserved.
//

import UIKit
import LEBottomSheetView
class ViewController: UIViewController {
    var bottomView : BottomSheetView!
    var bottomBackgrondView : BottomSheetBackgroundView!
    var tableViewController : TableViewController?
    @IBAction func ToolBarState(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            bottomView.barLineStation = .inToolBar
        case 1:
            bottomView.barLineStation = .outToolBar
        case 2:
            bottomView.barLineStation = .inVisable
        default:
            break
        }
    }
    
    @IBAction func sheetViewState(_ sender: UISegmentedControl) {
        UIView.animate(withDuration: 0.5, animations: {
        switch sender.selectedSegmentIndex {
        case 0:
            self.bottomView.station = .top
        case 1:
            self.bottomView.station = .center
        case 2:
            self.bottomView.station = .bottom
        case 3:
            self.bottomView.station = .inVisable
        default:
            break
        }
        } )

    }
    
    @IBAction func changeBackgroundMode(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            
            bottomView.present(station: .center)
            bottomBackgrondView.present(station: .inVisable)
        default:
            bottomView.present(station: .inVisable)
            bottomBackgrondView.present(station: .center)
        }
    }
    @IBAction func ToolBarImage(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            bottomView.setBarLineImage(color: UIColor.gray.withAlphaComponent(0.8), size:CGSize.init(width: 60, height: 60) , image:UIImage.bundledImage(named: "barLine") )
        case 1:
            bottomView.setBarLineImage(image:UIImage.init(imageLiteralResourceName: "line") )
        case 2:
            bottomView.setBarLineImage(color: UIColor.red.withAlphaComponent(0.8))
        case 3:
            bottomView.setBarLineImage(size:CGSize.init(width: 30, height: 30) )
        default:
            break
        }
    }
    
    @IBAction func radiusSlide(_ sender: UISlider) {
        bottomView.topCornerRadius = CGFloat(sender.value)
    }
    @IBAction func shadowSlide(_ sender: UISlider) {
        bottomView.setShadowView(opacity: sender.value, cgColor: UIColor.shadowColor)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomBackgrondView = BottomSheetBackgroundView.init(frame: CGRect.init(x:0, y:0 , width: self.view.frame.width, height: self.view.frame.height), superview: self.view)
        bottomBackgrondView.setBottomSheetViewBackgroundColor(color: UIColor.white)
        bottomBackgrondView.present(station: .inVisable)
        
        
        bottomView = BottomSheetView.init(frame: CGRect.init(x:0, y:0 , width: self.view.frame.width, height: self.view.frame.height), superview: self.view)
        bottomView.setBottomSheetViewBackgroundColor(color: UIColor.white)
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableViewController = self.storyboard?.instantiateViewController(withIdentifier: "TableViewController") as? TableViewController
        bottomView.setChildView(view: tableViewController?.view ?? UIView())

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

