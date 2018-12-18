//
//  DBHelper.swift
//  FireEmergency
//
//  Created by 中道忠和 on 2017/02/05.
//  Copyright © 2017年 tadakazu nakamichi. All rights reserved.
//

class DBHelper {
    var db : FMDatabase
    var resultArray: [[String]] //SELECTの結果格納用配列
    
    //コンストラクタ
    init(){
        db = FMDatabase.init()
        resultArray = []
        connectDB()
    }
    
    func connectDB(){
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = paths[0].stringByAppendingPathComponent("myrecord.db")
        db = FMDatabase(path: path)
    }
    
    func createTable(){
        db.open()
        let sql = "CREATE TABLE IF NOT EXISTS records(_id integer primary key autoincrement,name text,tel text,mail text,kubun integer,syozoku0 text,syozoku text,kinmu text);"
        let ret = db.executeUpdate(sql, withArgumentsIn: nil)
        if ret {
            print("テーブル作成　成功")
        } else {
            print("テーブル作成　失敗")
        }
        db.close()
    }
    
    func insert(_ name: String, tel: String, mail: String, kubun: String, syozoku0: String, syozoku: String, kinmu: String){
        let sql = "INSERT INTO records(name, tel, mail, kubun, syozoku0, syozoku, kinmu) VALUES(?, ?, ?, ?, ?, ?, ?);"
        db.open()
        db.executeUpdate(sql, withArgumentsIn: [name, tel, mail, kubun, syozoku0, syozoku, kinmu])
        db.close()
    }
    
    func update(_ name: String, tel: String, mail: String, kubun: String, syozoku0: String, syozoku: String, kinmu: String, _id: String){
        let sql = "UPDATE records SET name = ?, tel = ?, mail = ?, kubun = ?, syozoku0 = ?, syozoku = ?, kinmu = ? WHERE _id = ?;"
        db.open()
        db.executeUpdate(sql, withArgumentsIn: [name, tel, mail, kubun, syozoku0, syozoku, kinmu, _id])
        print("DBの _id =\(_id)をupdateしました")
        db.close()
    }
    
    func delete(_ _id: String){
        let sql = "DELETE FROM records WHERE _id = ?;"
        db.open()
        db.executeUpdate(sql, withArgumentsIn: [_id])
        db.close()        
    }
    
    func selectAll(){
        //前の検索結果が残っているので全削除
        resultArray.removeAll()
        let sql = "SELECT * FROM records ORDER BY _id;"
        db.open()
        let results = db.executeQuery(sql, withArgumentsIn: nil)
        while (results?.next())!{
            let _name: String = results!.string(forColumn: "name")
            let _tel: String = results!.string(forColumn: "tel")
            let _mail: String = results!.string(forColumn: "mail")
            let _kubun: String = results!.string(forColumn: "kubun")
            let _syozoku0: String = results!.string(forColumn: "syozoku0")
            let _syozoku: String = results!.string(forColumn: "syozoku")
            let _kinmu: String = results!.string(forColumn: "kinmu")
            resultArray.append([_name, _tel, _mail, _kubun, _syozoku0, _syozoku, _kinmu])
        }
        db.close()
    }
    
    // _idも取得するバージョン
    func selectAll2(){
        //前の検索結果が残っているので全削除
        resultArray.removeAll()
        let sql = "SELECT * FROM records ORDER BY _id;"
        db.open()
        let results = db.executeQuery(sql, withArgumentsIn: nil)
        while (results?.next())!{
            let _name: String = results!.string(forColumn: "name")
            let _tel: String = results!.string(forColumn: "tel")
            let _mail: String = results!.string(forColumn: "mail")
            let _kubun: String = results!.string(forColumn: "kubun")
            let _syozoku0: String = results!.string(forColumn: "syozoku0")
            let _syozoku: String = results!.string(forColumn: "syozoku")
            let _kinmu: String = results!.string(forColumn: "kinmu")
            let _id: String = results!.string(forColumn: "_id")
            resultArray.append([_name, _tel, _mail, _kubun, _syozoku0, _syozoku, _kinmu, _id])
        }
        db.close()
    }
    
    func select(_ kubun: String, syozoku0: String, syozoku: String, kinmu: String){
        //前の検索結果が残っているので全削除
        resultArray.removeAll()

        //SQL文作成準備
        var kubunSQL : String = "IS NOT NULL"
        if kubun != "すべて" {
            kubunSQL = "='" + kubun + "'"
        }
        var syozoku0SQL : String = "IS NOT NULL"
        if syozoku0 != "すべて" {
            syozoku0SQL = "='" + syozoku0 + "'"
        }
        var syozokuSQL : String = "IS NOT NULL"
        if syozoku != "すべて" {
            syozokuSQL = "='" + syozoku + "'"
        }
        var kinmuSQL : String = "IS NOT NULL"
        if kinmu != "すべて" {
            kinmuSQL = "='" + kinmu + "'"
        }
        let sql = "SELECT * FROM records where kubun " + kubunSQL + " and syozoku0 " + syozoku0SQL + " and syozoku " + syozokuSQL + " and kinmu " + kinmuSQL + " ORDER BY _id;"
        db.open()
        let results = db.executeQuery(sql, withArgumentsIn: nil)
        while (results?.next())!{
            let _name: String = results!.string(forColumn: "name")
            let _tel: String = results!.string(forColumn: "tel")
            let _mail: String = results!.string(forColumn: "mail")
            let _kubun: String = results!.string(forColumn: "kubun")
            let _syozoku0: String = results!.string(forColumn: "syozoku0")
            let _syozoku: String = results!.string(forColumn: "syozoku")
            let _kinmu: String = results!.string(forColumn: "kinmu")
            resultArray.append([_name, _tel, _mail, _kubun, _syozoku0, _syozoku, _kinmu])
        }
        db.close()
    }
    
    //震度6弱以上検索
    func select2(_ kubun: String){
        //前の検索結果が残っているので全削除
        resultArray.removeAll()
        
        //SQL文作成準備
        let kubunSQL : String = "=IS NOT NULL"
        let syozoku0SQL : String = "IS NOT NULL"
        let syozokuSQL : String = "IS NOT NULL"
        let kinmuSQL : String = "IS NOT NULL"
        let sql = "SELECT * FROM records where kubun " + kubunSQL + " and syozoku0 " + syozoku0SQL + " and syozoku " + syozokuSQL + " and kinmu " + kinmuSQL + " ORDER BY _id;"
        db.open()
        let results = db.executeQuery(sql, withArgumentsIn: nil)
        while (results?.next())!{
            let _name: String = results!.string(forColumn: "name")
            let _tel: String = results!.string(forColumn: "tel")
            let _mail: String = results!.string(forColumn: "mail")
            let _kubun: String = results!.string(forColumn: "kubun")
            let _syozoku0: String = results!.string(forColumn: "syozoku0")
            let _syozoku: String = results!.string(forColumn: "syozoku")
            let _kinmu: String = results!.string(forColumn: "kinmu")
            resultArray.append([_name, _tel, _mail, _kubun, _syozoku0, _syozoku, _kinmu])
        }
        db.close()
    }
}
