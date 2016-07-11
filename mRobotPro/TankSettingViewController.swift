//
//  TankSettingViewController.swift
//  mRobotPro
//
//  Created by harvey on 16/7/7.
//  Copyright © 2016年 harvey. All rights reserved.
//

import UIKit

class TankSettingViewController: UIViewController {

    override func viewDidLoad() {
        
        self.view.backgroundColor = BACKGROUDCOLOR
        
        self.view.addSubview(wayLabel)
        self.view.addSubview(blueLabel)
        self.view.addSubview(japButton)
        self.view.addSubview(ameButton)
        self.view.addSubview(nameLabel)
        self.view.addSubview(IdLabel)
       
      
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        wayLabel.snp_makeConstraints { (make) in
            
            make.width.equalTo(120)
            make.height.equalTo(30)
            make.left.equalTo(40)
            make.top.equalTo(120)
        }
        
        blueLabel.snp_makeConstraints { (make) in
            
            make.width.equalTo(120)
            make.height.equalTo(30)
            make.left.equalTo(40)
            make.top.equalTo(wayLabel.snp_bottom).offset(60)
        }
        
        japButton.snp_makeConstraints { (make) in
            
            make.width.equalTo(180)
            make.height.equalTo(35)
            make.left.equalTo(wayLabel.snp_right).offset(10)
            make.top.equalTo(120)
            
        }
        
        ameButton.snp_makeConstraints { (make) in
            
            make.width.equalTo(180)
            make.height.equalTo(35)
            make.left.equalTo(japButton.snp_right).offset(50)
            make.top.equalTo(120)
        }
        
        nameLabel.snp_makeConstraints { (make) in
            
            make.width.equalTo(300)
            make.height.equalTo(30)
            make.left.equalTo(blueLabel.snp_right).offset(10)
            make.top.equalTo(wayLabel.snp_bottom).offset(60)
            
        }
        IdLabel.snp_makeConstraints { (make) in
            
            
            make.width.equalTo(320)
            make.height.equalTo(30)
            make.left.equalTo(blueLabel.snp_right).offset(10)
            make.top.equalTo(nameLabel.snp_bottom).offset(5)
            
        }
       
        
        if(getBlueToothManager("mTank").allKeys.count>0){
            
            let dict = getBlueToothManager("mTank") as NSDictionary
            nameLabel.text = "Name".localized() + (dict.objectForKey("name") as! String)
            IdLabel.text = "ID".localized() + (dict.objectForKey("uuid") as! String)
            
        }
        if(getOperationWay(TANKOPERATION)==0){
            
            ameButton.backgroundColor = UIColor.clearColor()
            ameButton.setTitleColor(BUTTONBACKGROUND, forState: UIControlState.Normal)
            japButton.backgroundColor = BUTTONBACKGROUND
            japButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            ameButton.tag = 1002
        
        }else{
        
            japButton.backgroundColor = UIColor.clearColor()
            japButton.setTitleColor(BUTTONBACKGROUND, forState: UIControlState.Normal)
            ameButton.backgroundColor = BUTTONBACKGROUND
            ameButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            japButton.tag = 1003
        
        }
        
        
    }
    
    private lazy var wayLabel:UILabel = {
    
        let wayLabel = UILabel()
        wayLabel.text = "Operation".localized()
        wayLabel.font = UI_FONT_16
        wayLabel.textColor = BUTTONBACKGROUND
        return wayLabel
    }()
    
    private lazy var blueLabel:UILabel = {
        
        let blueLabel = UILabel()
        blueLabel.text = "Information".localized()
        blueLabel.font = UI_FONT_16
        blueLabel.textColor = BUTTONBACKGROUND
        return blueLabel
    }()
    
    
    private lazy var japButton:UIButton = {
    
        let japButton = UIButton()
        japButton.setTitle("Japan".localized(), forState: UIControlState.Normal)
        japButton.backgroundColor = BUTTONBACKGROUND
        japButton.titleLabel?.font = UI_FONT_16
        japButton.layer.cornerRadius = 5
        japButton.tag = 1001
        japButton.layer.borderWidth = 1
        japButton.addTarget(self, action:#selector(opertionChange), forControlEvents: UIControlEvents.TouchUpInside)
        japButton.layer.borderColor = BUTTONBACKGROUND.CGColor
        return japButton
    }()
    
    private lazy var ameButton:UIButton = {
        
        let ameButton = UIButton()
        ameButton.setTitle("American".localized(), forState: UIControlState.Normal)
        ameButton.titleLabel?.font = UI_FONT_16
        ameButton.layer.cornerRadius = 5
        ameButton.layer.borderWidth = 1
        ameButton.tag = 1002
        ameButton.addTarget(self, action:#selector(opertionChange1), forControlEvents: UIControlEvents.TouchUpInside)
        ameButton.layer.borderColor = BUTTONBACKGROUND.CGColor
        ameButton.backgroundColor = UIColor.clearColor()
        ameButton.setTitleColor(BUTTONBACKGROUND, forState: UIControlState.Normal)
        return ameButton
    }()
    
    private lazy var nameLabel:UILabel = {
        
        let nameLabel = UILabel()
        nameLabel.text = "Name".localized()
        nameLabel.font = UI_FONT_16
        nameLabel.textColor = BUTTONBACKGROUND
        return nameLabel
    }()
    
    private lazy var IdLabel:UILabel = {
        
        let IdLabel = UILabel()
        IdLabel.text = "ID".localized()
        IdLabel.font = UI_FONT_14
        IdLabel.textColor = BUTTONBACKGROUND
        return IdLabel
    }()
    

    
}

extension TankSettingViewController{

    func opertionChange(sender:UIButton){
    
        if(sender.tag == 1003){
            print(japButton.tag)
            setOperationWay(0, key:TANKOPERATION)
            ameButton.backgroundColor = UIColor.clearColor()
            ameButton.setTitleColor(BUTTONBACKGROUND, forState: UIControlState.Normal)
            sender.backgroundColor = BUTTONBACKGROUND
            sender.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            ameButton.tag = 1002
        }
     
    }

    func opertionChange1(sender:UIButton){
        
        if(sender.tag == 1002){
            print(ameButton.tag)
            setOperationWay(1, key:TANKOPERATION)
            japButton.backgroundColor = UIColor.clearColor()
            japButton.setTitleColor(BUTTONBACKGROUND, forState: UIControlState.Normal)
            sender.backgroundColor = BUTTONBACKGROUND
            sender.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            japButton.tag = 1003
            
        }
        
    }

 

}

