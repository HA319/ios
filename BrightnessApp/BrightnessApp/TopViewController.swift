//
//  TopViewController.swift
//  BrightnessApp
//
//  Created by 安藤輝 on 2018/04/07.
//  Copyright © 2018年 安藤輝. All rights reserved.
//

import UIKit

class TopViewController: UIViewController {

    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var adView: UIView!
    @IBOutlet weak var lineTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let swipeBaseView = UINib(nibName: "SwipeBaseView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! SwipeBaseView
//        swipeBaseView.frame.origin = CGPoint(x: 0, y: adView.frame.origin.y - swipeBaseView.frame.height - 10) // 案1 広告の上
//        swipeBaseView.frame.origin = CGPoint(x: 0, y: 50) // 案2 画面上部(てきとうな高さ)
//        swipeBaseView.frame.origin = CGPoint(x: 0, y: lineView.frame.origin.y - lineView.frame.height - swipeBaseView.frame.height - 10) // 案3 オレンジ線の上
        swipeBaseView.frame = CGRect(x: 0,
                                     y: lineView.frame.origin.y - lineView.frame.height - swipeBaseView.frame.height - lineTopConstraint.constant, // 調整の10
                                     width: view.frame.width,
                                     height: adView.frame.height * 1.5)

        
        view.addSubview(swipeBaseView)
    }
}
