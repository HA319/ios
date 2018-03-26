//
//  MemoTitleCell.swift
//  iphone_memo
//
//  Created by 安藤輝 on 2018/03/26.
//  Copyright © 2018年 安藤輝. All rights reserved.
//

import UIKit

class MemoTitleCell: UITableViewCell {

    @IBOutlet private weak var memoTitleLabel: UILabel!
    @IBOutlet private weak var memoDateLabel: UILabel!
    
    func configure(memo: String) {
        memoTitleLabel?.text = memo
        memoDateLabel?.text = CommonUtil.getCurrentDate()
    }
}
