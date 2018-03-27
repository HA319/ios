//
//  SecondViewController.swift
//  RandomArt
//
//  Created by 安藤輝 on 2018/03/28.
//  Copyright © 2018年 安藤輝. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet private weak var verticalView: UIView!
    @IBOutlet private weak var horizontalView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let vertical = verticalView.frame.height
        let horizontal = horizontalView.frame.width
        
        let view1 = UIView(frame: CGRect(x: 0, y: 0, width: horizontal / 2, height: vertical / 2))
        let view2 = UIView(frame: CGRect(x: horizontal / 2 , y: 0, width: horizontal / 2, height: vertical / 2))
        let view3 = UIView(frame: CGRect(x: 0, y: vertical / 2, width: horizontal / 2, height: vertical / 2))
        let view4 = UIView(frame: CGRect(x: horizontal / 2, y: vertical / 2, width: horizontal / 2, height: vertical / 2))
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            let rand1 = CGFloat(arc4random() % 100) * 0.01
            let rand2 = CGFloat(arc4random() % 100) * 0.01
            let rand3 = CGFloat(arc4random() % 100) * 0.01
            let rand4 = CGFloat(arc4random() % 100) * 0.01
            
            view1.backgroundColor = UIColor(displayP3Red: rand1, green: rand2, blue: rand3, alpha: rand4)
            view2.backgroundColor = UIColor(displayP3Red: rand2, green: rand3, blue: rand4, alpha: rand1)
            view3.backgroundColor = UIColor(displayP3Red: rand3, green: rand4, blue: rand1, alpha: rand2)
            view4.backgroundColor = UIColor(displayP3Red: rand4, green: rand3, blue: rand2, alpha: rand1)
        }

        view.addSubview(view1)
        view.addSubview(view2)
        view.addSubview(view3)
        view.addSubview(view4)
    }
}
