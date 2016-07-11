//
//  SelectViewController.swift
//  mRobotPro
//
//  Created by harvey on 16/7/5.
//  Copyright © 2016年 harvey. All rights reserved.
//

import UIKit
import Hue
class SelectViewController: UIViewController {

    override func viewDidLoad() {
        
        let backGroundImage = UIImageView(frame:self.view.bounds)
        backGroundImage.image = UIImage(named:"bg")
        self.view.addSubview(backGroundImage)
        
        
        self.view.addSubview(tankButton)
        self.view.addSubview(lineLabel)
        self.view.addSubview(droneButton)
        
    }
    
    private lazy var lineLabel:UILabel = {
    
        let lineLabel = UILabel(frame:CGRectMake(330,130,1,90))
        lineLabel.backgroundColor = THEMECOLOR
        return lineLabel
    }()
    
    
    private lazy var tankButton:UIButton = {
    
        let tankButton = UIButton(frame:CGRectMake(150,100,120,140))
        tankButton.tag = 1001
        tankButton.setImage(UIImage(named:"tank_01"), forState: UIControlState.Normal)
        tankButton.addTarget(self, action:#selector(gotoController), forControlEvents: UIControlEvents.TouchUpInside)
        return tankButton
    }()
    
    
    private lazy var droneButton:UIButton = {
        
        let droneButton = UIButton(frame:CGRectMake(400,100,120,140))
        droneButton.tag = 1002
        droneButton.setImage(UIImage(named:"drone_01"), forState: UIControlState.Normal)
        droneButton.addTarget(self, action:#selector(gotoController), forControlEvents: UIControlEvents.TouchUpInside)
        return droneButton
    }()
    
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.navigationBar.hidden = true
        
    }
    func gotoController(sender:UIButton){
    
        if(sender.tag == 1001){
            self.navigationController!.wxs_pushViewController(mTankViewController(), animationType:.Default)
        }else{
            self.navigationController!.wxs_pushViewController(mDroneViewController(), animationType:.Default)
        }
}
}
