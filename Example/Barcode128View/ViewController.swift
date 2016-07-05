//
//  ViewController.swift
//  Barcode128View
//
//  Created by zimmer on 07/05/2016.
//  Copyright (c) 2016 zimmer. All rights reserved.
//

import UIKit
import Barcode128View

class ViewController: UIViewController {

  @IBOutlet weak var codeView: Barcode128View!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    codeView.code128String = "0123456789"
    /* optionnal */
    codeView.font = UIFont.systemFontOfSize(20)
    codeView.barColor = UIColor.blackColor()
    codeView.textColor = UIColor.darkGrayColor()
    codeView.showCode = true
    codeView.padding = 0
    /*************/
    
    let secondCodeView = Barcode128View(frame: CGRect(x: 50, y: codeView.frame.maxY, width: 250, height: 150),
                           code128String: "012345678999",
                           /* optionnal */
                           barColor: .blackColor(),
                           textColor: .darkGrayColor(),
                           showCode: true,
                           fontName: "Helvetica",
                           fontSize: 30,
                           //or font: UIFont.systemFontOfSize(30),
                           padding: 0)
    view.addSubview(secondCodeView)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}

