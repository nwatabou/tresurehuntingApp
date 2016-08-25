//
//  HowToViewController.swift
//  tresurehunting
//
//  Created by 浜田もえp on 2016/08/10.
//  Copyright © 2016年 浜田もえp. All rights reserved.
//

import UIKit

class HowToViewController: UIViewController {
    @IBOutlet weak var HowImageView: UIImageView!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
        let img = UIImage(named: "Howto.png")
        self.HowImageView.image = img
    }
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
    }
        
        
}
