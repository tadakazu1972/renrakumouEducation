//
//  BousainetDialog.swift
//  FireEmergency
//
//  Created by 中道忠和 on 2017/01/18.
//  Copyright © 2017年 tadakazu nakamichi. All rights reserved.
//

import UIKit

class BousainetDialog {
    //ボタン押したら出るUIWindow
    fileprivate var parent: UIViewController!
    fileprivate var win1: UIWindow!
    fileprivate var text1: UITextView!
    fileprivate var text2: UITextView!
    fileprivate var btnClose: UIButton!
    fileprivate var btnApp: UIButton!
    
    //コンストラクタ
    init(parentView: UIViewController){
        parent = parentView
        win1 = UIWindow()
        text1 = UITextView()
        text2 = UITextView()
        btnClose = UIButton()
        btnApp = UIButton()
    }
    
    //デコンストラクタ
    deinit{
        parent = nil
        win1 = nil
        text1 = nil
        text2 = nil
        btnClose = nil
        btnApp = nil
    }
    
    //表示
    func showInfo(){
        //元の画面を暗く
        parent.view.alpha = 0.3
        //初期設定
        //Win1
        win1.backgroundColor = UIColor.white
        win1.frame = CGRect(x: 80,y: 10,width: parent.view.frame.width-40,height: parent.view.frame.height/2+180)
        win1.layer.position = CGPoint(x: parent.view.frame.width/2, y: parent.view.frame.height/2)
        win1.alpha = 1.0
        win1.layer.cornerRadius = 10
        //KeyWindowにする
        win1.makeKey()
        //表示
        self.win1.makeKeyAndVisible()
        
        //TextView生成
        text1.frame = CGRect(x: 10,y: 10, width: self.win1.frame.width - 20, height: self.win1.frame.height-60)
        text1.backgroundColor = UIColor.clear
        text1.font = UIFont.systemFont(ofSize: CGFloat(18))
        text1.textColor = UIColor.black
        text1.textAlignment = NSTextAlignment.left
        text1.isEditable = false
        text1.isScrollEnabled = true
        text1.dataDetectorTypes = .link
        
        text1.text="URLをタップしてください\n\n■おおさか防災ネット\n\nhttp://www.osaka-bousai.net/pref/index.html\n\n■大阪市防災アプリ"
        self.win1.addSubview(text1)
        
        //iOS版「大阪市防災アプリ」のAppStoreを表示するTextView生成
        text2.frame = CGRect(x: 60,y: self.win1.frame.height/2+34, width: self.win1.frame.width/1.7, height: self.win1.frame.height/2+160)
        text2.backgroundColor = UIColor.clear
        text2.font = UIFont.systemFont(ofSize: CGFloat(12))
        text2.textColor = UIColor.black
        text2.textAlignment = NSTextAlignment.left
        text2.isEditable = false
        text2.isScrollEnabled = true
        text2.dataDetectorTypes = .link
        text2.isHidden = true //該当署ボタンを押すまで隠しておく
        
        text2.text="現在はこのボタンから起動できませんので、AppStoreから起動するか、まだ入手していなければ入手してください。\n\nhttps://itunes.apple.com/app/id1092387835"
        
        self.win1.addSubview(text2)
        
        //閉じるボタン生成
        btnClose.frame = CGRect(x: 0,y: 0,width: 100,height: 30)
        btnClose.backgroundColor = UIColor.orange
        btnClose.setTitle("閉じる", for: UIControl.State())
        btnClose.setTitleColor(UIColor.white, for: UIControl.State())
        btnClose.layer.masksToBounds = true
        btnClose.layer.cornerRadius = 10.0
        btnClose.layer.position = CGPoint(x: self.win1.frame.width/2, y: self.win1.frame.height-20)
        btnClose.addTarget(self, action: #selector(self.onClickClose(_:)), for: .touchUpInside)
        self.win1.addSubview(btnClose)
        
        //大阪市防災アプリボタン生成
        btnApp.frame = CGRect(x: 0,y: 0,width: 160,height: 30)
        btnApp.backgroundColor = UIColor.lightGray
        btnApp.setTitle("大阪市防災アプリ", for: UIControl.State())
        btnApp.setTitleColor(UIColor.black, for: UIControl.State())
        btnApp.layer.masksToBounds = true
        btnApp.layer.cornerRadius = 0.0
        btnApp.layer.position = CGPoint(x: self.win1.frame.width/2, y: self.win1.frame.height/2)
        btnApp.addTarget(self, action: #selector(self.onClickApp(_:)), for: .touchUpInside)
        self.win1.addSubview(btnApp)
    }
    
    //大阪市防災アプリボタン
    @objc func onClickApp(_ sender: UIButton){
        //大阪市防災アプリ iOS版にはURLスキームが設定されていないので、AppStoreを一度経由して、インストールしていたら開く、してなかったら入手
        let url1 = URL(string: "jp.goo.bousai.osakaapp://")!
        let url2 = URL(string: "https://itunes.apple.com/app/id1092387835")
        if (UIApplication.shared.canOpenURL(url1)) {
            UIApplication.shared.openURL(url1)
        } else {
            UIApplication.shared.openURL(url2!)
        }
        
        if (text2.isHidden) {
            text2.isHidden = false
        } else {
            text2.isHidden = true
        }
    }
    
    //閉じる
    @objc func onClickClose(_ sender: UIButton){
        win1.isHidden = true      //win1隠す
        text1.text = ""         //使い回しするのでテキスト内容クリア
        parent.view.alpha = 1.0 //元の画面明るく
    }
}
