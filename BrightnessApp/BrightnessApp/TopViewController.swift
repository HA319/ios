//
//  TopViewController.swift
//  BrightnessApp
//
//  Created by 安藤輝 on 2018/04/07.
//  Copyright © 2018年 安藤輝. All rights reserved.
//

import UIKit

class TopViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let swipeBaseView = UINib(nibName: "SwipeBaseView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! SwipeBaseView
        swipeBaseView.frame.origin = CGPoint(x: 0, y: 50) // TODO: -  y適当
        
        view.addSubview(swipeBaseView)
    }
}
