//
//  ViewController3.swift
//  tresurehunting
//
//  Created by 浜田もえp on 2016/08/09.
//  Copyright © 2016年 浜田もえp. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController3: UIViewController, CLLocationManagerDelegate {
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    @IBOutlet weak var QLabel: UILabel!
    let photos = ["1s","2s","3s","4s","5s","6s","7s","8s","9s","10s","11s","12s"]
    @IBOutlet weak var CheckImage: UIImageView!
    @IBOutlet weak var CheckButtonV: UIButton!
    @IBOutlet weak var PointCLabel: UILabel!
    @IBAction func CheckButton(sender: AnyObject) {
        
    }
    var beaconNumber:Int?
    var GetCellNumber:Int?
    var cellNumber:Int?
    let PointDate = NSUserDefaults.standardUserDefaults()
    
    @IBAction func CHintButton(sender: AnyObject) {
        if(appDelegate.Point>0){
            if(appDelegate.HintFlag[GetCellNumber!-1] != true){
                appDelegate.HintCN = GetCellNumber!
                let HintView = self.storyboard!.instantiateViewControllerWithIdentifier("Hint")
                self.presentViewController(HintView, animated: true, completion: nil)
            }
        }else{
    
        }
    }
    //beaconの値取得関係の変数
    var trackLocationManager : CLLocationManager!
    var beaconRegion : CLBeaconRegion!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // ロケーションマネージャを作成する
        self.trackLocationManager = CLLocationManager();
    
        // デリゲートを自身に設定
        self.trackLocationManager.delegate = self;
    
        // BeaconのUUIDを設定
        let uuid:NSUUID? = NSUUID(UUIDString: "00000000-7DE6-1001-B000-001C4DF13E76")
    
        //Beacon領域を作成
        self.beaconRegion = CLBeaconRegion(proximityUUID: uuid!, identifier: "net.noumenon-th")
    
        // セキュリティ認証のステータスを取得
        let status = CLLocationManager.authorizationStatus()
    
        // まだ認証が得られていない場合は、認証ダイアログを表示
        if(status == CLAuthorizationStatus.NotDetermined) {
            self.trackLocationManager.requestAlwaysAuthorization();
        }
        
        self.CheckButtonV.hidden = true
        
        if(appDelegate.Point == 0){
            CheckButtonV.hidden = true
        }else{
            CheckButtonV.hidden = false
        }
        
        let img = UIImage(named: photos[GetCellNumber!-1])
        
        //画像の表示
        CheckImage.image = img
        QLabel.text = "Q" + String(GetCellNumber!) + ":"
        
    }
    override func viewWillAppear(animated: Bool) {
        PointDate.setObject(appDelegate.Point, forKey: "Point")
        PointDate.synchronize()
        super.viewDidDisappear(animated)
        PointCLabel.text = "Point : " + String(appDelegate.Point)
    }
    //位置認証のステータスが変更された時に呼ばれる
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
    
    // 認証のステータス
    let statusStr = "";
    print("CLAuthorizationStatus: \(statusStr)")
    print(" CLAuthorizationStatus: \(statusStr)")
    
    //観測を開始させる
    trackLocationManager.startMonitoringForRegion(self.beaconRegion)
    
    }
    
    
    
    
    //観測の開始に成功すると呼ばれる
    func locationManager(manager: CLLocationManager, didStartMonitoringForRegion region: CLRegion) {
    
    print("didStartMonitoringForRegion");
    
    //観測開始に成功したら、領域内にいるかどうかの判定をおこなう。→（didDetermineState）へ
    trackLocationManager.requestStateForRegion(self.beaconRegion);
    }
    
    //領域内にいるかどうかを判定する
    func locationManager(manager: CLLocationManager, didDetermineState state: CLRegionState, forRegion inRegion: CLRegion) {
    
    switch (state) {
    
    case .Inside: // すでに領域内にいる場合は（didEnterRegion）は呼ばれない
    trackLocationManager.startRangingBeaconsInRegion(beaconRegion);
    // →(didRangeBeacons)で測定をはじめる
    break
    
    case .Outside:
    
    // 領域外→領域に入った場合はdidEnterRegionが呼ばれる
    break
    
    case .Unknown:
    // 不明→領域に入った場合はdidEnterRegionが呼ばれる
    break
    
    }
    }
    
    //領域に入った時
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
    // →(didRangeBeacons)で測定をはじめる
        
    self.trackLocationManager.startRangingBeaconsInRegion(self.beaconRegion)
    }
    
    
    
    
    //領域から出た時
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
    //測定を停止する
        self.CheckButtonV.hidden = true
    self.trackLocationManager.stopRangingBeaconsInRegion(self.beaconRegion)
    }
    
    
    //領域内にいるので測定をする
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion){
        
        //ビーコンを1個以上観測していたら処理を実行
        if(beacons.count > 0){
        
            let beacon = beacons[0]
            beaconNumber  = Int(beacon.minor)
      
            self.CheckButtonV.hidden = false
    /*
     beaconから取得できるデータ
     beacon.○○で取得可能
     
     proximityUUID   :   regionの識別子
     major           :   識別子１
     minor           :   識別子２
     proximity       :   相対距離　←　immediate/near/far
     accuracy        :   精度
     rssi            :   電波強度
     */
    /*
     
     if (beacon.proximity == CLProximity.Unknown) {
     self.proximity.text = "Unknown Proximity"
     reset()
     return
     } else if (beacon.proximity == CLProximity.Immediate) {
     self.proximity.text = "Immediate"
     } else if (beacon.proximity == CLProximity.Near) {
     self.proximity.text = "Near"
     } else if (beacon.proximity == CLProximity.Far) {
     self.proximity.text = "Far"
     }
     self.uuid.text     = beacon.proximityUUID.UUIDString
     self.major.text    = "\(beacon.major)"
     self.minor.text    = "\(beacon.minor)"
     self.accuracy.text = "\(beacon.accuracy)"
     self.rssi.text     = "\(beacon.rssi)"
     
     */
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        print("1")
        if(segue.identifier == "result"){
            print("2")
            let resultViewController:ResultView = (segue.destinationViewController as? ResultView)!
            resultViewController.GetBeaconNumber = beaconNumber
            resultViewController.cellNumber = GetCellNumber
            print("beaconNum：" + "\(beaconNumber)")
            print("cellNum：" + "\(GetCellNumber)")
        }
    }
}

