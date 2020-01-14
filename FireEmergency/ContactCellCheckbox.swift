//
//  ContactCellCheckbox.swift
//  FireEmergency
//
//  Created by 中道忠和 on 2017/02/25.
//  Copyright © 2017年 tadakazu nakamichi. All rights reserved.
//

import UIKit

class ContactCellCheckbox: UITableViewCell, UITextViewDelegate {
    var checkbox: UIButton?
    var name : UILabel?
    var tel  : UITextView?
    var mail : UITextView?
    var kubun: UILabel?
    var syozoku0: UILabel?
    var syozoku : UILabel?
    var kinmu : UILabel?
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        checkbox = UIButton(frame: CGRect(x: 0, y: 14, width: 28, height: 28))
        checkbox?.tintColor = UIColor.red
        checkbox?.setImage(UIImage(named: "ic_check_box.png"), for: UIControl.State.selected)
        checkbox?.setImage(UIImage(named: "ic_check_box_outline_blank.png"), for: UIControl.State())
        self.contentView.addSubview(checkbox!)
        
        name = UILabel(frame: CGRect(x: 28, y: 0, width: 140, height: 24))
        name?.text = "nil"
        name?.font = UIFont.systemFont(ofSize: 20)
        self.addSubview(name!)
        
        tel = UITextView(frame: CGRect(x: 141, y: -8, width: 160, height: 30))
        tel?.text = "nil"
        tel?.font = UIFont.systemFont(ofSize: 18)
        tel?.isUserInteractionEnabled = true
        tel?.dataDetectorTypes = .phoneNumber
        tel?.isScrollEnabled = false
        tel?.isEditable = false
        tel?.isSelectable = true
        tel?.delegate = self
        self.contentView.addSubview(tel!)
        
        kubun = UILabel(frame: CGRect(x: 28, y: 28, width: 60, height: 16))
        kubun?.text = "nil"
        kubun?.font = UIFont.systemFont(ofSize: 14)
        self.contentView.addSubview(kubun!)
        
        syozoku0 = UILabel(frame: CGRect(x: 62, y: 28, width: 100, height: 16))
        syozoku0?.text = "nil"
        syozoku0?.font = UIFont.systemFont(ofSize: 14)
        self.contentView.addSubview(syozoku0!)
        
        syozoku = UILabel(frame: CGRect(x: 160, y: 28, width: 100, height: 16))
        syozoku?.text = "nil"
        syozoku?.font = UIFont.systemFont(ofSize: 14)
        self.contentView.addSubview(syozoku!)
        
        kinmu = UILabel(frame: CGRect(x: 260, y: 28, width: 80, height: 16))
        kinmu?.text = "nil"
        kinmu?.font = UIFont.systemFont(ofSize: 14)
        self.contentView.addSubview(kinmu!)
        
        mail = UITextView(frame: CGRect(x: 28, y: 44, width: 300, height: 24))
        mail?.text = "nil"
        mail?.font = UIFont.systemFont(ofSize: 14)
        mail?.isUserInteractionEnabled = true
        mail?.dataDetectorTypes = .link
        mail?.isScrollEnabled = false
        mail?.isEditable = false
        mail?.isSelectable = true
        mail?.delegate = self
        self.contentView.addSubview(mail!)
    }
}
