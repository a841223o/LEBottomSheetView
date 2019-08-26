# LEBottomSheetView

[![CIStatus](https://img.shields.io/travis/a841223o/LEBottomSheetView.svg?style=flat)](https://travis-ci.org/a841223o/LEBottomSheetView)
[![Version](https://img.shields.io/cocoapods/v/LEBottomSheetView.svg?style=flat)](https://cocoapods.org/pods/LEBottomSheetView)
[![License](https://img.shields.io/cocoapods/l/LEBottomSheetView.svg?style=flat)](https://cocoapods.org/pods/LEBottomSheetView)
[![Platform](https://img.shields.io/cocoapods/p/LEBottomSheetView.svg?style=flat)](https://cocoapods.org/pods/LEBottomSheetView)

## Example

Fast to show a sheetView
```
let bottomView = BottomSheetView.init(frame: self.view.frame, superview: self.view)
```
Set SheetView childView
```
//prepare a view controller
tableViewController = self.storyboard?.instantiateViewController(withIdentifier: "TableViewController") as? TableViewController
//can set any view into sheetView
bottomView.setChildView(view: tableViewController?.view ?? UIView())
```

## Requirements
swift 4.2
Xcode 10.0
## Installation

### Using [CocoaPods](https://cocoapods.org).
Add the following line to your Podfile:

```ruby
pod 'LEBottomSheetView'
```

## Author

a841223o, leo@fox-tech.co

## License

LEBottomSheetView is available under the MIT license. See the LICENSE file for more info.
