//
//  Barcode128View.swift
//  Barcode128View
//
//  Created by zimmer on 28/04/2016.
//  Copyright © 2016 zimmer. All rights reserved.
//

import UIKit

@IBDesignable
public class Barcode128View: UIView {
  
  private let CODE128_STOP_SYMBOL: Int = 211
  
  var	unitWidth: CGFloat!
  
  @IBInspectable public var code128String: String = "" {
    didSet {
      unitWidth = -1
      code128Array = compressCode128(code128String)
      setNeedsDisplay()
    }
  }
  
  var code128Array: [Int] = [Int]()
  
  @IBInspectable public var barColor: UIColor = .blackColor() {
    didSet { setNeedsDisplay() }
  }
  
  @IBInspectable public var textColor: UIColor = .blackColor() {
    didSet { setNeedsDisplay() }
  }

  @IBInspectable public var padding: CGFloat = 0 {
    didSet { setNeedsDisplay() }
  }
  
  @IBInspectable public var showCode: Bool = false {
    didSet { setNeedsDisplay() }
  }
  
  @IBInspectable public var fontName: String = "System" {
    didSet { setNeedsDisplay() }
  }
  
  @IBInspectable public var fontSize: CGFloat = 16 {
    didSet { setNeedsDisplay() }
  }
  
  public var font = UIFont.systemFontOfSize(16)
  
  override public init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  public init(frame: CGRect, code128String: String, barColor: UIColor = .blackColor(), textColor: UIColor = .blackColor(), padding: CGFloat = 0, showCode: Bool = false, font: UIFont = UIFont.systemFontOfSize(16), fontSize: CGFloat = 16, fontName: String = "System") {
    super.init(frame: frame)
    backgroundColor = .whiteColor()
    self.code128String = code128String
    unitWidth = -1
    code128Array = compressCode128(self.code128String)
    self.barColor = barColor
    self.textColor = textColor
    self.padding = padding
    self.showCode = showCode
    self.font = font
    self.fontSize = fontSize
    self.fontName = fontName
  }
  
  override public func drawRect(rect: CGRect) {
    super.drawRect(rect)
    
    if code128String.characters.count <= 0 {
      return
    }
  
    barColor.setFill()
    
    if let f = UIFont(name: fontName, size: fontSize) {
      font = f
    }
    else {
      font = UIFont.systemFontOfSize(fontSize)
    }
    
    let labelHeight = ceil(code128String.boundingRectWithSize(CGSize(width: bounds.size.width, height: CGFloat.max), options: [.TruncatesLastVisibleLine, .UsesLineFragmentOrigin], attributes: [NSFontAttributeName: font], context: nil).height)
    let barHeight = bounds.size.height - (showCode ? labelHeight + padding : 0)
    
    var listArray = [String]()
    
    for anUnicar in code128Array {
      listArray.append(CodeSymbol[anUnicar]!)
    }
    
    let fullCodeString = listArray.joinWithSeparator("")
    unitWidth = frame.size.width / (CGFloat((code128Array.count * 11) + 2))
    
    var compLarg: CGFloat = 0
    var x: CGFloat = 0
    var aLarg: Int!
    
    for i in 0..<fullCodeString.characters.count {
      aLarg = Int(fullCodeString[i])
  
      compLarg = CGFloat(aLarg) * unitWidth
      
      if (i%2) == 0 {
        UIRectFill(CGRect(x: x, y: 0, width: compLarg, height: barHeight))
      }
      
      x += compLarg
    }
    
    if showCode {
      let paragraphStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
      paragraphStyle.alignment = NSTextAlignment.Center
      let attributes = [
        NSFontAttributeName: font,
        NSForegroundColorAttributeName: textColor,
        NSParagraphStyleAttributeName: paragraphStyle
      ]
      (code128String as NSString).drawInRect(CGRect(x: 0, y: barHeight + padding , width: x, height: labelHeight), withAttributes: attributes)
    }
    
  }
  
