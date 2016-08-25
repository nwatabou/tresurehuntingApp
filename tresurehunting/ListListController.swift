//
//  ListListController.swift
//  tresurehunting
//
//  Created by 浜田もえp on 2016/08/12.
//  Copyright © 2016年 浜田もえp. All rights reserved.
//

import UIKit
import Foundation

class ListListController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    var CellNumber :Int!
   // var ResultCorrectNumber : Int?
    let photos = ["1s","2s","3s","4s","5s","6s","7s","8s","9s","10s","11s","12s"]
    let CorrectPhotos = ["1","2","3","4","5","6","7","8","9","10","11","12"]
    let CorrectDate = NSUserDefaults.standardUserDefaults()
    let PointDate = NSUserDefaults.standardUserDefaults()
    var  ListPoint:Int!
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        if((CorrectDate.objectForKey("Correct")) != nil){
            //objectsを配列として確定させ、前回の保存内容を格納
            appDelegate.CorrectFlags = (CorrectDate.objectForKey("Correct") as? [Bool])!
        }
        if((PointDate.objectForKey("Point")) != nil){
           appDelegate.Point = PointDate.objectForKey("Point") as! Int
        }
        
        //トップに戻るボタンを作成
        let leftButton = UIBarButtonItem(title: "＜Back", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ListListController.goTop))
        self.navigationItem.leftBarButtonItem = leftButton
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        viewDidLoad()
        
        ListPoint = appDelegate.Point
        //既に得たキャラクターボタンはクリックできない
        for i in 0 ..< appDelegate.CorrectFlags.count {
            if(appDelegate.CorrectFlags[i]){
                //CorrectFlagsの書き込み
                ///appDelegate.CorrectFlags[ResultCorrectNumber!] = true
                ///CorrectFlagsからCorrectDateへ書き込み
                CorrectDate.setObject(appDelegate.CorrectFlags, forKey: "Correct")
                CorrectDate.synchronize()
            }
        }
        PointDate.setObject(appDelegate.Point, forKey: "Point")
        PointDate.synchronize()
        super.viewDidDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //header
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView
    {
        
        if (kind == "UICollectionElementKindSectionHeader") {
            //ヘッダー
            let testSection = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "CollectionHeader", forIndexPath: indexPath) as! CollectionHeaderView
            return testSection
        } else {
            //フッター
            let testSection = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, withReuseIdentifier: "CollectionFooter", forIndexPath: indexPath) as! CollectionFooterView
            //フッターの背景色は緑
            testSection.CFooterLabel.text = "Point : " + String(ListPoint)
            return testSection
            
        }
    }

    
    // セルが表示されるときに呼ばれる処理（1個のセルを描画する毎に呼び出されます
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        // Tag番号を使ってImageViewのインスタンス生成
        let imageView = cell.contentView.viewWithTag(1) as! UIImageView
        // 画像配列の番号で指定された要素の名前の画像をUIImageとする
        if(indexPath.row >= 0){
            if(appDelegate.CorrectFlags[indexPath.row] == true){
                let cellImage = UIImage(named: CorrectPhotos[indexPath.row])
                // UIImageをUIImageViewのimageとして設定
                imageView.image = cellImage
            }else{
                let cellImage = UIImage(named: photos[indexPath.row])
                // UIImageをUIImageViewのimageとして設定
                imageView.image = cellImage
            }
        }
        // Tag番号を使ってLabelのインスタンス生成
        let label = cell.contentView.viewWithTag(2) as! UILabel
        label.text = "Q" + CorrectPhotos[indexPath.row]
        return cell
    }
    
    // セクションの数
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // 表示するセルの数
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    
    //セルが選択された時の処理
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        ///print(indexPath.row)
        CellNumber = indexPath.row + 1
        if(appDelegate.CorrectFlags[indexPath.row]==false){
            performSegueWithIdentifier("check", sender: nil)
        }
        ///print(CellNumber)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        if(segue.identifier == "check"){
            let checkViewController:ViewController3 = (segue.destinationViewController as? ViewController3)!
            checkViewController.GetCellNumber = CellNumber
        }

    }
    

    
    //トップに戻るボタン押下時の呼び出しメソッド
    func goTop() {
        
        //トップ画面に戻る。
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
}
