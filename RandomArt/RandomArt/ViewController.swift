//
//  ViewController.swift
//  RandomArt
//
//  Created by 安藤輝 on 2018/03/27.
//  Copyright © 2018年 安藤輝. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var view1: UIView!
    @IBOutlet private weak var view2: UIView!
    @IBOutlet private weak var view3: UIView!
    @IBOutlet private weak var view4: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            let rand1 = CGFloat(arc4random() % 100) * 0.01
            let rand2 = CGFloat(arc4random() % 100) * 0.01
            let rand3 = CGFloat(arc4random() % 100) * 0.01
            let rand4 = CGFloat(arc4random() % 100) * 0.01
            
            self.view1.backgroundColor = UIColor(displayP3Red: rand1, green: rand2, blue: rand3, alpha: rand4)
            self.view2.backgroundColor = UIColor(displayP3Red: rand2, green: rand3, blue: rand4, alpha: rand1)
            self.view3.backgroundColor = UIColor(displayP3Red: rand3, green: rand4, blue: rand1, alpha: rand2)
            self.view4.backgroundColor = UIColor(displayP3Red: rand4, green: rand3, blue: rand2, alpha: rand1)
        }
    }
}

