//
//  ContactCell1.swift
//  FireEmergency
//
//  Created by 中道忠和 on 2017/01/25.
//  Copyright © 2017年 tadakazu nakamichi. All rights reserved.
//

import UIKit

class ContactCell1: UITableViewCell {
    var name : UILabel?
    var tel  : UILabel?
    var mail : UILabel?
    var kubun: UILabel?
    var syozoku0: UILabel?
    var syozoku : UILabel?
    var kinmu : UILabel?
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        name = UILabel(frame: CGRect(x: 0, y: 0, width: 140, height: 24))
        name?.text = "nil"
        name?.font = UIFont.systemFont(ofSize: 20)
        self.addSubview(name!)
        
        tel = UILabel(frame: CGRect(x: 141, y: 0, width: 160, height: 24))
        tel?.text = "nil"
        tel?.font = UIFont.systemFont(ofSize: 18)
        self.contentView.addSubview(tel!)
        
        kubun = UILabel(frame: CGRect(x: 0, y: 28, width: 60, height: 16))
        kubun?.text = "nil"
        kubun?.font = UIFont.systemFont(ofSize: 18)
        self.contentView.addSubview(kubun!)
        
        syozoku0 = UILabel(frame: CGRect(x: 30, y: 28, width: 100, height: 16))
        syozoku0?.text = "nil"
        syozoku0?.font = UIFont.systemFont(ofSize: 16)
        self.contentView.addSubview(syozoku0!)
        
        syozoku = UILabel(frame: CGRect(x: 160, y: 28, width: 100, height: 16))
        syozoku?.text = "nil"
        syozoku?.font = UIFont.systemFont(ofSize: 16)
        self.contentView.addSubview(syozoku!)
        
        kinmu = UILabel(frame: CGRect(x: 280, y: 28, width: 80, height: 16))
        kinmu?.text = "nil"
        kinmu?.font = UIFont.systemFont(ofSize: 16)
        self.contentView.addSubview(kinmu!)
        
        mail = UILabel(frame: CGRect(x: 0, y: 48, width: 300, height: 18))
        mail?.text = "nil"
        mail?.font = UIFont.systemFont(ofSize: 16)
        self.contentView.addSubview(mail!)
    }
    
}
