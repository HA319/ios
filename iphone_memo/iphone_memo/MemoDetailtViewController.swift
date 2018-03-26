//
//  MemoDetailtViewController.swift
//  iphone_memo
//
//  Created by 安藤輝 on 2018/03/26.
//  Copyright © 2018年 安藤輝. All rights reserved.
//

import UIKit

class MemoDetailViewController: UIViewController {
    
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var textView: UITextView!
    var memoText: String?
    var index: Int?
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateLabel.text = CommonUtil.getCurrentTime()
        textView.text = memoText
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完了",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(tappedCompleateButton))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        guard let text = textView.text, !text.isEmpty else {
            return
        }
        
        if let index = index {
            UserDefaults.removeMemos(index: index)
        }
        UserDefaults.setMemos(memo: text)
    }
    
    @objc func tappedCompleateButton() {
        
        textView.resignFirstResponder()
    }
    
    @IBAction func tappedRemoveButton(_ sender: UIButton) {
        
        if let index = index {
            UserDefaults.removeMemos(index: index)
            textView.text = nil
        }
        navigationController?.popViewController(animated: true)
    }
}

