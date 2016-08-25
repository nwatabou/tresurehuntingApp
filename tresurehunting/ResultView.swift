//
//  ResultView.swift
//  tresurehunting
//
//  Created by 浜田もえp on 2016/08/09.
//  Copyright © 2016年 浜田もえp. All rights reserved.
//

import UIKit

class ResultView: UIViewController {
    var CorrectNumber = 0
    let wrongPphotos = ["1s","2s","3s","4s","5s","6s","7s","8s","9s","10s","11s","12s"]
    let correctPhotos = ["1","2","3","4","5","6","7","8","9","10","11","12"]
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let PointDate = NSUserDefaults.standardUserDefaults()
    let userDefaults = NSUserDefaults.standardUserDefaults()
    let CorrectDate = NSUserDefaults.standardUserDefaults()
    var GetBeaconNumber:Int?
    var cellNumber:Int?
    @IBOutlet weak var ResultImage: UIImageView!
    @IBOutlet weak var TrueOrFalse: UILabel!
    
    @IBAction func BackButton(sender: AnyObject) {
        if(GetBeaconNumber == cellNumber){
            if let nv = navigationController {
                let hidden = !nv.navigationBarHidden
                nv.setNavigationBarHidden(hidden, animated: false)
            }
            let count = self.navigationController!.viewControllers.count - 3
            let listViewController = self.navigationController?.viewControllers[count] as! ListListController
            self.navigationController?.popToViewController(listViewController, animated: true)
        }else{
            if let nv = navigationController {
                let hidden = !nv.navigationBarHidden
                nv.setNavigationBarHidden(hidden, animated: false)
            }
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(appDelegate.Point)
        // Do any additional setup after loading the view, typically from a nib.

    }
    override func viewWillAppear(animated: Bool) {
        if let nv = navigationController {
            let hidden = !nv.navigationBarHidden
            nv.setNavigationBarHidden(hidden, animated: true)
        }
        if(GetBeaconNumber == cellNumber){
            self.TrueOrFalse.text    = "Correct!"
            let img = UIImage(named: correctPhotos[cellNumber! - 1])
            //CorrectNumberへ番号格納
            CorrectNumber = GetBeaconNumber!
  
            //画像の表示
            ResultImage.image = img
            //正解で2ポイント
            appDelegate.Point = appDelegate.Point + 2
            appDelegate.CorrectFlags[CorrectNumber-1] = true
            NSUserDefaults.standardUserDefaults().setObject(appDelegate.CorrectFlags, forKey: "Correct")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            
        }else{
            self.TrueOrFalse.text    = "Wrong!"
            let img = UIImage(named: wrongPphotos[cellNumber! - 1])
            //ポイントが０以下の場合ポイントはマイナスされない
            if(appDelegate.Point>0){
                print("おい")
                
                appDelegate.Point = appDelegate.Point - 1
            }
            //画像の表示
            ResultImage.image = img
        }
        
        
        PointDate.setObject(appDelegate.Point, forKey: "Point")
        PointDate.synchronize()
        super.viewDidDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
