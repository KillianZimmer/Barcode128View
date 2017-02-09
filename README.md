# Barcode128View

[![CI Status](http://img.shields.io/travis/zimmer/Barcode128View.svg?style=flat)](https://travis-ci.org/zimmer/Barcode128View)
[![Version](https://img.shields.io/cocoapods/v/Barcode128View.svg?style=flat)](http://cocoapods.org/pods/Barcode128View)
[![License](https://img.shields.io/cocoapods/l/Barcode128View.svg?style=flat)](http://cocoapods.org/pods/Barcode128View)
[![Platform](https://img.shields.io/cocoapods/p/Barcode128View.svg?style=flat)](http://cocoapods.org/pods/Barcode128View)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

Barcode128View is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Barcode128View"
```

## Usage

<h3>Storyboard setup</h3>
First add an UIView to your UIViewController and set its class as Barcode128View as it shown in the picture below.
<br>
![alt tag](https://cloud.githubusercontent.com/assets/12252587/16590622/9d7a3212-42d8-11e6-9bec-ec847fb40abf.png)

Then, you just have to set all the properties in the attributs inspector and the View will update its content automatically
<br>
![alt tag](https://cloud.githubusercontent.com/assets/12252587/16590207/e5b3b5c8-42d6-11e6-97a5-d5f34d91621c.png)

<h3>Code setup</h3>
If you want to set your Barcode128View properties manually, you can link the view in your code
```swift
@IBOutlet weak var codeView: Barcode128View!
```
then, set the properties
<br>
```swift
codeView.code128String = "0123456789"
/* optionnal */
codeView.font = UIFont.systemFontOfSize(20)
codeView.barColor = UIColor.blackColor()
codeView.textColor = UIColor.darkGrayColor()
codeView.showCode = true
codeView.padding = 0
```

<h3>Manual setup</h3>
You can create a Barcode128View manually with the init(frame:) method and set all the properties
```swift
let codeView = Barcode128View(frame: frame)
```
or with the custom init method bay adding the wanted properties in the init(frame:) method parameters
```swift
let secondCodeView = Barcode128View(frame: CGRect(x: 0, y: 0, width: 250, height: 150),
                        code128String: "012345678999",
                        /* optionnal */
                        barColor: .black,
                        textColor: .darkGray,
                        padding: 0,
                        showCode: true,
                        //or font: UIFont.systemFontOfSize(30),
                        fontName: "Helvetica",
                        fontSize: 30
)
view.addSubview(secondCodeView)
```

<h3>Attributes</h3>
```swift
open var code128String: String! // default ""
open var barColor: UIColor! // default .black
open var textColor: UIColor! // default .black
open var padding: CGFloat! // default 0
open var showCode: Bool! // default false
open var fontName: String! // default "System"
open var fontSize: CGFloat! // default 16
open var font: UIFont! // default UIFont.systemFont(ofSize: 16)
```

## Author

zimmer

## License

Barcode128View is available under the MIT license. See the LICENSE file for more info.
