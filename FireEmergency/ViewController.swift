//
//  ViewController.swift
//  FireEmergency
//
//  Created by 中道忠和 on 2016/09/11.
//  Copyright © 2016年 tadakazu nakamichi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    //メイン画面
    let lblData         = UILabel(frame: CGRect.zero)
    let btnSelectAll    = UIButton(frame: CGRect.zero)
    let lblSearch1      = UILabel(frame: CGRect.zero)
    let lblSearch2      = UILabel(frame: CGRect.zero)
    let lblKubun        = UILabel(frame: CGRect.zero)
    let txtKubun        = UITextField(frame: CGRect.zero)
    let picKubun        = UIPickerView(frame: CGRect.zero)
    let kubunArray: NSArray = ["すべて","幼","小","中","高"]
    let lblSyozoku0     = UILabel(frame: CGRect.zero)
    let txtSyozoku0     = UITextField(frame: CGRect.zero)
    let picSyozoku0     = UIPickerView(frame: CGRect.zero)
    let syozoku0Array: NSArray = ["すべて","1B","2B","3B","4B"]
    let lblSyozoku      = UILabel(frame: CGRect.zero)
    let txtSyozoku      = UITextField(frame: CGRect.zero)
    let picSyozoku      = UIPickerView(frame: CGRect.zero)
    let syozokuArray: NSArray = ["すべて","北区","都島区","福島区","此花区","中央区","西区","港区","大正区","天王寺区","浪速区","西淀川区","淀川区","東淀川区","東成区","生野区","旭区","城東区","鶴見区","住之江区","阿倍野区","住吉区","東住吉区","平野区","西成区"]
    let lblMail         = UILabel(frame: CGRect.zero)
    let txtMail         = UITextField(frame: CGRect.zero)
    let picMail         = UIPickerView(frame: CGRect.zero)
    let mailArray: NSArray = ["総務課","教育活動支援担当","初等・中学校教育担当","高等学校教育担当"]
    let btnSearch       = UIButton(frame: CGRect.zero)
    let btnCancel       = UIButton(frame: CGRect.zero)
    //情報ボタン類
    let pad21            = UIView(frame: CGRect.zero) //ボタンの間にはさむ見えないpaddingがわり
    let pad22            = UIView(frame: CGRect.zero)
    let pad23            = UIView(frame: CGRect.zero)
    let pad31            = UIView(frame: CGRect.zero) //ボタンの間にはさむ見えないpaddingがわり
    let pad32            = UIView(frame: CGRect.zero)
    let pad33            = UIView(frame: CGRect.zero)
    //別クラスのインスタンス保持用変数
    fileprivate var mViewController: ViewController!
    fileprivate var mInfoDialog: InfoDialog!
    fileprivate var mBousainetDialog: BousainetDialog!
    fileprivate var mContactLoadDialog2: ContactLoadDialog2!
    fileprivate var mContactViewContoller: ContactViewController!
    //所属(大分類)のインデックス保存用
    fileprivate var syozoku0Index : Int = 0
    //メール保存用宛先保存用
    let userDefaults = UserDefaults.standard
    //SQLite用
    internal var mDBHelper: DBHelper!
    //ContactUpdateSelectDialogから送られてくる各テキストフィールドに放り込むデータ保存用
    fileprivate var mSelected: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //DB生成
        mDBHelper = DBHelper()
        mDBHelper.createTable()
        
        //初回起動判定
        if userDefaults.bool(forKey: "firstLaunch"){
            
            //メール保存宛先が空になるのを防ぐためとりあえず総務課を設定
            userDefaults.set("総務課", forKey: "mailTo")
            
            /*
            //DBダミーデータ生成
            mDBHelper.insert("大阪　太郎",tel: "09066080765",mail: "tadakazu1972@gmail.com",kubun: "４号招集",syozoku0: "消防局",syozoku: "警防課",kinmu: "日勤")
            mDBHelper.insert("難波　二郎",tel: "07077777777",mail: "ta-nakamichi@city.osaka.lg.jp",kubun: "３号招集",syozoku0: "北消防署",syozoku: "与力",kinmu: "１部")*/
            
            //２回目以降ではfalseに
            userDefaults.set(false, forKey: "firstLaunch")
        }
        
        //背景色
        self.view.backgroundColor = UIColor(red:1.0, green:1.0, blue:1.0, alpha:1.0)
        //連絡網ラベル
        lblData.text = "大阪市学校園　災害時連絡網"
        lblData.adjustsFontSizeToFitWidth = true
        lblData.textColor = UIColor.black
        lblData.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        lblData.textAlignment = NSTextAlignment.center
        lblData.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(lblData)
        //全部選択ボタン
        btnSelectAll.backgroundColor = UIColor.blue
        btnSelectAll.layer.masksToBounds = true
        btnSelectAll.setTitle("データ全件一覧表示", for: UIControl.State())
        btnSelectAll.setTitleColor(UIColor.white, for: UIControl.State())
        btnSelectAll.setTitleColor(UIColor.red, for: UIControl.State.highlighted)
        btnSelectAll.layer.cornerRadius = 8.0
        btnSelectAll.addTarget(self, action: #selector(self.onClickbtnSelectAll(_:)), for: .touchUpInside)
        btnSelectAll.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(btnSelectAll)
        //グループ検索ラベル
        lblSearch1.text = "■グループ検索"
        lblSearch1.adjustsFontSizeToFitWidth = true
        lblSearch1.textAlignment = NSTextAlignment.left
        lblSearch1.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(lblSearch1)
        //グループ検索の説明文ラベル
        lblSearch2.text = "以下の条件を設定し「検索」を押してください"
        lblSearch2.adjustsFontSizeToFitWidth = true
        lblSearch2.textAlignment = NSTextAlignment.left
        lblSearch2.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(lblSearch2)
        
        //pickerViewとともにポップアップするツールバーとボタンの設定
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 35))
        let doneItem = UIBarButtonItem(title:"選択", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.selectRow))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil) //小ワザ。上の選択ボタンを右寄せにするためのダミースペース
        toolbar.setItems([flexibleSpace, doneItem], animated: true)
        
        //校種ラベル
        lblKubun.text = "・校種"
        lblKubun.adjustsFontSizeToFitWidth = true
        lblKubun.textAlignment = NSTextAlignment.left
        lblKubun.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(lblKubun)
        //校種テキストフィールド
        txtKubun.borderStyle = UITextField.BorderStyle.bezel
        txtKubun.text = kubunArray[0] as? String
        txtKubun.inputView = picKubun //これでテキストフィールドとピッカービューを紐付け
        txtKubun.inputAccessoryView = toolbar //上で設定したポップアップと紐付け
        txtKubun.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(txtKubun)
        //校種PickerView
        picKubun.delegate = self
        picKubun.dataSource = self
        picKubun.translatesAutoresizingMaskIntoConstraints = false
        picKubun.tag = 1
        picKubun.selectRow(0, inComponent:0, animated:false)
        
        //ブロックラベル
        lblSyozoku0.text = "・ブロック"
        lblSyozoku0.adjustsFontSizeToFitWidth = true
        lblSyozoku0.textAlignment = NSTextAlignment.left
        lblSyozoku0.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(lblSyozoku0)
        //ブロックテキストフィールド
        txtSyozoku0.borderStyle = UITextField.BorderStyle.bezel
        txtSyozoku0.text = syozoku0Array[0] as? String
        txtSyozoku0.inputView = picSyozoku0
        txtSyozoku0.inputAccessoryView = toolbar
        txtSyozoku0.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(txtSyozoku0)
        //ブロックPickerView
        picSyozoku0.delegate = self
        picSyozoku0.dataSource = self
        picSyozoku0.translatesAutoresizingMaskIntoConstraints = false
        picSyozoku0.tag = 2
        picSyozoku0.selectRow(0, inComponent:0, animated:false) //呼び出したrow値でピッカー初期化
        
        //区名ラベル
        lblSyozoku.text = "・区名"
        lblSyozoku.adjustsFontSizeToFitWidth = true
        lblSyozoku.textAlignment = NSTextAlignment.left
        lblSyozoku.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(lblSyozoku)
        //区名テキストフィールド
        txtSyozoku.borderStyle = UITextField.BorderStyle.bezel
        txtSyozoku.text = syozokuArray[0] as? String
        txtSyozoku.inputView = picSyozoku
        txtSyozoku.inputAccessoryView = toolbar
        txtSyozoku.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(txtSyozoku)
        //区名PickerView
        picSyozoku.delegate = self
        picSyozoku.dataSource = self
        picSyozoku.translatesAutoresizingMaskIntoConstraints = false
        picSyozoku.tag = 3
        picSyozoku.selectRow(0, inComponent:0, animated:false)
        
        //メール宛先ラベル
        lblMail.text = "・メール保存宛先"
        lblMail.adjustsFontSizeToFitWidth = true
        lblMail.textAlignment = NSTextAlignment.left
        lblMail.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(lblMail)
        //メール宛先ラベルテキストフィールド
        txtMail.borderStyle = UITextField.BorderStyle.bezel
        txtMail.text = mailArray[0] as? String
        txtMail.inputView = picMail
        txtMail.inputAccessoryView = toolbar
        txtMail.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(txtMail)
        //メール宛先PickerView
        picMail.delegate = self
        picMail.dataSource = self
        picMail.translatesAutoresizingMaskIntoConstraints = false
        picMail.tag = 4
        picMail.selectRow(0, inComponent:0, animated:false)
        
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
        
        //データ操作ボタン
        btnCancel.backgroundColor = UIColor.blue
        btnCancel.layer.masksToBounds = true
        btnCancel.setTitle("データ操作", for: UIControl.State())
        btnCancel.setTitleColor(UIColor.white, for: UIControl.State())
        btnCancel.setTitleColor(UIColor.black, for: UIControl.State.highlighted)
        btnCancel.layer.cornerRadius = 8.0
        btnCancel.addTarget(self, action: #selector(self.onClickbtnCancel(_:)), for: .touchUpInside)
        btnCancel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(btnCancel)
        //検索ボタン
        btnSearch.backgroundColor = UIColor.orange
        btnSearch.layer.masksToBounds = true
        btnSearch.setTitle("検索", for: UIControl.State())
        btnSearch.setTitleColor(UIColor.white, for: UIControl.State())
        btnSearch.setTitleColor(UIColor.black, for: UIControl.State.highlighted)
        btnSearch.layer.cornerRadius = 8.0
        btnSearch.addTarget(self, action: #selector(self.onClickbtnSearch(_:)), for: .touchUpInside)
        btnSearch.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(btnSearch)
        
        //ボタン押したら表示するDialog生成
        mInfoDialog = InfoDialog(parentView: self) //このViewControllerを渡してあげる
        mBousainetDialog = BousainetDialog(parentView: self)
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
            //新規データ入力ラベル
            Constraint(lblData, .top, to:self.view, .top, constant:28),
            Constraint(lblData, .centerX, to:self.view, .centerX, constant:0),
            Constraint(lblData, .width, to:self.view, .width, constant:0)
            ])
        self.view.addConstraints([
            //全件一覧表示ボタン
            Constraint(btnSelectAll, .top, to:lblData, .bottom, constant:24),
            Constraint(btnSelectAll, .leading, to:self.view, .leading, constant:16),
            Constraint(btnSelectAll, .trailing, to:self.view, .trailing, constant:-16)
            ])
        self.view.addConstraints([
            //グループ検索ラベル
            Constraint(lblSearch1, .top, to:btnSelectAll, .bottom, constant:36),
            Constraint(lblSearch1, .leading, to:self.view, .leading, constant:16),
            Constraint(lblSearch1, .trailing, to:self.view, .trailing, constant:-16)
            ])
        self.view.addConstraints([
            //グループ検索の説明ラベル
            Constraint(lblSearch2, .top, to:lblSearch1, .bottom, constant:24),
            Constraint(lblSearch2, .leading, to:self.view, .leading, constant:16),
            Constraint(lblSearch2, .trailing, to:self.view, .trailing, constant:-16)
            ])
        self.view.addConstraints([
            //校種ラベル
            Constraint(lblKubun, .top, to:lblSearch2, .bottom, constant:24),
            Constraint(lblKubun, .leading, to:self.view, .leading, constant:16),
            Constraint(lblKubun, .width, to:self.view, .width, constant:0, multiplier:0.8)
            ])
        self.view.addConstraints([
            //校種テキストフィールド
            Constraint(txtKubun, .top, to:lblSearch2, .bottom, constant:24),
            Constraint(txtKubun, .leading, to:self.view, .centerX, constant:0),
            Constraint(txtKubun, .trailing, to:self.view, .trailing, constant:-16)
            ])
        self.view.addConstraints([
            //ブロックラベル
            Constraint(lblSyozoku0, .top, to:lblKubun, .bottom, constant:24),
            Constraint(lblSyozoku0, .leading, to:self.view, .leading, constant:16),
            Constraint(lblSyozoku0, .width, to:self.view, .width, constant:0, multiplier:0.8)
            ])
        self.view.addConstraints([
            //ブロックテキストフィールド
            Constraint(txtSyozoku0, .top, to:lblKubun, .bottom, constant:24),
            Constraint(txtSyozoku0, .leading, to:self.view, .centerX, constant:0),
            Constraint(txtSyozoku0, .trailing, to:self.view, .trailing, constant:-16)
            ])
        self.view.addConstraints([
            //区名ラベル
            Constraint(lblSyozoku, .top, to:lblSyozoku0, .bottom, constant:24),
            Constraint(lblSyozoku, .leading, to:self.view, .leading, constant:16),
            Constraint(lblSyozoku, .width, to:self.view, .width, constant:0, multiplier:0.8)
            ])
        self.view.addConstraints([
            //区名テキストフィールド
            Constraint(txtSyozoku, .top, to:lblSyozoku0, .bottom, constant:24),
            Constraint(txtSyozoku, .leading, to:self.view, .centerX, constant:0),
            Constraint(txtSyozoku, .trailing, to:self.view, .trailing, constant:-16)
            ])
        self.view.addConstraints([
            //メール保存宛先ラベル
            Constraint(lblMail, .top, to:lblSyozoku, .bottom, constant:24),
            Constraint(lblMail, .leading, to:self.view, .leading, constant:16),
            Constraint(lblMail, .width, to:self.view, .width, constant:0, multiplier:0.8)
            ])
        self.view.addConstraints([
            //メール保存宛先テキストフィールド
            Constraint(txtMail, .top, to:lblSyozoku, .bottom, constant:24),
            Constraint(txtMail, .leading, to:self.view, .centerX, constant:0),
            Constraint(txtMail, .trailing, to:self.view, .trailing, constant:-16)
            ])
        self.view.addConstraints([
            //データ操作ボタン
            Constraint(btnCancel, .bottom, to:self.view, .bottom, constant:-10),
            Constraint(btnCancel, .leading, to:self.view, .leading, constant:8),
            Constraint(btnCancel, .trailing, to:self.view, .centerX, constant:-8)
            ])
        self.view.addConstraints([
            //検索ボタン
            Constraint(btnSearch, .bottom, to:self.view, .bottom, constant:-10),
            Constraint(btnSearch, .leading, to:self.view, .centerX, constant:8),
            Constraint(btnSearch, .trailing, to:self.view, .trailing, constant:-8),
            ])
    }
    
    //表示例数
    func numberOfComponents(in pickerView: UIPickerView)-> Int{
        return 1
    }
    
    //表示行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int)-> Int{
        //返す行数
        var rowNum: Int = 1
        switch pickerView.tag {
        case 1:
            rowNum = kubunArray.count
            break
        case 2:
            rowNum = syozoku0Array.count
            break
        case 3:
            rowNum = syozokuArray.count
            break
        case 4:
            rowNum = mailArray.count
            break
        default:
            rowNum = kubunArray.count
            break
        }
        
        return rowNum
    }
    
    //表示内容
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int)-> String?{
        //返す列
        var picComponent: String?
        switch pickerView.tag {
        case 1:
            picComponent = kubunArray[row] as? String
            break
        case 2:
            picComponent = syozoku0Array[row] as? String
            break
        case 3:
            picComponent = syozokuArray[row] as? String
            break
        case 4:
            picComponent = mailArray[row] as? String
            break
        default:
            picComponent = kubunArray[row] as? String
            break
        }
        
        return picComponent
    }
    
    //選択時
    func pickerView(_ pickerView: UIPickerView, didSelectRow row:Int, inComponent component:Int) {
        print("列:\(row)")
        switch pickerView.tag {
        case 1:
            txtKubun.text = kubunArray[row] as? String
            break
        case 2:
            txtSyozoku0.text = syozoku0Array[row] as? String
            break
        case 3:
            txtSyozoku.text = syozokuArray[row] as? String
            break
        case 4:
            txtMail.text = mailArray[row] as? String
            //userDefaultsにも保存
            userDefaults.set(txtMail.text, forKey: "mailTo")
            break
        default:
            break
        }
    }
    
    //ツールバーで選択ボタンを押した時
    @objc func selectRow(){
        txtKubun.endEditing(true) //閉じるアクション
        txtSyozoku0.endEditing(true)
        txtSyozoku.endEditing(true)
        txtMail.endEditing(true)
    }
    
    //全件一覧表示ボタンクリック
    @objc func onClickbtnSelectAll(_ sender : UIButton){
        mDBHelper.selectAll()
        mContactLoadDialog2 = ContactLoadDialog2(parentView: self, resultFrom: mDBHelper.resultArray)
        mContactLoadDialog2.showResult()
    }
    
    //検索ボタンクリック
    @objc func onClickbtnSearch(_ sender : UIButton){
        //DBにつないでselect文実行
        mDBHelper.select(txtKubun.text!, syozoku0: txtSyozoku0.text!, syozoku: txtSyozoku.text!, kinmu: "すべて")
        mContactLoadDialog2 = ContactLoadDialog2(parentView: self, resultFrom: mDBHelper.resultArray)
        mContactLoadDialog2.showResult()
    }
    
    //連絡網データ操作ボタンクリック
    @objc func onClickbtnCancel(_ sender : UIButton){
        let data:ContactViewController = ContactViewController()
        let nav = UINavigationController(rootViewController: data)
        nav.setNavigationBarHidden(true, animated: false) //これをいれないとNavigationBarが表示されてうざい
        self.present(nav, animated: true, completion: nil)
    }
    
    //いつものん
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

