//
//  Guide22Dialog.swift
//  FireEmergency
//
//  Created by 中道忠和 on 2017/03/20.
//  Copyright © 2017年 tadakazu nakamichi. All rights reserved.
//

import UIKit

class Guide22Dialog {
    //ボタン押したら出るUIWindow
    fileprivate var parent: UIViewController!
    fileprivate var win1: UIWindow!
    fileprivate var scroll: UIScrollView!
    fileprivate var text0: UITextView!
    //fileprivate var image1: UIImageView!
    fileprivate var text1: UITextView!
    fileprivate var image2: UIImageView!
    fileprivate var text2: UITextView!
    fileprivate var image3: UIImageView!
    fileprivate var text3: UITextView!
    fileprivate var image4: UIImageView!
    fileprivate var text4: UITextView!
    fileprivate var image5: UIImageView!
    fileprivate var text5: UITextView!
    fileprivate var image6: UIImageView!
    fileprivate var text6: UITextView!
    fileprivate var image7: UIImageView!
    fileprivate var text7: UITextView!
    fileprivate var image8: UIImageView!
    fileprivate var text8: UITextView!
    fileprivate var image9: UIImageView!
    fileprivate var text9: UITextView!
    fileprivate var image10: UIImageView!
    fileprivate var text10: UITextView!
    fileprivate var image11: UIImageView!
    fileprivate var text11: UITextView!
    fileprivate var image12: UIImageView!
    fileprivate var text12: UITextView!
    fileprivate var btnClose: UIButton!
    
    //コンストラクタ
    init(parentView: UIViewController){
        parent = parentView
        win1 = UIWindow()
        scroll = UIScrollView()
        text0 = UITextView()
        //image1 = UIImageView()
        text1 = UITextView()
        image2 = UIImageView()
        text2 = UITextView()
        image3 = UIImageView()
        text3 = UITextView()
        image4 = UIImageView()
        text4 = UITextView()
        image5 = UIImageView()
        text5 = UITextView()
        image6 = UIImageView()
        text6 = UITextView()
        image7 = UIImageView()
        text7 = UITextView()
        image8 = UIImageView()
        text8 = UITextView()
        image9 = UIImageView()
        text9 = UITextView()
        image10 = UIImageView()
        text10 = UITextView()
        image11 = UIImageView()
        text11 = UITextView()
        image12 = UIImageView()
        text12 = UITextView()
        btnClose = UIButton()
    }
    
    //デコンストラクタ
    deinit{
        parent = nil
        win1 = nil
        scroll = nil
        text0 = nil
        //image1 = nil
        text1 = nil
        image2 = nil
        text2 = nil
        image3 = nil
        text3 = nil
        image4 = nil
        text4 = nil
        image5 = nil
        text5 = nil
        image6 = nil
        text6 = nil
        image7 = nil
        text7 = nil
        image8 = nil
        text8 = nil
        image9 = nil
        text9 = nil
        image10 = nil
        text10 = nil
        image11 = nil
        text11 = nil
        image12 = nil
        text12 = nil
        btnClose = nil
    }
    
