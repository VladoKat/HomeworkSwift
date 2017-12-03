//
//  ShapeUIView.swift
//  Homework_Swift_3rdTask
//
//  Created by MacbookPro on 4.12.17.
//  Copyright © 2017 SwiftFMI. All rights reserved.
//

import UIKit

class ShapeUIView: UIView {
    //TODO: add default properties
    let lineWidth:CGFloat = 5
    //used when initialised through code
    public override init(frame: CGRect) {
        super.init(frame: frame)
        print("\(#function)")
        self.setup()
    }
    //used when initialised through storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        print("\(#function)")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let lineWidth:CGFloat = 20
        let point:CGPoint = CGPoint(x: rect.width/2, y: rect.height/2)
        var sizes: [CGFloat] = []
        //change num for different number of sections, num < 9 only 9 colors defined
        let num = 4
        var all:Int = 100
        for _ in 0..<num-1 {
            var diceRoll = Int(arc4random_uniform(UInt32(all)))
            while((diceRoll < 5 || diceRoll > 60) && all > 5){
                diceRoll = Int(arc4random_uniform(UInt32(all)))
            }
            sizes.append(CGFloat(diceRoll))
            all = all - diceRoll
        }
        sizes.append(CGFloat(all));
        
        var colors: [UIColor] = [.red, .green, .blue, .purple, .cyan, .gray, .brown, .orange, .yellow]
        var first:CGFloat = 0
        var angle:CGFloat = 0
        var myShape = UIBezierPath(arcCenter: point, radius: rect.width/4, startAngle:2*CGFloat.pi-first, endAngle: 2*CGFloat.pi - angle, clockwise: false)
        let radius:CGFloat = rect.width/4
        for i in 0 ..< num{
            angle = angle + (sizes[i]*2)*CGFloat.pi/100
            myShape = UIBezierPath(arcCenter: point, radius: radius, startAngle:2*CGFloat.pi - first, endAngle: 2*CGFloat.pi - angle, clockwise: false)
            myShape.lineWidth = 2*lineWidth
            colors[i].setStroke()
            myShape.lineCapStyle = CGLineCap.round
            myShape.stroke()
            textToView(drawText: String(describing: Int(sizes[i])), atPoint: CGPoint(x: point.x + radius*cos(first) - 13 , y: point.y - radius*sin(first) - 10))
            print(sin(first))
            first = first + (sizes[i] * 2) * CGFloat.pi/100
        }
        myShape = UIBezierPath(arcCenter: point, radius: rect.width/4, startAngle:0, endAngle: 0.001, clockwise: true)
        myShape.lineWidth = 2*lineWidth
        colors[0].setStroke()
        
        myShape.lineCapStyle = CGLineCap.round
        myShape.stroke()
        
        print(first)
        
        
    }
    
    func textToView(drawText text: String, atPoint point: CGPoint) {
        let lblNew = UILabel()
        lblNew.frame = CGRect(x: point.x, y: point.y, width: 30.0, height: 20)
        lblNew.textAlignment = .left
        lblNew.text = text as String
        lblNew.textColor = UIColor.white
        self.addSubview(lblNew)
    }
}


