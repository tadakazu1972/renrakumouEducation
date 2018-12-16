//
//  ContactLoadDialog2.swift
//  FireEmergency
//
//  Created by 中道忠和 on 2017/02/05.
//  Copyright © 2017年 tadakazu nakamichi. All rights reserved.
//

import UIKit

class ContactLoadDialog2: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    //ボタン押したら出るUIWindow
    fileprivate var parent: UIViewController!
    fileprivate var win1: UIWindow!
    fileprivate var text1: UITextView!
    fileprivate var table: UITableView!
    var result: [[String]] = []
    fileprivate var btnClose: UIButton!
    fileprivate var btnMail: UIButton!
    fileprivate var btnAll: UIButton!
    //データ保存用
    let userDefaults = UserDefaults.standard
    var mainStation: String!
    var tsunamiStation: String!
    var kubun: String!
    //選択_id保存用配列
    var checkArray: [Bool] = []
    
    //コンストラクタ
    init(parentView: UIViewController, resultFrom: [[String]]){
        super.init()
        parent = parentView
        win1 = UIWindow()
        text1 = UITextView()
        table = UITableView()
        btnClose = UIButton()
        btnMail = UIButton()
        btnAll = UIButton()
        result = resultFrom
        checkArray = Array(repeating: false, count: result.count) //抽出件数だけ初期化
    }
    
    //デコンストラクタ
    deinit{
        parent = nil
        win1 = nil
        text1 = nil
        table = nil
        btnClose = nil
        btnMail = nil
        btnAll = nil
        checkArray.removeAll()
    }
    
    //表示
    func showResult(){
        //元の画面を暗く
        parent.view.alpha = 0.3
        //初期設定
        //Win1
        win1.backgroundColor = UIColor.white
        win1.frame = CGRect(x: 80,y: 180,width: parent.view.frame.width-20,height: parent.view.frame.height-100)
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
        text1.text="選択してメール送信"
        self.win1.addSubview(text1)
        
        //TableView生成
        table.frame = CGRect(x: 10, y: 41, width: self.win1.frame.width-20, height: self.win1.frame.height-60)
        table.delegate = self
        table.dataSource = self
        table.estimatedRowHeight = 60 //下とあわせこの２行で複数表示されるときの間がひらくように
        table.rowHeight = UITableViewAutomaticDimension
        table.register(ContactCellCheckbox.self, forCellReuseIdentifier:"contactCellCheckbox")
        table.separatorColor = UIColor.clear
        table.allowsMultipleSelection = true
        self.win1.addSubview(table)
        
        func tableView(_ tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: IndexPath) -> CGFloat { return UITableViewAutomaticDimension }

        
        //閉じるボタン生成
        btnClose.frame = CGRect(x: 0,y: 0,width: 80,height: 30)
        btnClose.backgroundColor = UIColor.orange
        btnClose.setTitle("閉じる", for: UIControlState())
        btnClose.setTitleColor(UIColor.white, for: UIControlState())
        btnClose.layer.masksToBounds = true
        btnClose.layer.cornerRadius = 10.0
        btnClose.layer.position = CGPoint(x: self.win1.frame.width/2, y: self.win1.frame.height-20)
        btnClose.addTarget(self, action: #selector(self.onClickClose(_:)), for: .touchUpInside)
        self.win1.addSubview(btnClose)
        
        //メール送信ボタン生成
        btnMail.frame = CGRect(x: 0,y: 0,width: 90,height: 30)
        btnMail.backgroundColor = UIColor.red
        btnMail.setTitle("メール送信", for: UIControlState())
        btnMail.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btnMail.setTitleColor(UIColor.white, for: UIControlState())
        btnMail.layer.masksToBounds = true
        btnMail.layer.cornerRadius = 10.0
        btnMail.layer.position = CGPoint(x: self.win1.frame.width/2+100, y: self.win1.frame.height-20)
        btnMail.addTarget(self, action: #selector(self.onClickMail(_:)), for: .touchUpInside)
        self.win1.addSubview(btnMail)
        
        //すべて選択/解除ボタン生成
        btnAll.frame = CGRect(x: 0,y: 0,width: 90,height: 30)
        btnAll.backgroundColor = UIColor.magenta
        btnAll.setTitle("全て選択/解除", for: UIControlState())
        btnAll.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btnAll.setTitleColor(UIColor.white, for: UIControlState())
        btnAll.layer.masksToBounds = true
        btnAll.layer.cornerRadius = 10.0
        btnAll.layer.position = CGPoint(x: self.win1.frame.width/2-100, y: self.win1.frame.height-20)
        btnAll.addTarget(self, action: #selector(self.onClickAll(_:)), for: .touchUpInside)
        self.win1.addSubview(btnAll)
    }
    
    //閉じる
    @objc func onClickClose(_ sender: UIButton){
        win1.isHidden = true      //win1隠す
        text1.text = ""         //使い回しするのでテキスト内容クリア
        parent.view.alpha = 1.0 //元の画面明るく
    }
    
    //メール送信
    @objc func onClickMail(_ sender: UIButton){
        //ダイアログ消去
        win1.isHidden = true
        text1.text = ""
        parent.view.alpha = 1.0
        
        //メールアドレス集約
        var addressArray: [String] = []
        let line = result.count //countで２次元配列の行数をカウントしてくれる！なんてこった！
        for index in 0..<line {
            //チェック配列を上から順に見ていって、チェックされていたら同じインデックスのmailを捕獲
            if self.checkArray[index]{
                addressArray.append(result[index][2])
            }
        }
        print(addressArray) //デバッグ用
        
        //次の関数でMailViewControllerを生成して画面遷移する
        sendMail(addressArray)
    }
    
    //メール送信 MailViewController遷移
    func sendMail(_ addressArray: [String]){
        //MailViewControllerのインスタンス生成
        let data:MailViewController = MailViewController(addressArray: addressArray)
        
        //navigationControllerのrootViewControllerにKokuminhogoViewControllerをセット
        let nav = UINavigationController(rootViewController: data)
        nav.setNavigationBarHidden(true, animated: false) //これをいれないとNavigationBarが表示されてうざい
        
        //画面遷移
        parent.present(nav, animated: true, completion: nil)
    }
    
    //全て選択/解除
    func onClickAll(_ sender: UIButton){
        let line = result.count
        for index in 0..<line {
            self.checkArray[index] = !self.checkArray[index]
        }
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection sction:Int)-> Int {
        return self.result.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80 // セルの高さ
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell {
        let cell:ContactCellCheckbox = table.dequeueReusableCell(withIdentifier: "contactCellCheckbox")! as! ContactCellCheckbox
        cell.textLabel?.numberOfLines = 0 //これをしないと複数表示されない
        cell.checkbox!.isSelected = self.checkArray[indexPath.row]
        cell.name!.text = self.result[indexPath.row][0]
        cell.tel!.text  = self.result[indexPath.row][1]
        cell.kubun!.text = self.result[indexPath.row][3] + "号"
        cell.syozoku0!.text = self.result[indexPath.row][4]
        cell.syozoku!.text = self.result[indexPath.row][5]
        cell.kinmu!.text = self.result[indexPath.row][6]
        cell.mail!.text = self.result[indexPath.row][2]
        return cell
    }
    
    //セルを選択
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("セルを選択 #\(indexPath.row)")
        //チェックを反転
        self.checkArray[indexPath.row] = !self.checkArray[indexPath.row]
        //状態を即刻反映するためリロードして再描画
        table.reloadData()
    }
}
