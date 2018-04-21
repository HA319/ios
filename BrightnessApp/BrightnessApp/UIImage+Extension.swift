//
//  UIImage+Extension.swift
//  BrightnessApp
//
//  Created by 安藤輝 on 2018/04/08.
//  Copyright © 2018年 安藤輝. All rights reserved.
//

import UIKit

extension UIImage {
    
    func resizeImage(width : CGFloat, height : CGFloat) -> UIImage! {
        
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
