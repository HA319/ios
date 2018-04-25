//
//  ViewController.swift
//  BrightnessApp2
//
//  Created by 安藤輝 on 2018/04/12.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    struct Key {
        static let preset1 = "preset1"
        static let preset2 = "preset2"
        static let preset3 = "preset3"
        static let preset4 = "preset4"
    }
    
    @IBOutlet private weak var sliderView: UIView!
    @IBOutlet private weak var iconView: UIView!
    @IBOutlet private weak var timerButton: UIButton!
    @IBOutlet private weak var scheduleButton: UIButton!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var presetButton1: UIButton!
    @IBOutlet private weak var presetButton2: UIButton!
    @IBOutlet private weak var presetButton3: UIButton!
    @IBOutlet private weak var presetSaveButton: UIButton!
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
    
    var isAllowNotification = false
    var timerPickerHiddenFlg = false
    var timerLabelHiddenFlg = false
    var timerCount = 0
    var scheduleTimerCount = 0
    var timer = Timer()
    var scheduleTimer = Timer()
    var brighness = CGFloat(0)
    var currentLocation = CGFloat(0)
    var currentConstraint = CGFloat(0)
    var preLocation = CGFloat(0)
    
    var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    var userDefault: UserDefaults {
        return UserDefaults.standard
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        iconView.isUserInteractionEnabled = true
        iconView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(swippingView)))
        
        timerLeadingConstraint.constant = width / 9
        scheduleTrailingConstraint.constant = width / 9
        
        timerPickerView.countDownDuration = 0
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(viewDidEnterBackground(notification:)), name: Notification.Name.UIApplicationDidEnterBackground, object: nil)
    }
    
    @objc func viewDidEnterBackground(notification: Notification) {
        if timerCount > 0 {
            createTimer(count: timerCount)
        }
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

        allowLocalNoticication()
        
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
        
        allowLocalNoticication()
        
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
    
    private func allowLocalNoticication() {

        if isAllowNotification {
            return
        }
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert]) { (granted, error) in
            if error != nil {
                return
            }
            if granted {
                UNUserNotificationCenter.current().delegate = self
                self.isAllowNotification = true
            }
        }
    }
    
    @IBAction func startPickerCount(_ sender: UIButton) {
        
        timerCount = Int(timerPickerView.countDownDuration)
        createTimer(count: timerCount)
    }
    
    @IBAction func startSchedulePickerCount(_ sender: UIDatePicker) {
        
        scheduleTimerCount = Int(schedulePickerView.countDownDuration)
        createScheduleTimer()
        let h = scheduleTimerCount / 3600
        let m = scheduleTimerCount & 3600 / 60
        timerLabel.text = String(format: "%1$02d:%2$02d", h,m)
    }
    
    private func createTimer(count: Int) {
        
        timerCount = count
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            
            if self.timerCount == 0 {
                //　通知設定に必要なクラスをインスタンス化
                let trigger: UNNotificationTrigger
                let content = UNMutableNotificationContent()
                
                // トリガー設定
                trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0, repeats: false)
                // 通知内容の設定
                content.title = ""
                content.body = "食事の時間になりました！"
                content.sound = UNNotificationSound.default()
                
                // 通知スタイルを指定
                let request = UNNotificationRequest(identifier: "uuid", content: content, trigger: trigger)
                // 通知をセット
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                
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
                // TODO: - プッシュ通知
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
        createTimer(count: timerCount)
        timerPauseButton.isHidden = !timerPauseButton.isHidden
        timerRestartButton.isHidden = !timerRestartButton.isHidden
    }
    
    @IBAction func tappedTimerCancelButton(_ sender: UIButton) {
        
        timer.invalidate()
        timerCount = 0
        timerDispView.isHidden = timerLabelHiddenFlg
        timerLabelHiddenFlg = !timerLabelHiddenFlg
    }
    
    @IBAction func tappedPresetButton1(_ sender: UIButton) {
        if let ts = userDefault.string(forKey: Key.preset1) {
            UIScreen.main.brightness = CGFloat(NSString(string: ts).floatValue)
            slideSlidView(brightness: UIScreen.main.brightness)
        }
    }
    
    @IBAction func tappedPresetButton2(_ sender: UIButton) {
        if let ts = userDefault.string(forKey: Key.preset2) {
            UIScreen.main.brightness = CGFloat(NSString(string: ts).floatValue)
            slideSlidView(brightness: UIScreen.main.brightness)
        }
    }
    
    @IBAction func tappedPresetButton3(_ sender: UIButton) {
        if let ts = userDefault.string(forKey: Key.preset3) {
            UIScreen.main.brightness = CGFloat(NSString(string: ts).floatValue)
            slideSlidView(brightness: UIScreen.main.brightness)
        }
    }
    
    @IBAction func tappedPresetSaveButton(_ sender: UIButton) {
    
        let alert = UIAlertController(title: "輝度を保存します", message: "記憶するプリセットを選択してください", preferredStyle: .alert)

        let action1 = UIAlertAction(title: "P1", style: .default) { _ in
            self.userDefault.set(UIScreen.main.brightness, forKey: Key.preset1)
        }
        let action2 = UIAlertAction(title: "P2", style: .default) { _ in
            self.userDefault.set(UIScreen.main.brightness, forKey: Key.preset2)
        }
        let action3 = UIAlertAction(title: "P3", style: .default) { _ in
            self.userDefault.set(UIScreen.main.brightness, forKey: Key.preset3)
        }

        alert.addAction(action1)
        alert.addAction(action2)
        alert.addAction(action3)
        present(alert, animated: true, completion: nil)
    }
    
    private func slideSlidView(brightness: CGFloat) {
        
        UIView.animate(withDuration: 0.2) {
            self.iconView.frame.origin.x = UIScreen.main.brightness * (self.sliderView.frame.width - self.iconView.frame.width)
        }
    }
}

extension ViewController: UNUserNotificationCenterDelegate {
    
    // フォアグランド
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    // バックグラウンド
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
    }
}