  func compressCode128(chaine: String) -> [Int]
  {
    var	i = 1
    var codeArray = [Int]()
    let count = chaine.characters.count
    var	table = true

    if count > 0 {
      for char in chaine.characters {
        let	acar = char.utf16Value()
        if (acar < 32 || acar > 126) && acar != 203 {
          return codeArray
        }
      }

      while i <= count {
        
        if table == true {
          var mini = (i == 1 || i + 3 == count) ? 3: 5
          
          if i + mini <= count  {
            while mini >= 0 {
              let	achar = chaine[i + mini - 1].utf16Value()
              if achar < 48 || achar > 57 {
                break
              }
              mini = mini - 1
            }
          }
          
          if mini < 0  {
            if i == 1  {
              codeArray.append(210)
            } else   {
              codeArray.append(204)
            }
            table = false
          } else if i == 1 {
            codeArray = [209]
          }
        }
        
        if !table {
          var mini = 1
          
          if i + mini <= count {
            while mini >= 0 {
              let	achar = chaine[i + mini - 1].utf16Value()
              if achar < 48 || achar > 57 {
                break
              }
              mini = mini - 1
            }
          }
          
          if mini < 0 {
            let subStr =  chaine[i-1] + chaine[i]
            var dummy: Int! = Int(subStr)
            dummy = dummy + (dummy < 95 ? 32 : 105)
            
            codeArray.append(dummy)
            
            i = i + 2
          }
          else {
            codeArray.append(205)
            table = true
          }
        }
        
        if table {
          codeArray.append(Int(chaine[i-1].utf16Value()))
          i = i + 1
        }
      }
      
      var checksum = 0
      var charVal: Int!
      
      for i in 0..<codeArray.count {
        charVal = codeArray[i]
        charVal = charVal - (charVal < 127 ? 32 : 105)
        checksum = i == 0 ? charVal % 103 : (checksum + (i * charVal)) % 103
      }
    
      checksum += checksum < 95 ? 32 : 105
      codeArray.append(checksum)
      
      codeArray.append(CODE128_STOP_SYMBOL)
    }
    return codeArray
  }
  
  private let CodeSymbol: [Int: String] = [
    32: "212222",
    33: "222122",
    34: "222221",
    35: "121223",
    36: "121322",
    37: "131222",
    38: "122213",
    39: "122312",
    40: "132212",
    41: "221213",
    42: "221312",
    43: "231212",
    44: "112232",
    45: "122132",
    46: "122231",
    47: "113222",
    48: "123122",
    49: "123221",
    50: "223211",
    51: "221132",
    52: "221231",
    53: "213212",
    54: "223112",
    55: "312131",
    56: "311222",
    57: "321122",
    58: "321221",
    59: "312212",
    60: "322112",
    61: "322211",
    62: "212123",
    63: "212321",
    64: "232121",
    65: "111323",
    66: "131123",
    67: "131321",
    68: "112313",
    69: "132113",
    70: "132311",
    71: "211313",
    72: "231113",
    73: "231311",
    74: "112133",
    75: "112331",
    76: "132131",
    77: "113123",
    78: "113321",
    79: "133121",
    80: "313121",
    81: "211331",
    82: "231131",
    83: "213113",
    84: "213311",
    85: "213131",
    86: "311123",
    87: "311321",
    88: "331121",
    89: "312113",
    90: "312311",
    91: "332111",
    92: "314111",
    93: "221411",
    94: "431111",
    95: "111224",
    96: "111422",
    97: "121124",
    98: "121421",
    99: "141122",
    100: "141221",
    101: "112214",
    102: "112412",
    103: "122114",
    104: "122411",
    105: "142112",
    106: "142211",
    107: "241211",
    108: "221114",
    109: "413111",
    110: "241112",
    111: "134111",
    112: "111242",
    113: "121142",
    114: "121241",
    115: "114212",
    116: "124112",
    117: "124211",
    118: "411212",
    119: "421112",
    120: "421211",
    121: "212141",
    122: "214121",
    123: "412121",
    124: "111143",
    125: "111341",
    126: "131141",
    200: "114113",
    201: "114311",
    202: "411113",
    203: "411311",
    204: "113141",
    205: "114131",
    206: "311141",
    207: "411131",
    208: "211412",
    209: "211214",
    210: "211232",
    211: "2331112"
  ]

}

extension String {
  
  subscript (i: Int) -> Character {
    return self[self.startIndex.advancedBy(i)]
  }
  
  subscript (i: Int) -> String {
    return String(self[i] as Character)
  }
  
  subscript (r: Range<Int>) -> String {
    return substringWithRange(startIndex.advancedBy(r.startIndex) ..< startIndex.advancedBy(r.endIndex))
  }
  
}

extension Character {
  func utf8Value() -> UInt8 {
    for s in String(self).utf8 {
      return s
    }
    return 0
  }
  
  func utf16Value() -> UInt16 {
    for s in String(self).utf16 {
      return s
    }
    return 0
  }
  
  func unicodeValue() -> UInt32 {
    for s in String(self).unicodeScalars {
      return s.value
    }
    return 0
  }
}
