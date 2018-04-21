//
//  SwipeBaseView.swift
//  BrightnessApp
//
//  Created by 安藤輝 on 2018/04/07.
//  Copyright © 2018年 安藤輝. All rights reserved.
//

import UIKit

class SwipeBaseView: UIView {
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var swipeTextField: UITextField!
    @IBOutlet weak var brightSwipeView: UIView!
    @IBOutlet weak var blueLightSwipeView: UIView!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    var current: CGFloat = 0.0
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initBaseView()
        initSwipeView()
        initBlueLightSwipeView()
        initImageView()
        
        leadingConstraint.constant = baseView.frame.width * UIScreen.main.brightness
        current = leadingConstraint.constant
    }
    
    private func initBaseView() {
        
        baseView.layer.cornerRadius = 15
    }
    
    private func initSwipeView() {
        
        brightSwipeView.layer.cornerRadius = brightSwipeView.frame.width / 2
        brightSwipeView.isUserInteractionEnabled = true
        brightSwipeView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(swipingView)))
    }
    
    private func initBlueLightSwipeView() {
        
        blueLightSwipeView.layer.cornerRadius = blueLightSwipeView.frame.width / 2
        blueLightSwipeView.isUserInteractionEnabled = true
        blueLightSwipeView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(swipingView)))
    }
    
    private func initImageView() {
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: brightSwipeView.frame.width, height: brightSwipeView.frame.height))
        imageView.image = UIImage(named: "ExImage")?.resizeImage(width: brightSwipeView.frame.width, height: brightSwipeView.frame.height)
        brightSwipeView.addSubview(imageView)
    }
    
    @objc func swipingView(sender: UIPanGestureRecognizer) {

        let position = sender.translation(in: brightSwipeView)
        // Baseを超えたらreturn
        if (position.x + current) < 0 || (position.x + current) > baseView.frame.width - brightSwipeView.frame.width {
            return
        }
        
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
