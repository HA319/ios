//
//  MemoListViewController.swift
//  iphone_memo
//
//  Created by 安藤輝 on 2018/03/26.
//  Copyright © 2018年 安藤輝. All rights reserved.
//

import UIKit

class MemoListViewController: UIViewController {

    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    var memodatas: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MemoTitleCell", bundle: nil), forCellReuseIdentifier: "memoTitleCell")
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(edit))
        navigationItem.setRightBarButton(rightBarButton, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        memodatas = UserDefaults.getSavedMemos()
        countLabel.text = .countLabel(count: memodatas?.count ?? 0)
        tableView.reloadData()
    }
    // 新規ボタン
    @IBAction func tappedNewButton(_ sender: UIButton) {
        
        if let memoDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detail") as? MemoDetailViewController {
            navigationController?.pushViewController(memoDetailViewController, animated: true)
        }
    }
    
    @objc func edit() {
        tableView.isEditing = !tableView.isEditing
        countLabel.text = .countLabel(count: memodatas?.count ?? 0)
    }
}

extension MemoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return memodatas?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "memoTitleCell") as? MemoTitleCell,
            let memos = memodatas else {
                return UITableViewCell()
        }
        cell.configure(memo: memos[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CGFloat(80)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let memodatas = memodatas else {
            return
        }
        if let memoDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detail") as? MemoDetailViewController {
            memoDetailViewController.memoText = memodatas[indexPath.row]
            memoDetailViewController.index = indexPath.row
            navigationController?.pushViewController(memoDetailViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            memodatas?.remove(at: indexPath.row)
            UserDefaults.removeMemos(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            countLabel.text = .countLabel(count: memodatas?.count ?? 0)
        }
    }
}
