//
//  TextViewController2.swift
//  tresurehunting
//
//  Created by 浜田もえp on 2016/08/09.
//  Copyright © 2016年 浜田もえp. All rights reserved.
//
import UIKit

class TextViewController2: UIViewController {
    var NumberFlag :Int!
    @IBAction func Q1Button(sender: AnyObject) {
        NumberFlag = 9
    }
    @IBAction func Q2Button(sender: AnyObject) {
        NumberFlag = 10
    }
    @IBAction func Q3Button(sender: AnyObject) {
        NumberFlag = 3
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        if segue.identifier == "result"{
            let ResultV = segue.destinationViewController as! ResultView
            ResultV.GetNumber = self.NumberFlag
        }
    }
    
}
