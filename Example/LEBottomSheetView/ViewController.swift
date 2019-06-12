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
    var tableViewController : TableViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        bottomView = BottomSheetView.init(frame: self.view.frame, superview: self.view)
        bottomView.setBottomSheetViewBackgroundColor(color: UIColor.lightGray)
        
        bottomView.station = .center
        bottomView.barLineStation = .outToolBar
        bottomView.setBarLineImage(size: CGSize( width: 30 , height: 30),image: UIImage.init(named: "line"))
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableViewController = self.storyboard?.instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
        bottomView.setChildView(view: tableViewController?.view ?? UIView())
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

