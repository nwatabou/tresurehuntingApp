//
//  CustomCell.swift
//  tresurehunting
//
//  Created by 浜田もえp on 2016/08/10.
//  Copyright © 2016年 浜田もえp. All rights reserved.
//

import UIKit

class CustomCell: UICollectionViewCell {
    @IBOutlet var lblSample:UILabel!
    @IBOutlet var imageview:UIImageView!
    @IBOutlet weak var Buttonimage: UIButton!
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }
}