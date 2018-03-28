//
//  ThirdViewController.swift
//  RandomArt
//
//  Created by 安藤輝 on 2018/03/28.
//  Copyright © 2018年 安藤輝. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    var r: CGFloat {
        return CGFloat(arc4random() % 100) * 0.01
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let w = UIScreen.main.bounds.width
        let h = UIScreen.main.bounds.height
        let w4 = w / 4
        let h4 = h / 4
        
        let view1 = UIView(frame: CGRect(x: 0, y: 0, width: w4, height: h4))
        let view2 = UIView(frame: CGRect(x: w/4, y: 0, width: w4, height: h4))
        let view3 = UIView(frame: CGRect(x: w/2, y: 0, width: w4, height: h4))
        let view4 = UIView(frame: CGRect(x: w/1.3333, y: 0, width: w4, height: h4))
        
        let view5 = UIView(frame: CGRect(x: 0, y: h/4, width: w4, height: h4))
        let view6 = UIView(frame: CGRect(x: w/4, y: h/4, width: w4, height: h4))
        let view7 = UIView(frame: CGRect(x: w/2, y: h/4, width: w4, height: h4))
        let view8 = UIView(frame: CGRect(x: w/1.3333, y: h/4, width: w4, height: h4))
        
        let view9 = UIView(frame: CGRect(x: 0, y: h/2, width: w4, height: h4))
        let view10 = UIView(frame: CGRect(x: w/4, y: h/2, width: w4, height: h4))
        let view11 = UIView(frame: CGRect(x: w/2, y: h/2, width: w4, height: h4))
        let view12 = UIView(frame: CGRect(x: w/1.3333, y: h/2, width: w4, height: h4))

        let view13 = UIView(frame: CGRect(x: 0, y: h/1.3333, width: w4, height: h4))
        let view14 = UIView(frame: CGRect(x: w/4, y: h/1.3333, width: w4, height: h4))
        let view15 = UIView(frame: CGRect(x: w/2, y: h/1.3333, width: w4, height: h4))
        let view16 = UIView(frame: CGRect(x: w/1.3333, y: h/1.3333, width: w4, height: h4))

        var views = [UIView]()
        views.append(view1)
        views.append(view2)
        views.append(view3)
        views.append(view4)
        views.append(view5)
        views.append(view6)
        views.append(view7)
        views.append(view8)
        views.append(view9)
        views.append(view10)
        views.append(view11)
        views.append(view12)
        views.append(view13)
        views.append(view14)
        views.append(view15)
        views.append(view16)

        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            views.forEach { $0.backgroundColor = self.color() }
        }
        views.forEach { view.addSubview($0) }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func color() -> UIColor {
        
        return UIColor(displayP3Red: self.r, green: self.r, blue: self.r, alpha: self.r)
    }
}
