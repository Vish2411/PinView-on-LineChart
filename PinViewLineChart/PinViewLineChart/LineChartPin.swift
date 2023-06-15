//
//  LineChartPin.swift
//  PinViewLineChart
//
//  Created by iMac on 14/06/23.
//

import Foundation
import UIKit

struct PinData {
    var date: String?
    var price: String?
}

class LineCharPinView: UIView {
    
    private var path: UIBezierPath!
    private let shapeLayer = CAShapeLayer()
    private let topshapeLayer = CAShapeLayer()

    
    var data: PinData = PinData()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        
        // Create CAShapeLayer
        setupMainBodyLayer() //  shap layer
        setupTopLayer() //  triangle top shap layer
        
    }
    
    private func setupMainBodyLayer() {
        
        shapeLayer.strokeColor = UIColor.gray.cgColor
        shapeLayer.fillColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 2.5
        shapeLayer.position = CGPoint(x: 0, y: 0)
        self.layer.addSublayer(shapeLayer)
        shapeLayer.path = createMainBezierPath().cgPath
        setupUI()
    }
    
    private func setupTopLayer() {
        
        topshapeLayer.strokeColor = UIColor.gray.cgColor
        topshapeLayer.fillColor = UIColor.black.cgColor
        topshapeLayer.lineWidth = 0.0
        topshapeLayer.position = CGPoint(x: 0, y: 0)
        self.layer.addSublayer(topshapeLayer)
        topshapeLayer.path = createTopBezierPath().cgPath
    }
    
    //MARK: - UI Setup
    private func setupUI() {
        
        var lblDate: UILabel = UILabel()
        var img: UIImageView = UIImageView()
        var lblPrice: UILabel = UILabel()
        
        let totalWidth = reSizeWidth(65)
        let totalHeight = reSizeHeight(51)
        
        // Make Date Label
        lblDate = UILabel(frame: CGRect(x: reSizeWidth(10),
                                      y: dynamicCalY(15),
                                      width: reSizeWidth(65) - reSizeWidth(20),
                                      height: reSizeHeight(15)))
//        lblDate.center = CGPoint(x: totalWidth / 2, y: dynamicCalY(25))
        lblDate.font = lblDate.font.withSize(12)
        lblDate.textAlignment = .center
        lblDate.textColor = .white
        lblDate.text = "7/02/23"
        
        // Make ImageVIew
        img = UIImageView(frame: CGRect(x: reSizeWidth(10), y: totalHeight - dynamicCalY(20), width: reSizeHeight(12), height: reSizeHeight(12)))
//        img.center = CGPoint(x: lblDate.frame.origin.x + reSizeWidth(12), y: totalHeight - dynamicCalY(10))
        img.image = UIImage(systemName: "tray.fill")

        // Make Price Label
        lblPrice = UILabel(frame: CGRect(x: 0,
                                      y: 0,
                                      width: reSizeWidth(40),
                                      height: reSizeHeight(15)))
//        lblPrice.center = CGPoint(x: (img.frame.maxX + reSizeWidth(12)) + reSizeWidth(5), y: totalHeight - dynamicCalY(10) )
        lblPrice.center = CGPoint(x: (img.frame.maxX + reSizeWidth(12)) + reSizeWidth(5), y: img.frame.midY )
        lblPrice.font = lblPrice.font.withSize(10)
        lblPrice.textAlignment = .center
        lblPrice.textColor = .gray
        lblPrice.text = "$2023"
        
        
        
        shapeLayer.addSublayer(lblDate.layer)
        shapeLayer.addSublayer(img.layer)
        shapeLayer.addSublayer(lblPrice.layer)
        shapeLayer.contents = [lblDate,img,lblPrice]
    }
    
    private func createMainBezierPath()  -> UIBezierPath {

        _ = self.frame.size.height / 2
        let centerX = self.frame.size.width / 2
        let height = self.frame.size.height
        let width = self.frame.size.width

        
        path = UIBezierPath()
        

        
        path.move(to: CGPoint(x: centerX, y: dynamicCalY(10)))
        
        path.addLine(to: CGPoint(x: width - dynamicCalX(10), y: dynamicCalY(10)))
        
        
        path.addCurve(to: CGPoint(x: width, y: dynamicCalY(20) ),
                      controlPoint1: CGPoint(x: width - dynamicCalX(10), y: dynamicCalY(10)),
                      controlPoint2: CGPoint(x: width , y: dynamicCalY(10)))
        
        path.addLine(to: CGPoint(x: width, y: height - dynamicCalY(10)))
                      
        path.addCurve(to: CGPoint(x: width - dynamicCalX(10), y: height ),
                      controlPoint1: CGPoint(x: width, y: height - dynamicCalY(10)),
                      controlPoint2: CGPoint(x: width , y: height))
        
        path.addLine(to: CGPoint(x: dynamicCalX(10), y: height))
        
        path.addCurve(to: CGPoint(x: 0, y: height - dynamicCalY(10)),
                      controlPoint1: CGPoint(x: dynamicCalX(10), y: height),
                      controlPoint2: CGPoint(x: 0 , y: height))
        
        path.addLine(to: CGPoint(x: 0, y: dynamicCalY(20)))
        
        path.addCurve(to: CGPoint(x: dynamicCalX(10), y: dynamicCalY(10)),
                      controlPoint1: CGPoint(x: 0, y: dynamicCalY(20)),
                      controlPoint2: CGPoint(x: 0 , y: dynamicCalY(10)))
        
        path.close()
        return path
    }
    
    private func createTopBezierPath()  -> UIBezierPath {

        _ = self.frame.size.height / 2
        let centerX = self.frame.size.width / 2
        let height = self.frame.size.height
        let width = self.frame.size.width

        
        path = UIBezierPath()
        
        path.move(to: CGPoint(x: centerX - dynamicCalX(10), y: dynamicCalY(15)))

        path.addLine(to: CGPoint(x: centerX, y: 0))
        
        path.addLine(to: CGPoint(x: centerX + dynamicCalX(10), y: dynamicCalY(15)))
        
        path.close()
        return path
    }
    
    private func dynamicCalY(_ val: CGFloat) -> CGFloat {
        let height = self.frame.size.height
        return (height * val) / 51
    }
    
    private func dynamicCalX(_ val: CGFloat) -> CGFloat {
        let width = self.frame.size.width
        return (width * val) / 65
    }
    
    override func draw(_ rect: CGRect) {
        
    }
    
    // reSizeWidth
    func reSizeWidth(_ widthValue: CGFloat) -> CGFloat {
        let width = self.frame.size.width
        return (width * widthValue) / 65
    }
    
    // reSizeHeight
    func reSizeHeight(_ heightValue: CGFloat) -> CGFloat {
        let height = self.frame.size.height
        return (height * heightValue) / 51
    }
}


