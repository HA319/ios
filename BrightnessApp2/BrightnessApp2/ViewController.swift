//
//  ViewController.swift
//  BrightnessApp2
//
//  Created by 安藤輝 on 2018/04/12.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {

    @IBOutlet private weak var sliderView: UIView!
    @IBOutlet private weak var iconView: UIView!
    @IBOutlet private weak var timerButton: UIButton!
    @IBOutlet private weak var scheduleButton: UIButton!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var presetButton1: UIButton!
    @IBOutlet private weak var presetButton2: UIButton!
    @IBOutlet private weak var presetButton3: UIButton!
    @IBOutlet private weak var presetButton4: UIButton!
    @IBOutlet private weak var pickerView: UIView!
    @IBOutlet private weak var timerPickerView: UIDatePicker!
    @IBOutlet private weak var schedulePickerView: UIDatePicker!
    @IBOutlet private weak var timerDispView: UIView!
    @IBOutlet private weak var timerLabel: UILabel!
    @IBOutlet private weak var timerPauseButton: UIButton!
    @IBOutlet private weak var timerRestartButton: UIButton!
    @IBOutlet private weak var timerCancelButton: UIButton!
    
    @IBOutlet private weak var timerLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var scheduleTrailingConstraint: NSLayoutConstraint!
    
    var timerPickerHiddenFlg = false
    var timerLabelHiddenFlg = false
    var timerCount = 0
    var scheduleTimerCount = 0
    var timer = Timer()
    var scheduleTimer = Timer()
    var brighness = UIScreen.main.brightness
    var currentLocation = CGFloat(0)
    var currentConstraint = CGFloat(0)
    var preLocation = CGFloat(0)
    
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
        
        timerPickerView.countDownDuration = 0
        
        // TODO: - いつものあの音を探す
//        let soundIdRing: SystemSoundID = 1005
//        AudioServicesPlayAlertSound(soundIdRing)
    }

    @objc func swippingView(_ sender: UIPanGestureRecognizer) {
        
        // todo: - 始まりと終わりを使ってシームレスにする
        let location = sender.location(in: iconView)
        
        switch sender.state {
        case .began:
            break
            
        case .ended:
            break
        default:
            if iconView.frame.origin.x + location.x < 0 || iconView.frame.origin.x + location.x > (sliderView.frame.width - iconView.frame.width) {
                return
            }
            iconView.frame.origin.x += location.x
            UIScreen.main.brightness = iconView.frame.origin.x / (sliderView.frame.width - iconView.frame.width)
        }
    }
    
    @IBAction func tappedTimerButton(_ sender: UIButton) {

        timerPickerView.isHidden = !timerPickerView.isHidden
        schedulePickerView.isHidden = true
        
        if timerCount > 0 {
            // タイマー開始中
            timerDispView.isHidden = timerLabelHiddenFlg
            timerLabelHiddenFlg = !timerLabelHiddenFlg
        } else {
            // タイマー開始前
            pickerView.isHidden = timerPickerHiddenFlg
            timerPickerHiddenFlg = !timerPickerHiddenFlg
        }
    }
    
    @IBAction func tappedScheduleButton(_ sender: UIButton) {
        
        schedulePickerView.isHidden = !schedulePickerView.isHidden
        timerPickerView.isHidden = true

        if scheduleTimerCount > 0 {
            // タイマー開始中
            timerDispView.isHidden = timerLabelHiddenFlg
            timerLabelHiddenFlg = !timerLabelHiddenFlg
        } else {
            // タイマー開始前
            pickerView.isHidden = timerPickerHiddenFlg
            timerPickerHiddenFlg = !timerPickerHiddenFlg
        }
    }
    
    @IBAction func tappedPresetButton1(_ sender: UIButton) {
    }
    
    @IBAction func tappedPresetButton2(_ sender: UIButton) {
    }
    
    @IBAction func tappedPresetButton3(_ sender: UIButton) {
    }
    
    @IBAction func tappedPresetButton4(_ sender: UIButton) {
    }
    
    @IBAction func startPickerCount(_ sender: UIButton) {
        
        timerCount = Int(timerPickerView.countDownDuration)
        createTimer()
    }
    
    @IBAction func startSchedulePickerCount(_ sender: UIDatePicker) {
        
        scheduleTimerCount = Int(schedulePickerView.countDownDuration)
        createScheduleTimer()
        let h = scheduleTimerCount / 3600
        let m = scheduleTimerCount & 3600 / 60
        timerLabel.text = String(format: "%1$02d:%2$02d", h,m)
    }
    
    private func createTimer() {
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            
            if self.timerCount == 0 {
                // TODO: - タイマーならす
                self.timer.invalidate()
            } else {
                self.timerCount -= 1
            }
            
            let h = self.timerCount / 3600
            let m = self.timerCount % 3600 / 60
            let s = self.timerCount % 60
            self.timerLabel.text = String(format: "%1$02d:%2$02d:%3$02d", h,m,s)
        })
        pickerView.isHidden = timerPickerHiddenFlg
        timerPickerHiddenFlg = !timerPickerHiddenFlg
    }
    
    private func createScheduleTimer() {
        
        scheduleTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true, block: { _ in

            if Date().timeIntervalSinceNow == self.schedulePickerView.countDownDuration {
                // TODO: - タイマー鳴らす
                self.scheduleTimer.invalidate()
                print("スケジュール終了")
            }
        })
        pickerView.isHidden = timerPickerHiddenFlg
        timerPickerHiddenFlg = !timerPickerHiddenFlg
    }
    
    @IBAction func tappedTimerPauseButton(_ sender: UIButton) {
        
        timer.invalidate()
        timerPauseButton.isHidden = !timerPauseButton.isHidden
        timerRestartButton.isHidden = !timerRestartButton.isHidden
    }
    
    @IBAction func tappedTimerRestartButton(_ sender: UIButton) {
        
        timer.invalidate()
        createTimer()
        timerPauseButton.isHidden = !timerPauseButton.isHidden
        timerRestartButton.isHidden = !timerRestartButton.isHidden
    }
    
    @IBAction func tappedTimerCancelButton(_ sender: UIButton) {
        
        timer.invalidate()
        timerCount = 0
        timerDispView.isHidden = timerLabelHiddenFlg
        timerLabelHiddenFlg = !timerLabelHiddenFlg
    }
}
