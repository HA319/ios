//
//  CommonUtil.swift
//  iphone_memo
//
//  Created by 安藤輝 on 2018/03/26.
//  Copyright © 2018年 安藤輝. All rights reserved.
//

import UIKit

class CommonUtil {
    
    class func getCurrentDate() -> String {
        
        let format = DateFormatter()
        format.dateStyle = .medium
        format.dateFormat = "yyyy-MM-dd"
        return format.string(from: Date())
    }
    
    class func getCurrentTime() -> String {
        
        let format = DateFormatter()
        format.dateStyle = .full
        format.timeStyle = .full
        format.dateFormat = "yyyy年MM月dd日 HH:MM"
        return format.string(from: Date())
    }
}

extension UserDefaults {
    
    class func getSavedMemos() -> [String]? {
        
        return UserDefaults.standard.stringArray(forKey: "memo")
        
    }
    
    class func setMemos(memo: String) {
        
        var memos = [String]()
        if let savedMemos = getSavedMemos() {
            savedMemos.forEach { memos.append($0) }
        }
        memos.append(memo)
        UserDefaults.standard.set(memos, forKey: "memo")
    }
    
    class func removeMemos(index: Int) {
        
        guard let savedMemos = getSavedMemos(), !savedMemos.isEmpty else {
            return
        }
        var memos = [String]()
        savedMemos.forEach { memos.append($0) }
        memos.remove(at: index)
        UserDefaults.standard.set(memos, forKey: "memo")
    }
}

extension String {
    
    static func countLabel(count: Int) -> String {
        return "\(count)件のメモ"
    }
}