extension CGFloat {
    func toRadians2() -> CGFloat {
        return self * CGFloat(M_PI) / 180.0
    }
    
    func toRadias() -> CGFloat {
        return self * CGFloat(M_PI) / 360.0
    }
}


/*
 //        path.move(to: CGPoint(x: centerX, y: 10))
 //
 //        path.addLine(to: CGPoint(x: width - 10, y: 10))
 //
 //
 //        path.addCurve(to: CGPoint(x: width, y: 20 ),
 //                      controlPoint1: CGPoint(x: width - 10, y: 10),
 //                      controlPoint2: CGPoint(x: width , y: 10))
 //
 //        path.addLine(to: CGPoint(x: width, y: height - 10))
 //
 //        path.addCurve(to: CGPoint(x: width - 10, y: height ),
 //                      controlPoint1: CGPoint(x: width, y: height - 10),
 //                      controlPoint2: CGPoint(x: width , y: height))
 //
 //        path.addLine(to: CGPoint(x: 10, y: height))
 //
 //        path.addCurve(to: CGPoint(x: 0, y: height - 10),
 //                      controlPoint1: CGPoint(x: 10, y: height),
 //                      controlPoint2: CGPoint(x: 0 , y: height))
 //
 //        path.addLine(to: CGPoint(x: 0, y: 20))
 //
 //        path.addCurve(to: CGPoint(x: 10, y: 10),
 //                      controlPoint1: CGPoint(x: 0, y: 20),
 //                      controlPoint2: CGPoint(x: 0 , y: 10))
 */
