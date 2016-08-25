//
//  HintController.swift
//  tresurehunting
//
//  Created by 浜田もえp on 2016/08/22.
//  Copyright © 2016年 浜田もえp. All rights reserved.
//

import UIKit

class HintController: UIViewController {
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let Hint   = ["道がわからないときはここへ！松下ゼミの展示が見えます！","図書館が見えます。ドアとドアの間にいます。","気分が悪くなったらここへ！自販機が見えます","パソコンがたくさんあります！エレベーターが見えます！","お菓子がたくさん置いてあるところにいるよ！","博士です。喫煙所と、高槻市が見渡せるところにいます。","学生専用の棟。演劇部が見えます。","階段と人口の川が見えます。後ろに喫煙場所と、高槻市が見渡せる場所があります。","勉強する部屋です…コミュニケーションルームの近くにあります。ここから入口は見えません","運動しよう！女子ロッカールームが覗けるところにいるよ！","有名人も練習しにきます。　入口近くに隠れてますね！","ヒヒーン"]
    var hGetCellNumber:Int?
    let photos = ["1s","2s","3s","4s","5s","6s","7s","8s","9s","10s","11s","12s"]
    @IBOutlet weak var HintQLabel: UILabel!
    @IBOutlet weak var HintPLabel: UILabel!
    @IBOutlet weak var HintImage: UIImageView!
    @IBOutlet weak var HintLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        hGetCellNumber = appDelegate.HintCN
        let img = UIImage(named: photos[hGetCellNumber!-1])        //画像の表示
        HintImage.image = img
        HintQLabel.text = "Q" + String(hGetCellNumber!) + ":"
        HintLabel.text = Hint[hGetCellNumber!-1]
        appDelegate.HintFlag[hGetCellNumber!-1] = true
        HintPLabel.text = "Point : " + String(appDelegate.Point)
        
        
    }
    override func viewWillAppear(animated: Bool) {
        if(appDelegate.HintFlag[hGetCellNumber!]==false){
            if(appDelegate.Point > 0){
                appDelegate.Point = appDelegate.Point - 1
                super.viewDidDisappear(animated)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
