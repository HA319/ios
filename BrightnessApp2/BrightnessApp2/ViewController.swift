//
//  ViewController.swift
//  BrightnessApp2
//
//  Created by 安藤輝 on 2018/04/12.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var sliderBaseView: UIView!
    @IBOutlet private weak var sliderView: UIView!
    @IBOutlet private weak var iconView: UIView!
    @IBOutlet private weak var settingBaseView: UIView!
    @IBOutlet private weak var timerButton: UIButton!
    @IBOutlet private weak var scheduleButton: UIButton!
    @IBOutlet private weak var presetBaseView: UIView!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var presetButton1: UIButton!
    @IBOutlet private weak var presetButton2: UIButton!
    @IBOutlet private weak var presetButton3: UIButton!
    @IBOutlet private weak var presetButton4: UIButton!
    
    @IBOutlet private weak var timerLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var iconLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var scheduleTrailingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var presetBaseLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var presetBaseTrailingConstraint: NSLayoutConstraint!
    
    var timerView = UIView()
    var f = false
    
//    override var prefersStatusBarHidden: Bool {// けす
//        return true
//    }
    
    var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        iconView.isUserInteractionEnabled = true
        iconView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(swippingView)))
        
        sliderView.layer.cornerRadius = 15

        iconView.layer.cornerRadius = iconView.frame.width / 2

        timerButton.layer.cornerRadius = timerButton.frame.width / 2
        scheduleButton.layer.cornerRadius = scheduleButton.frame.width / 2
        timerLeadingConstraint.constant = width / 9
        scheduleTrailingConstraint.constant = width / 9

        presetButton1.layer.cornerRadius = presetButton1.frame.width / 2
        presetButton2.layer.cornerRadius = presetButton2.frame.width / 2
        presetButton3.layer.cornerRadius = presetButton3.frame.width / 2
        presetButton4.layer.cornerRadius = presetButton4.frame.width / 2
        
        initTimerButton()
    }

    @objc func swippingView(_ sender: UIPanGestureRecognizer) {
        
        let location = sender.location(in: iconView)
        iconView.center.x = location.x
    }
    
    private func initTimerButton() {
        
        let hy = UIApplication.shared.statusBarFrame.height + headerView.frame.height + sliderBaseView.frame.height + 2
        let ty = timerButton.frame.origin.y + timerButton.frame.height
        timerView = UIView(frame: CGRect(x: 0,
                                         y: hy + ty + 5,
                                         width: view.frame.width,
                                         height: presetBaseView.frame.height - timerButton.frame.height - timerButton.frame.origin.y + presetBaseView.frame.height))
        timerView.backgroundColor = .black
        timerView.isHidden = true
        view.addSubview(timerView)
    }
    
    @IBAction func tappedTimerButton(_ sender: UIButton) {

        timerView.isHidden = f
        f = !f
    }
    
    @IBAction func tappedScheduleButton(_ sender: UIButton) {
    }
    
    @IBAction func tappedPresetButton1(_ sender: UIButton) {
    }
    
    @IBAction func tappedPresetButton2(_ sender: UIButton) {
    }
    
    @IBAction func tappedPresetButton3(_ sender: UIButton) {
    }
    
    @IBAction func tappedPresetButton4(_ sender: UIButton) {
        
        timerView.isHidden = f
        f = !f
    }
}
