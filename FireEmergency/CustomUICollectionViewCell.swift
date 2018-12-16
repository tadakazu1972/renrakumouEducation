//
//  CustomUICollectionViewCell.swift
//  FireEmergency
//
//  Created by 中道忠和 on 2017/01/15.
//  Copyright © 2017年 tadakazu nakamichi. All rights reserved.
//

import UIKit

class CustomUICollectionViewCell : UICollectionViewCell{
    
    var textLabel : UILabel?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // UILabelを生成.
        textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        textLabel?.text = "nil"
        textLabel?.backgroundColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        textLabel?.textAlignment = NSTextAlignment.center
        
        // Cellに追加.
        self.contentView.addSubview(textLabel!)
    }
    
}