    //表示
    func showInfo(){
        //元の画面を暗く
        parent.view.alpha = 0.3
        //初期設定
        //Win1
        win1.backgroundColor = UIColor.white
        win1.frame = CGRect(x: 80,y: 80,width: parent.view.frame.width-20,height: parent.view.frame.height-50)
        win1.layer.position = CGPoint(x: parent.view.frame.width/2, y: parent.view.frame.height/2)
        win1.alpha = 1.0
        win1.layer.cornerRadius = 10
        //KeyWindowにする
        win1.makeKey()
        //表示
        self.win1.makeKeyAndVisible()
        
        //scroll生成
        scroll.frame = CGRect(x: 0,y: 0,width: parent.view.frame.width-20,height: parent.view.frame.height-50)
        scroll.contentSize = CGSize(width: 300,height: 5500)
        self.win1.addSubview(scroll)
        
        //TextView0生成
        text0.frame = CGRect(x: 0,y: 0, width: 300, height: 30)
        text0.backgroundColor = UIColor.clear
        text0.font = UIFont.systemFont(ofSize: CGFloat(16))
        text0.textColor = UIColor.black
        text0.textAlignment = NSTextAlignment.left
        text0.isEditable = false
        text0.isScrollEnabled = true
        text0.text="災害連絡網データ作成(CSVファイル読込)"
        scroll.addSubview(text0)
        
        //TextView1生成
        text1.frame = CGRect(x: 0,y: 40, width: parent.view.frame.width-20, height: 400)
        text1.backgroundColor = UIColor.clear
        text1.font = UIFont.systemFont(ofSize: CGFloat(16))
        text1.textColor = UIColor.black
        text1.textAlignment = NSTextAlignment.left
        text1.isEditable = false
        text1.isScrollEnabled = true
        text1.text="①エクセルデータの作成\n氏名、電話番号、メールアドレス、非常招集区分、担当、グループ、参集場所を入力してください。\n\n※非常招集区分は「数字のみ」を必ず【半角】で入力してください。\n(表示は「4号」と表示されますが、データには「号」を含めないでください。)\n\n※参集場所が区役所の場合は「区役所」を省略しないでください。\n○ 旭区役所　　X 旭\n\n※改めてCSVファイルを読み込ませたい時は、一度アプリを削除して、再度アプリをインストールしてから読み込ませてください。(データは上書きされず、二重に追加されてしまいます。)"
        scroll.addSubview(text1)
        
        //TextView2生成
        text2.frame = CGRect(x: 0,y: 433, width: parent.view.frame.width-20, height: 100)
        text2.backgroundColor = UIColor.clear
        text2.font = UIFont.systemFont(ofSize: CGFloat(16))
        text2.textColor = UIColor.black
        text2.textAlignment = NSTextAlignment.left
        text2.isEditable = false
        text2.isScrollEnabled = true
        text2.text="②エクセルデータの保存\n作成したデータに名前を付けて保存します。保存にあたりファイルの種類を「CSV(カンマ区切り)」とします。"
        scroll.addSubview(text2)
        
        //image2生成
        let img2 = UIImage(named: "guide222.png")
        image2.image = img2
        image2.frame = CGRect(x: (parent.view.frame.width-320)/2, y: 543, width: 300, height: 376)
        scroll.addSubview(image2)
        
        //TextView3生成
        text3.frame = CGRect(x: 0,y: 949, width: parent.view.frame.width-20, height: 132)
        text3.backgroundColor = UIColor.clear
        text3.font = UIFont.systemFont(ofSize: CGFloat(16))
        text3.textColor = UIColor.black
        text3.textAlignment = NSTextAlignment.left
        text3.isEditable = false
        text3.isScrollEnabled = true
        text3.text="③文字コードの変更\nWindowsアクセサリのメモ帳を起動し、先ほどCSV形式で保存したファイルを読み込みます。読み込む際、「テキスト文書(*.txt)」から「すべてのファイル」に切り替えてファイルを表示させます。"
        scroll.addSubview(text3)
        
        //image3生成
        let img3 = UIImage(named: "guide223.png")
        image3.image = img3
        image3.frame = CGRect(x: (parent.view.frame.width-320)/2, y: 1077, width: 300, height: 210)
        scroll.addSubview(image3)
        
        //TextView4生成
        text4.frame = CGRect(x: 0, y: 1307, width: parent.view.frame.width-20, height: 158)
        text4.backgroundColor = UIColor.clear
        text4.font = UIFont.systemFont(ofSize: CGFloat(16))
        text4.textColor = UIColor.black
        text4.textAlignment = NSTextAlignment.left
        text4.isEditable = false
        text4.isScrollEnabled = true
        text4.text="④メモ帳で表示した連絡網データの保存\n連絡網データを表示し「氏名、電話番号、メールアドレス、非常招集区分、勤務場所(大分類)、勤務場所(小分類)、勤務区分」が入力されているのを確認します。\n確認後、文字コードを「UTF-8」に変更し名前を付けて保存します。"
        scroll.addSubview(text4)
        
        //image4生成
        let img4 = UIImage(named: "guide224.png")
        image4.image = img4
        image4.frame = CGRect(x: (parent.view.frame.width-320)/2, y: 1473, width: 300, height: 366)
        scroll.addSubview(image4)
        
        //TextView5生成
        text5.frame = CGRect(x: 0, y: 1853, width: parent.view.frame.width-20, height: 100)
        text5.backgroundColor = UIColor.clear
        text5.font = UIFont.systemFont(ofSize: CGFloat(16))
        text5.textColor = UIColor.black
        text5.textAlignment = NSTextAlignment.left
        text5.isEditable = false
        text5.isScrollEnabled = true
        text5.text="⑤作成したデータの送信\n④で保存したデータを個人所有のスマートフォンにメール送信します。\niPhone標準の「メール」で受信できるメールアドレスに送信してください。"
        scroll.addSubview(text5)
        
        //image5生成
        let img5 = UIImage(named: "guide225.png")
        image5.image = img5
        image5.frame = CGRect(x: (parent.view.frame.width-320)/2, y: 1963, width: 300, height: 85)
        scroll.addSubview(image5)
        
        //TextView6生成
        text6.frame = CGRect(x: 0, y: 2068, width: parent.view.frame.width-20, height: 80)
        text6.backgroundColor = UIColor.clear
        text6.font = UIFont.systemFont(ofSize: CGFloat(16))
        text6.textColor = UIColor.black
        text6.textAlignment = NSTextAlignment.left
        text6.isEditable = false
        text6.isScrollEnabled = true
        text6.text="⑥メールの受信\n「メール」を起動してiPhoneに送信したメールを開きます。"
        scroll.addSubview(text6)
        
        //image6生成
        let img6 = UIImage(named: "guide226.png")
        image6.image = img6
        image6.frame = CGRect(x: (parent.view.frame.width-320)/2, y: 2148, width: 300, height: 426)
        scroll.addSubview(image6)
        
        //image7生成
        let img7 = UIImage(named: "guide227.png")
        image7.image = img7
        image7.frame = CGRect(x: (parent.view.frame.width-320)/2, y: 2594, width: 300, height: 264)
        scroll.addSubview(image7)
        
        //TextView7生成
        text7.frame = CGRect(x: 0, y: 2884, width: parent.view.frame.width-20, height: 40)
        text7.backgroundColor = UIColor.clear
        text7.font = UIFont.systemFont(ofSize: CGFloat(16))
        text7.textColor = UIColor.black
        text7.textAlignment = NSTextAlignment.left
        text7.isEditable = false
        text7.isScrollEnabled = true
        text7.text="⑦添付ファイルを１秒以上長押します。"
        scroll.addSubview(text7)
        
        //image8生成
        let img8 = UIImage(named: "guide228.png")
        image8.image = img8
        image8.frame = CGRect(x: (parent.view.frame.width-320)/2, y: 2924, width: 300, height: 300)
        scroll.addSubview(image8)
        
        //TextView8生成
        text8.frame = CGRect(x: 0, y: 3244, width: parent.view.frame.width-20, height: 100)
        text8.backgroundColor = UIColor.clear
        text8.font = UIFont.systemFont(ofSize: CGFloat(16))
        text8.textColor = UIColor.black
        text8.textAlignment = NSTextAlignment.left
        text8.isEditable = false
        text8.isScrollEnabled = true
        text8.text="⑧中段に出てくるアイコン一覧から「非常召集にコピー」を選択しタップします。\n※アイコンが見えない場合は横にスワイプしてください。"
        scroll.addSubview(text8)
        
        //image9生成
        let img9 = UIImage(named: "guide229.png")
        image9.image = img9
        image9.frame = CGRect(x: (parent.view.frame.width-320)/2, y: 3350, width: 300, height: 426)
        scroll.addSubview(image9)
        
        //TextView9生成
        text9.frame = CGRect(x: 0, y: 3796, width: parent.view.frame.width-20, height: 100)
        text9.backgroundColor = UIColor.clear
        text9.font = UIFont.systemFont(ofSize: CGFloat(16))
        text9.textColor = UIColor.black
        text9.textAlignment = NSTextAlignment.left
        text9.isEditable = false
        text9.isScrollEnabled = true
        text9.text="⑨「災害時連絡網」アプリに切り替わりますので「データ操作」→「連絡網データ操作」に移動し、「CSVファイル読込」をタップしてください。"
        scroll.addSubview(text9)
        
        //image10生成
        let img10 = UIImage(named: "guide2210.png")
        image10.image = img10
        image10.frame = CGRect(x: (parent.view.frame.width-320)/2, y: 3900, width: 300, height: 426)
        scroll.addSubview(image10)
        
        //TextView10生成
        text10.frame = CGRect(x: 0, y: 4346, width: parent.view.frame.width-20, height: 80)
        text10.backgroundColor = UIColor.clear
        text10.font = UIFont.systemFont(ofSize: CGFloat(16))
        text10.textColor = UIColor.black
        text10.textAlignment = NSTextAlignment.left
        text10.isEditable = false
        text10.isScrollEnabled = true
        text10.text="⑨添付ファイルからコピーしたCSVファイルの中身が表示されます。確認した後、「読込」をタップしてください。"
        scroll.addSubview(text10)
        
        //image11生成
        let img11 = UIImage(named: "guide2211.png")
        image11.image = img11
        image11.frame = CGRect(x: (parent.view.frame.width-320)/2, y: 4436, width: 300, height: 426)
        scroll.addSubview(image11)
        
        //TextView11生成
        text11.frame = CGRect(x: 0, y: 4882, width: parent.view.frame.width-20, height: 40)
        text11.backgroundColor = UIColor.clear
        text11.font = UIFont.systemFont(ofSize: CGFloat(16))
        text11.textColor = UIColor.black
        text11.textAlignment = NSTextAlignment.left
        text11.isEditable = false
        text11.isScrollEnabled = true
        text11.text="⑩CSVファイルの読込完了です。"
        scroll.addSubview(text11)
        
        //image12生成
        let img12 = UIImage(named: "guide2212.png")
        image12.image = img12
        image12.frame = CGRect(x: (parent.view.frame.width-320)/2, y: 4922, width: 300, height: 426)
        scroll.addSubview(image12)
        
        //TextView12生成
        text12.frame = CGRect(x: 0, y: 5368, width: parent.view.frame.width-20, height: 100)
        text12.backgroundColor = UIColor.clear
        text12.font = UIFont.systemFont(ofSize: CGFloat(16))
        text12.textColor = UIColor.black
        text12.textAlignment = NSTextAlignment.left
        text12.isEditable = false
        text12.isScrollEnabled = true
        text12.text="※連絡網データを「災害時連絡網アプリ」に取り込んだ後は、メール（添付ファイル）を削除してください。"
        scroll.addSubview(text12)
        
        //閉じるボタン生成
        btnClose.frame = CGRect(x: 0,y: 0,width: 100,height: 30)
        btnClose.backgroundColor = UIColor.orange
        btnClose.setTitle("閉じる", for: UIControlState())
        btnClose.setTitleColor(UIColor.white, for: UIControlState())
        btnClose.layer.masksToBounds = true
        btnClose.layer.cornerRadius = 10.0
        btnClose.layer.position = CGPoint(x: self.win1.frame.width/2, y: self.win1.frame.height-20)
        btnClose.addTarget(self, action: #selector(self.onClickClose(_:)), for: .touchUpInside)
        self.win1.addSubview(btnClose)
    }
    
    //閉じる
    @objc func onClickClose(_ sender: UIButton){
        win1.isHidden = true      //win1隠す
        text1.text = ""         //使い回しするのでテキスト内容クリア
        parent.view.alpha = 1.0 //元の画面明るく
    }
}
