//
//  SwipeBaseView.swift
//  BrightnessApp
//
//  Created by 安藤輝 on 2018/04/07.
//  Copyright © 2018年 安藤輝. All rights reserved.
//

import UIKit

class SwipeBaseView: UIView {
    
    struct Limit {
        static let leading: CGFloat = 20.0
        static let trailing = UIScreen.main.bounds.width - 20.0
    }
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var swipeTextField: UITextField!
    @IBOutlet weak var swipeView: UIView!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint! // max:375
    
    var current: CGFloat = 0.0
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initSwipeView()
        initTextField()
        initImageView()
        
        leadingConstraint.constant = Limit.trailing * UIScreen.main.brightness
        current = leadingConstraint.constant
    }

    private func initBaseView() {
        
        baseView.layer.borderWidth = CGFloat(3)
        baseView.layer.borderColor = UIColor.white.cgColor
        baseView.layer.cornerRadius = baseView.frame.width / 2
    }
    
    private func initSwipeView() {
        
        swipeView.layer.cornerRadius = swipeView.frame.width / 2
        swipeView.isUserInteractionEnabled = true
        swipeView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(swipingView)))
    }
    
    private func initTextField() {
        
        // swipeTextField調整
        // いつか調整するかも
    }
    
    private func initImageView() {
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: swipeView.frame.width, height: swipeView.frame.height))
        imageView.image = UIImage(named: "SliderImage")
        swipeView.addSubview(imageView)
    }
    
    @objc func swipingView(sender: UIPanGestureRecognizer) {

        let position = sender.translation(in: swipeView)
        if (position.x + current) < Limit.leading || (position.x + current) > Limit.trailing - swipeView.frame.width {
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
            let max = Limit.trailing
            let c = leadingConstraint.constant / max
            UIScreen.main.brightness = c
        }
    }
}
