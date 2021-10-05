//
//  ViewController.swift
//  CustomDrawing
//
//  Created by Aoife McManus on 10/4/21.
//

import UIKit

class ViewController: UIViewController {
    
    struct Spirograph{
        var innerR: Int
        var outerR: Int
        var distance: Int
        var amount: CGFloat
    }
    
    func getGCD(innerR: Int, outerR: Int) -> Int{
        if(innerR==0){
            return outerR
        }
        if(outerR==0){
            return innerR
        }
        if(innerR==outerR){
            return innerR
        }
        if(innerR>outerR){
            return getGCD(innerR:innerR-outerR, outerR:outerR)
        }
        return getGCD(innerR:innerR, outerR:outerR-innerR)
    }
    
    func getPath(spirograph: Spirograph)->UIBezierPath{
        let div=getGCD(innerR: spirograph.innerR, outerR:spirograph.outerR)
        let outerR=CGFloat(spirograph.outerR)
        let innerR=CGFloat(spirograph.innerR)
        let distance=CGFloat(spirograph.distance)
        let difference=innerR-outerR
        let end=ceil(2*CGFloat.pi*CGFloat(outerR)/CGFloat(div))*spirograph.amount
        var path:UIBezierPath!
        path=UIBezierPath()
        for i in stride(from:0, to:end, by:0.01){
            let x=difference*cos(i)+distance*cos(difference/outerR*i);
            let y=difference*sin(i)+distance*sin(difference/outerR*i);
            if(i==0){
                path.move(to: CGPoint(x:x, y:y))
            }
            else{
                path.addLine(to: CGPoint(x:x, y:y))
            }
        }
        return path
    }
    
    
    weak var shapeLayer: CAShapeLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.shapeLayer?.removeFromSuperlayer()
        let spiro=Spirograph(innerR: 75, outerR:125, distance:25, amount:1.0)
        let path=getPath(spirograph: spiro)
        

        // create shape layer for that path
        let width=CGFloat(125);
        let height=CGFloat(125);
        let x=self.view.frame.midX;
        let y=self.view.frame.midY;
        
        let shapeLayer = CAShapeLayer()
        let rect=CGRect(x: x, y: y, width: width, height: height)
        
        shapeLayer.frame = rect;
        shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        shapeLayer.strokeColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.path = path.cgPath

        // animate it

        view.layer.addSublayer(shapeLayer)
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = 5;
        shapeLayer.add(animation, forKey: "MyAnimation")

        // save shape layer

        self.shapeLayer = shapeLayer
    }
}

