//
//  TopViewController.swift
//  BrightnessApp
//
//  Created by 安藤輝 on 2018/04/07.
//  Copyright © 2018年 安藤輝. All rights reserved.
//

import UIKit

class TopViewController: UIViewController {

    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var adView: UIView!
    @IBOutlet weak var lineTopConstraint: NSLayoutConstraint!
    
    let contents = ["megane", "human", "newnote", "notification"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let swipeBaseView = UINib(nibName: "SwipeBaseView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! SwipeBaseView
        swipeBaseView.frame = CGRect(x: 0,
                                     y: lineView.frame.origin.y - lineView.frame.height - swipeBaseView.frame.height - lineTopConstraint.constant,
                                     width: view.frame.width,
                                     height: adView.frame.height * 1.5)
        view.addSubview(swipeBaseView)
    }
}

extension TopViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return contents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .lightGray
        let imageView = cell.contentView.viewWithTag(1) as! UIImageView
        let cellImage = UIImage(named: contents[indexPath.row])
        imageView.image = cellImage
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width / 2 - 0.5, height: collectionView.bounds.height / 2 - 0.5)
    }
}
