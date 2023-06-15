//
//  ViewController.swift
//  PinViewLineChart
//
//  Created by iMac on 14/06/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lineChartPin: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        let lineChartPin = LineCharPinView(frame: CGRect(x: lineChartPin.frame.minX, y: lineChartPin.frame.minY, width: lineChartPin.frame.width, height: lineChartPin.frame.height))
        self.view.addSubview(lineChartPin)
    }
}

