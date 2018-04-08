//
//  SwipeBaseView.swift
//  BrightnessApp
//
//  Created by 安藤輝 on 2018/04/07.
//  Copyright © 2018年 安藤輝. All rights reserved.
//

import UIKit

// バグ1 最後までスクロールしても輝度がmaxにならない
// バグ2 端までスクロールした後に再度スクロールすると前回のタップ位置に戻る
// バグ3 画像がはみでてる

class SwipeBaseView: UIView {
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var swipeTextField: UITextField!
    @IBOutlet weak var swipeView: UIView!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    var current: CGFloat = 0.0
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initBaseView()
        initSwipeView()
        initImageView()
        
        leadingConstraint.constant = baseView.frame.width * UIScreen.main.brightness
        current = leadingConstraint.constant
    }

    private func initBaseView() {
        
        baseView.layer.cornerRadius = 15
    }
    
    private func initSwipeView() {
        
        swipeView.layer.cornerRadius = swipeView.frame.width / 2
        swipeView.isUserInteractionEnabled = true
        swipeView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(swipingView)))
    }
    
    private func initImageView() {
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: swipeView.frame.width, height: swipeView.frame.height))
        imageView.image = UIImage(named: "ExImage")?.resizeImage(width: swipeView.frame.width, height: swipeView.frame.height) // TODO: - 画像がはみ出ているから画像を直すかresizeImageでどうにかする
        swipeView.addSubview(imageView)
    }
    
    @objc func swipingView(sender: UIPanGestureRecognizer) {

        let position = sender.translation(in: swipeView)
        // Baseを超えたらreturn
        if (position.x + current) < 0 || (position.x + current) > baseView.frame.width - swipeView.frame.width {
            return
        }
        
        // todo: 動きがおかしいなおす
        // begainの位置に戻っている
        switch sender.state {
        case .began:
            leadingConstraint.constant = position.x + current
        case .ended:
            current = leadingConstraint.constant
        default:
            leadingConstraint.constant = position.x + current
            let rate = leadingConstraint.constant / baseView.frame.width
            UIScreen.main.brightness = rate
        }
    }
}
