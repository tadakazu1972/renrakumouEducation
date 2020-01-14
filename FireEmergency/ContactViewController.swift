//
//  ContactViewController.swift
//  FireEmergency
//
//  Created by 中道忠和 on 2017/01/21.
//  Copyright © 2017年 tadakazu nakamichi. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {
    //メイン画面
    let btnData         = UIButton(frame: CGRect.zero)
    let btnEarthquake   = UIButton(frame: CGRect.zero)
    let pad1            = UIView(frame: CGRect.zero) //ボタンの間にはさむ見えないpaddingがわり
    let pad2            = UIView(frame: CGRect.zero)
    let pad3            = UIView(frame: CGRect.zero)
    let pad4            = UIView(frame: CGRect.zero)
    let lblContact      = UILabel(frame: CGRect.zero)
    let btnContact1     = UIButton(frame: CGRect.zero)
    let btnContact2     = UIButton(frame: CGRect.zero)
    let btnContact3     = UIButton(frame: CGRect.zero)
    let btnContact4     = UIButton(frame: CGRect.zero)
    let btnContact5     = UIButton(frame: CGRect.zero)
    let btnGuide        = UIButton(frame: CGRect.zero)
    let padY1           = UIView(frame: CGRect.zero) //ボタンの間にはさむ見えないpaddingがわり
    let padY2           = UIView(frame: CGRect.zero)
    let padY3           = UIView(frame: CGRect.zero)
    let padY4           = UIView(frame: CGRect.zero)
    let padY5           = UIView(frame: CGRect.zero)
    let padY6           = UIView(frame: CGRect.zero)
    let btnEarthquakeEarthquake = UIButton(frame: CGRect.zero)
    let btnEarthquakeBlackout   = UIButton(frame: CGRect.zero)
    let btnEarthquakeRoad       = UIButton(frame: CGRect.zero)
    let btnEarthquakeTel        = UIButton(frame: CGRect.zero)
    let btnEarthquakeCaution    = UIButton(frame: CGRect.zero)
    let btnEarthquakeBousaiNet  = UIButton(frame: CGRect.zero)
    let pad21            = UIView(frame: CGRect.zero) //ボタンの間にはさむ見えないpaddingがわり
    let pad22            = UIView(frame: CGRect.zero)
    let pad23            = UIView(frame: CGRect.zero)
    let pad31            = UIView(frame: CGRect.zero) //ボタンの間にはさむ見えないpaddingがわり
    let pad32            = UIView(frame: CGRect.zero)
    let pad33            = UIView(frame: CGRect.zero)
    //別クラスのインスタンス保持用変数
    fileprivate var mInfoDialog: InfoDialog!
    fileprivate var mBousainetDialog: BousainetDialog!
    fileprivate var mContactLoadDialog: ContactLoadDialog!
    fileprivate var mContactLoadDialog2: ContactLoadDialog2!
    fileprivate var mContactUpdateSelectDialog: ContactUpdateSelectDialog!
    fileprivate var mContactDeleteDialog: ContactDeleteDialog!
    fileprivate var mContactImportCSVDialog: ContactImportCSVDialog!
    fileprivate var mPassInputDialog: ContactPassInputDialog!
    fileprivate var mGuide22Dialog: Guide22Dialog!
    //データ保存用
    let userDefaults = UserDefaults.standard
    //SQLite用
    internal var mDBHelper: DBHelper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mDBHelper = DBHelper()
        
        //初回起動判定
        if userDefaults.bool(forKey: "firstLaunch"){
            //初回起動時処理 一度も基礎データ入力されないorデータ入力画面でもスピナーをさわらない場合はセットされない=結果でnilが表示される　それを防止
            
            //２回目以降ではfalseに
            userDefaults.set(false, forKey: "firstLaunch")
        }
        
        self.view.backgroundColor = UIColor(red:1.0, green:1.0, blue:1.0, alpha:1.0)
        //Button生成
        //トップへ戻るボタン
        btnData.backgroundColor = UIColor.blue
        btnData.layer.masksToBounds = true
        btnData.setTitle("トップへ戻る", for: UIControl.State())
        btnData.setTitleColor(UIColor.white, for: UIControl.State())
        btnData.setTitleColor(UIColor.black, for: UIControl.State.highlighted)
        btnData.layer.cornerRadius = 8.0
        btnData.tag = 0
        btnData.translatesAutoresizingMaskIntoConstraints = false
        btnData.addTarget(self, action: #selector(self.onClickbtnData(_:)), for: .touchUpInside)
        self.view.addSubview(btnData)
        //pad
        pad1.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(pad1)
        pad2.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(pad2)
        pad3.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(pad3)
        pad4.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(pad4)
        //連絡網データ操作
        lblContact.text = "連絡網データ操作"
        lblContact.textColor = UIColor.black
        lblContact.textAlignment = NSTextAlignment.center
        lblContact.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(lblContact)
        //一覧
        btnContact1.backgroundColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        btnContact1.layer.masksToBounds = true
        btnContact1.setTitle("一覧", for: UIControl.State())
        btnContact1.setTitleColor(UIColor.black, for: UIControl.State())
        btnContact1.setTitleColor(UIColor.red, for: UIControl.State.highlighted)
        btnContact1.tag=5
        btnContact1.translatesAutoresizingMaskIntoConstraints = false
        btnContact1.addTarget(self, action: #selector(self.showSelectContact1(_:)), for: .touchUpInside)
        self.view.addSubview(btnContact1)
        //新規
        btnContact2.backgroundColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        btnContact2.layer.masksToBounds = true
        btnContact2.setTitle("新規", for: UIControl.State())
        btnContact2.setTitleColor(UIColor.black, for: UIControl.State())
        btnContact2.tag=6
        btnContact2.translatesAutoresizingMaskIntoConstraints = false
        btnContact2.addTarget(self, action: #selector(self.showSelectContactNew(_:)), for: .touchUpInside)
        self.view.addSubview(btnContact2)
        //修正
        btnContact3.backgroundColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        btnContact3.layer.masksToBounds = true
        btnContact3.setTitle("修正", for: UIControl.State())
        btnContact3.setTitleColor(UIColor.black, for: UIControl.State())
        btnContact3.tag=7
        btnContact3.translatesAutoresizingMaskIntoConstraints = false
        btnContact3.addTarget(self, action: #selector(self.showSelectContactUpdate(_:)), for: .touchUpInside)
        self.view.addSubview(btnContact3)
        //削除
        btnContact4.backgroundColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        btnContact4.layer.masksToBounds = true
        btnContact4.setTitle("削除", for: UIControl.State())
        btnContact4.setTitleColor(UIColor.black, for: UIControl.State())
        btnContact4.tag=8
        btnContact4.translatesAutoresizingMaskIntoConstraints = false
        btnContact4.addTarget(self, action: #selector(self.showSelectContactDelete(_:)), for: .touchUpInside)
        self.view.addSubview(btnContact4)
        //CSVファイル読込
        btnContact5.backgroundColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        btnContact5.layer.masksToBounds = true
        btnContact5.setTitle("CSVファイル読込", for: UIControl.State())
        btnContact5.setTitleColor(UIColor.black, for: UIControl.State())
        btnContact5.tag=9
        btnContact5.translatesAutoresizingMaskIntoConstraints = false
        btnContact5.addTarget(self, action: #selector(self.showContactImportCSV(_:)), for: .touchUpInside)
        self.view.addSubview(btnContact5)
        //CSVファイル読み込ませ説明書ボタン
        btnGuide.backgroundColor = UIColor.orange
        btnGuide.layer.masksToBounds = true
        btnGuide.setTitle("CSVファイル読み込ませ説明書", for: UIControl.State())
        btnGuide.setTitleColor(UIColor.white, for: UIControl.State())
        btnGuide.setTitleColor(UIColor.black, for: UIControl.State.highlighted)
        btnGuide.layer.cornerRadius = 8.0
        btnGuide.translatesAutoresizingMaskIntoConstraints = false
        btnGuide.addTarget(self, action: #selector(self.showGuide(_:)), for: .touchUpInside)
        self.view.addSubview(btnGuide)
        //垂直方向のpad
        padY1.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(padY1)
        padY2.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(padY2)
        padY3.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(padY3)
        padY4.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(padY4)
        padY5.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(padY5)
        padY6.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(padY6)
        //情報（地震）
        btnEarthquakeEarthquake.backgroundColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        btnEarthquakeEarthquake.layer.masksToBounds = true
        btnEarthquakeEarthquake.setTitle("情報(地震)", for: UIControl.State())
        btnEarthquakeEarthquake.setTitleColor(UIColor.black, for: UIControl.State())
        btnEarthquakeEarthquake.setTitleColor(UIColor.red, for: UIControl.State.highlighted)
        btnEarthquakeEarthquake.tag=10
        btnEarthquakeEarthquake.translatesAutoresizingMaskIntoConstraints = false
        btnEarthquakeEarthquake.addTarget(self, action: #selector(self.showInfoEarthquake(_:)), for: .touchUpInside)
        self.view.addSubview(btnEarthquakeEarthquake)
        //情報（停電）
        btnEarthquakeBlackout.backgroundColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        btnEarthquakeBlackout.layer.masksToBounds = true
        btnEarthquakeBlackout.setTitle("情報(停電)", for: UIControl.State())
        btnEarthquakeBlackout.setTitleColor(UIColor.black, for: UIControl.State())
        btnEarthquakeBlackout.setTitleColor(UIColor.red, for: UIControl.State.highlighted)
        btnEarthquakeBlackout.tag=11
        btnEarthquakeBlackout.translatesAutoresizingMaskIntoConstraints = false
        btnEarthquakeBlackout.addTarget(self, action: #selector(self.showInfoBlackout(_:)), for: .touchUpInside)
        self.view.addSubview(btnEarthquakeBlackout)
        //情報（道路）
        btnEarthquakeRoad.backgroundColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        btnEarthquakeRoad.layer.masksToBounds = true
        btnEarthquakeRoad.setTitle("情報(道路)", for: UIControl.State())
        btnEarthquakeRoad.setTitleColor(UIColor.black, for: UIControl.State())
        btnEarthquakeRoad.setTitleColor(UIColor.red, for: UIControl.State.highlighted)
        btnEarthquakeRoad.tag=12
        btnEarthquakeRoad.translatesAutoresizingMaskIntoConstraints = false
        btnEarthquakeRoad.addTarget(self, action: #selector(self.showInfoRoad(_:)), for: .touchUpInside)
        self.view.addSubview(btnEarthquakeRoad)
        //連絡網
        btnEarthquakeTel.backgroundColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        btnEarthquakeTel.layer.masksToBounds = true
        btnEarthquakeTel.setTitle("情報(天気)", for: UIControl.State())
        btnEarthquakeTel.setTitleColor(UIColor.black, for: UIControl.State())
        btnEarthquakeTel.tag=13
        btnEarthquakeTel.translatesAutoresizingMaskIntoConstraints = false
        btnEarthquakeTel.addTarget(self, action: #selector(self.showContactLoad(_:)), for: .touchUpInside)
        self.view.addSubview(btnEarthquakeTel)
        //留意事項
        btnEarthquakeCaution.backgroundColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        btnEarthquakeCaution.layer.masksToBounds = true
        btnEarthquakeCaution.setTitle("留意事項", for: UIControl.State())
        btnEarthquakeCaution.setTitleColor(UIColor.black, for: UIControl.State())
        btnEarthquakeCaution.setTitleColor(UIColor.red, for: UIControl.State.highlighted)
        btnEarthquakeCaution.tag=14
        btnEarthquakeCaution.translatesAutoresizingMaskIntoConstraints = false
        btnEarthquakeCaution.addTarget(self, action: #selector(self.showInfoCaution(_:)), for: .touchUpInside)
        self.view.addSubview(btnEarthquakeCaution)
        //防災ネット
        btnEarthquakeBousaiNet.backgroundColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        btnEarthquakeBousaiNet.layer.masksToBounds = true
        btnEarthquakeBousaiNet.setTitle("防災ネット", for: UIControl.State())
        btnEarthquakeBousaiNet.setTitleColor(UIColor.black, for: UIControl.State())
        btnEarthquakeBousaiNet.tag=15
        btnEarthquakeBousaiNet.translatesAutoresizingMaskIntoConstraints = false
        btnEarthquakeBousaiNet.addTarget(self, action: #selector(self.showInfoBousainet(_:)), for: .touchUpInside)
        self.view.addSubview(btnEarthquakeBousaiNet)
        //pad
        pad21.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(pad21)
        pad22.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(pad22)
        pad23.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(pad23)
        //pad
        pad31.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(pad31)
        pad32.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(pad32)
        pad33.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(pad33)
        
        //ボタン押したら表示するDialog生成
        mInfoDialog = InfoDialog(parentView: self) //このViewControllerを渡してあげる
        mBousainetDialog = BousainetDialog(parentView: self)
        mPassInputDialog = ContactPassInputDialog(parentView: self)
        mGuide22Dialog = Guide22Dialog(parentView: self)
        
        //passCheckをfalseで初期化
        userDefaults.set(false, forKey: "passCheck")
    }
    
    //制約ひな型
    func Constraint(_ item: AnyObject, _ attr: NSLayoutConstraint.Attribute, to: AnyObject?, _ attrTo: NSLayoutConstraint.Attribute, constant: CGFloat = 0.0, multiplier: CGFloat = 1.0, relate: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = UILayoutPriority.required) -> NSLayoutConstraint {
        let ret = NSLayoutConstraint(
            item:       item,
            attribute:  attr,
            relatedBy:  relate,
            toItem:     to,
            attribute:  attrTo,
            multiplier: multiplier,
            constant:   constant
        )
        ret.priority = priority
        return ret
    }
    
    override func viewDidLayoutSubviews(){
        //制約
        self.view.addConstraints([
            //基礎データ入力ボタン
            Constraint(btnData, .top, to:self.view, .top, constant:20),
            Constraint(btnData, .leading, to:self.view, .leading, constant:8),
            Constraint(btnData, .trailing, to:self.view, .trailingMargin, constant:8)
            ])
        self.view.addConstraints([
            //padY1
            Constraint(padY1, .top, to:btnData, .bottom, constant:0),
            Constraint(padY1, .leading, to:self.view, .leading, constant:0),
            Constraint(padY1, .height, to:self.view, .height, constant:0, multiplier:0.05)
            ])
        self.view.addConstraints([
            //連絡網データ操作ラベル
            Constraint(lblContact, .bottom, to:padY2, .top, constant:8),
            Constraint(lblContact, .centerX, to:self.view, .centerX, constant:0),
            Constraint(lblContact, .width, to:self.view, .width, constant:0, multiplier:0.8)
            ])
        self.view.addConstraints([
            //padY2
            Constraint(padY2, .bottom, to:btnContact1, .top, constant:0),
            Constraint(padY2, .leading, to:self.view, .leading, constant:0),
            Constraint(padY2, .height, to:self.view, .height, constant:0, multiplier:0.03)
            ])
        self.view.addConstraints([
            //一覧ボタン
            Constraint(btnContact1, .bottom, to:padY3, .top, constant:0),
            Constraint(btnContact1, .centerX, to:self.view, .centerX, constant:0),
            Constraint(btnContact1, .width, to:self.view, .width, constant:0, multiplier:0.8)
            ])
        self.view.addConstraints([
            //padY3
            Constraint(padY3, .bottom, to:btnContact2, .top, constant:0),
            Constraint(padY3, .leading, to:self.view, .leading, constant:0),
            Constraint(padY3, .height, to:self.view, .height, constant:0, multiplier:0.03)
            ])
        self.view.addConstraints([
            //新規ボタン
            Constraint(btnContact2, .bottom, to:padY4, .top, constant:0),
            Constraint(btnContact2, .centerX, to:self.view, .centerX, constant:0),
            Constraint(btnContact2, .width, to:self.view, .width, constant:0, multiplier:0.8)
            ])
        self.view.addConstraints([
            //padY4
            Constraint(padY4, .bottom, to:btnContact3, .top, constant:0),
            Constraint(padY4, .leading, to:self.view, .leading, constant:0),
            Constraint(padY4, .height, to:self.view, .height, constant:0, multiplier:0.03)
            ])
        self.view.addConstraints([
            //修正ボタン Y座標の中心
            Constraint(btnContact3, .centerY, to:self.view, .centerY, constant:0),
            Constraint(btnContact3, .centerX, to:self.view, .centerX, constant:0),
            Constraint(btnContact3, .width, to:self.view, .width, constant:0, multiplier:0.8)
            ])
        self.view.addConstraints([
            //padY5
            Constraint(padY5, .top, to:btnContact3, .bottom, constant:0),
            Constraint(padY5, .leading, to:self.view, .leading, constant:0),
            Constraint(padY5, .height, to:self.view, .height, constant:0, multiplier:0.03)
            ])
        self.view.addConstraints([
            //削除ボタン
            Constraint(btnContact4, .top, to:padY5, .bottom, constant:0),
            Constraint(btnContact4, .centerX, to:self.view, .centerX, constant:0),
            Constraint(btnContact4, .width, to:self.view, .width, constant:0, multiplier:0.8)
            ])
        self.view.addConstraints([
            //padY6
            Constraint(padY6, .top, to:btnContact4, .bottom, constant:0),
            Constraint(padY6, .leading, to:self.view, .leading, constant:0),
            Constraint(padY6, .height, to:self.view, .height, constant:0, multiplier:0.03)
            ])
        self.view.addConstraints([
            //CSVファイル読込ボタン
            Constraint(btnContact5, .top, to:padY6, .bottom, constant:0),
            Constraint(btnContact5, .centerX, to:self.view, .centerX, constant:0),
            Constraint(btnContact5, .width, to:self.view, .width, constant:0, multiplier:0.8)
            ])
        self.view.addConstraints([
            //pad21
            Constraint(pad21, .bottom, to:btnEarthquakeTel, .top, constant:-8),
            Constraint(pad21, .leading, to:self.view, .leading, constant:0),
            Constraint(pad21, .width, to:self.view, .width, constant:0, multiplier:0.024)
            ])
        self.view.addConstraints([
            //CSVファイル読み込ませ説明書ボタン
            Constraint(btnGuide, .top, to:btnContact5, .bottom, constant:20),
            Constraint(btnGuide, .leading, to:self.view, .leading, constant:8),
            Constraint(btnGuide, .trailing, to:self.view, .trailingMargin, constant:8)
            ])
        self.view.addConstraints([
            //情報(地震)ボタン
            Constraint(btnEarthquakeEarthquake, .bottom, to:btnEarthquakeTel, .top, constant:-8),
            Constraint(btnEarthquakeEarthquake, .leading, to:pad21, .trailing, constant:0),
            Constraint(btnEarthquakeEarthquake, .width, to:self.view, .width, constant:0, multiplier:0.3)
            ])
        self.view.addConstraints([
            //pad22
            Constraint(pad22, .bottom, to:btnEarthquakeTel, .top, constant:-8),
            Constraint(pad22, .leading, to:btnEarthquakeEarthquake, .trailing, constant:0),
            Constraint(pad22, .width, to:self.view, .width, constant:0, multiplier:0.024)
            ])
        self.view.addConstraints([
            //情報(停電)ボタン
            Constraint(btnEarthquakeBlackout, .bottom, to:btnEarthquakeTel, .top, constant:-8),
            Constraint(btnEarthquakeBlackout, .leading, to:pad22, .trailing, constant:0),
            Constraint(btnEarthquakeBlackout, .width, to:btnEarthquakeEarthquake, .width, constant:0)
            ])
        self.view.addConstraints([
            //pad23
            Constraint(pad23, .bottom, to:btnEarthquakeTel, .top, constant:-8),
            Constraint(pad23, .leading, to:btnEarthquakeBlackout, .trailing, constant:0),
            Constraint(pad23, .width, to:self.view, .width, constant:0, multiplier:0.024)
            ])
        self.view.addConstraints([
            //情報(道路)ボタン
            Constraint(btnEarthquakeRoad, .bottom, to:btnEarthquakeTel, .top ,constant:-8),
            Constraint(btnEarthquakeRoad, .leading, to:pad23, .trailing, constant:0),
            Constraint(btnEarthquakeRoad, .width, to:btnEarthquakeEarthquake, .width, constant:0)
            ])
        self.view.addConstraints([
            //pad31
            Constraint(pad31, .top, to:btnEarthquakeEarthquake, .bottom, constant:8),
            Constraint(pad31, .leading, to:self.view, .leading, constant:0),
            Constraint(pad31, .width, to:self.view, .width, constant:0, multiplier:0.024)
            ])
        self.view.addConstraints([
            //連絡網ボタン
            Constraint(btnEarthquakeTel, .bottom, to:self.view, .bottom, constant:-8),
            Constraint(btnEarthquakeTel, .leading, to:pad31, .trailing, constant:0),
            Constraint(btnEarthquakeTel, .width, to:self.view, .width, constant:0, multiplier:0.3)
            ])
        self.view.addConstraints([
            //pad32
            Constraint(pad32, .bottom, to:self.view, .bottom, constant:-8),
            Constraint(pad32, .leading, to:btnEarthquakeTel, .trailing, constant:0),
            Constraint(pad32, .width, to:self.view, .width, constant:0, multiplier:0.024)
            ])
        self.view.addConstraints([
            //留意事項ボタン
            Constraint(btnEarthquakeCaution, .bottom, to:self.view, .bottom, constant:-8),
            Constraint(btnEarthquakeCaution, .leading, to:pad32, .trailing, constant:0),
            Constraint(btnEarthquakeCaution, .width, to:btnEarthquakeTel, .width, constant:0)
            ])
        self.view.addConstraints([
            //pad33
            Constraint(pad33, .bottom, to:self.view, .bottom, constant:-8),
            Constraint(pad33, .leading, to:btnEarthquakeCaution, .trailing, constant:0),
            Constraint(pad33, .width, to:self.view, .width, constant:0, multiplier:0.024)
            ])
        self.view.addConstraints([
            //防災ネットボタン
            Constraint(btnEarthquakeBousaiNet, .bottom, to:self.view, .bottom ,constant:-8),
            Constraint(btnEarthquakeBousaiNet, .leading, to:pad33, .trailing, constant:0),
            Constraint(btnEarthquakeBousaiNet, .width, to:btnEarthquakeTel, .width, constant:0)
            ])
    }
    
    //一覧
    @objc func showSelectContact1(_ sender: UIButton){
        mDBHelper.selectAll()
        mContactLoadDialog2 = ContactLoadDialog2(parentView: self, resultFrom: mDBHelper.resultArray)
        mContactLoadDialog2.showResult()
    }
    
    //新規
    @objc func showSelectContactNew(_ sender: UIButton){
        let data:ContactNewViewController = ContactNewViewController()
        let nav = UINavigationController(rootViewController: data)
        nav.setNavigationBarHidden(true, animated: false) //これをいれないとNavigationBarが表示されてうざい
        self.present(nav, animated: true, completion: nil)
    }
    
    //修正
    @objc func showSelectContactUpdate(_ sender: UIButton){
        mDBHelper.selectAll2() //_idを含む呼び出す。後でその_idをもって上書きするデータを指定するから。
        mContactUpdateSelectDialog = ContactUpdateSelectDialog(parentView: self, resultFrom: mDBHelper.resultArray)
        mContactUpdateSelectDialog.showResult()
    }
    
    //削除
    @objc func showSelectContactDelete(_ sender: UIButton){
        mDBHelper.selectAll2() //_idを含む2を呼び出し
        mContactDeleteDialog = ContactDeleteDialog(parentView: self, resultFrom: mDBHelper.resultArray)
        mContactDeleteDialog.showResult()
    }
    
    //CSVファイル読込
    @objc func showContactImportCSV(_ sender: UIButton){
        mContactImportCSVDialog = ContactImportCSVDialog(parentView: self)
        mContactImportCSVDialog.showResult()
    }
    
    //CSVファイル読み込ませ説明書　表示
    @objc func showGuide(_ sender: UIButton){
        mGuide22Dialog.showInfo()
    }
    
    //情報(地震)
    @objc func showInfoEarthquake(_ sender: UIButton){
        mInfoDialog.showInfo("earthquake")
    }
    
    //情報（停電）
    @objc func showInfoBlackout(_ sender: UIButton){
        mInfoDialog.showInfo("blackout")
    }
    
    //情報（道路）
    @objc func showInfoRoad(_ sender: UIButton){
        mInfoDialog.showInfo("road")
    }
    
    //情報（天気）
    @objc func showContactLoad(_ sender: UIButton){
        mInfoDialog.showInfo("weather")
    }
    
    //留意事項
    @objc func showInfoCaution(_ sender: UIButton){
        mInfoDialog.showInfo("caution")
    }
    
    //防災ネット
    @objc func showInfoBousainet(_ sender: UIButton){
        mBousainetDialog.showInfo()
    }
    
    //基礎データ入力画面遷移
    @objc func onClickbtnData(_ sender : UIButton){
        let data:ViewController = ViewController()
        let nav = UINavigationController(rootViewController: data)
        nav.setNavigationBarHidden(true, animated: false) //これをいれないとNavigationBarが表示されてうざい
        self.present(nav, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
