//
//  StationDelegate.swift
//  LEBottomSheetView
//
//  Created by DOWN LUNYOU on 2019/8/4.
//

import Foundation

public protocol LEBottomSheetViewDelegate {
    func LEBottomSheetView(bottomSheetView : BottomSheetView , stationAt : SheetStation)
    func LEBottomSheetView(bottomSheetView : BottomSheetView , stationAtIsMagnetic : SheetStation)->Bool
    func LEBottomSheetView(bottomSheetView : BottomSheetView , stationAtBarTapAction : SheetStation)
}

extension  LEBottomSheetViewDelegate {
    func LEBottomSheetView(bottomSheetView : BottomSheetView , stationAt : SheetStation){
        print("Implemented")
    }
    func LEBottomSheetView(bottomSheetView : BottomSheetView , stationAtIsMagnetic : SheetStation)->Bool{
        return true
    }
    func LEBottomSheetView(bottomSheetView : BottomSheetView , stationAtBarTapAction : SheetStation){
        switch stationAtBarTapAction {
        case .bottom :
            bottomSheetView.present(station: .center, duration: bottomSheetView.animationDuration)
        default:
            bottomSheetView.present(station: .bottom ,duration: bottomSheetView.animationDuration)
        }
    }
}
