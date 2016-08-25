//
//  ViewController.swift
//  tresurehunting
//
//  Created by 浜田もえp on 2016/08/08.
//  Copyright © 2016年 浜田もえp. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController , CLLocationManagerDelegate {
    //beaconの値取得関係の変数
    var trackLocationManager : CLLocationManager!
    var beaconRegion : CLBeaconRegion!
    @IBOutlet weak var imageView: UIImageView!

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
        
        let img = UIImage(named: "title.png")
        self.imageView.image = img

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
