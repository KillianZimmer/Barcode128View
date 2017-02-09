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
    codeView.font = UIFont.systemFont(ofSize: 20)
    codeView.barColor = UIColor.black
    codeView.textColor = UIColor.darkGray
    codeView.showCode = true
    codeView.padding = 0
    /*************/
    
    let secondCodeView = Barcode128View(frame: CGRect(x: codeView.frame.minX, y: codeView.frame.maxY + 30, width: 250, height: 150),
                           code128String: "9876543210",
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
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}

