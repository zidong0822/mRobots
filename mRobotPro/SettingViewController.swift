//
//  SettingViewController.swift
//  mRobotPro
//
//  Created by harvey on 16/7/4.
//  Copyright © 2016年 harvey. All rights reserved.
//

import UIKit
import BetterSegmentedControl
public protocol settingDelegate {
    
    func PageDidChanged(name:String);
   
}
class SettingViewController: UIViewController {

    var scrollViewPage:ISScrollViewPage?
    var delegate:settingDelegate?
    var pageIndex:String?
    var indextag:UInt?
    override func viewDidLoad() {
        
        self.view.backgroundColor = BACKGROUDCOLOR
        
        if(indextag == 0){
        
            pageIndex = "mTank"
        
        }else{
        
            pageIndex = "mDrone"
        
        }
        scrollViewPage = ISScrollViewPage(frame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT*2))
        scrollViewPage!.scrollViewPageDelegate = self;
        scrollViewPage!.setEnableBounces(false)
        scrollViewPage!.setPaging(false)
        scrollViewPage!.scrollViewPageType = ISScrollViewPageType.ISScrollViewPageHorizontally
        self.view.addSubview(scrollViewPage!)
    
        let controllers = [TankSettingViewController(),DroneSettingViewController()]
        scrollViewPage!.setControllers(controllers)
        scrollViewPage?.goToIndex(Int(indextag!), animated:true)
        
        let control = BetterSegmentedControl(
            frame: CGRect(x:(SCREEN_WIDTH-330)/2, y:20, width:400, height: 44.0),
            titles: ["Tank", "Drone"],
            index: indextag!,
            backgroundColor: BACKGROUDCOLOR,
            titleColor: BUTTONBACKGROUND,
            indicatorViewBackgroundColor: BUTTONBACKGROUND,
            selectedTitleColor: .blackColor())
        control.titleFont = UIFont(name: "HelveticaNeue", size: 14.0)!
        control.addTarget(self, action: #selector(controlValueChanged), forControlEvents: .ValueChanged)
        control.layer.borderColor = UIColor.hex("#7A7B7B").CGColor
        control.layer.borderWidth = 1
        view.addSubview(control)
        view.addSubview(backButton)
        view.addSubview(reduceButton)
    }
    
    
    private lazy var backButton:UIButton = {
    
        let backButton = UIButton()
        backButton.setImage(UIImage(named:"icon_back"), forState: UIControlState.Normal)
        backButton.addTarget(self, action:#selector(backAction), forControlEvents: UIControlEvents.TouchUpInside)
        return backButton
    }()
    
    private lazy var reduceButton:UIButton = {
        
        let reduceButton = UIButton()
        reduceButton.setTitle("Reset".localized(), forState: UIControlState.Normal)
        reduceButton.backgroundColor = THEMECOLOR
        reduceButton.titleLabel?.font = UI_FONT_16
        reduceButton.layer.cornerRadius = 5
        reduceButton.addTarget(self, action:#selector(reduceAction), forControlEvents: UIControlEvents.TouchUpInside)
        return reduceButton
    }()
    
    override func viewWillAppear(animated: Bool) {
        
        backButton.snp_makeConstraints { (make) in
            
            make.width.height.equalTo(40)
            make.top.equalTo(20)
            make.left.equalTo(40)
            
            
        }
        
        reduceButton.snp_makeConstraints { (make) in
            
            
            make.width.equalTo(100)
            make.height.equalTo(60)
            make.bottom.equalTo(self.view.snp_bottom).offset(-100)
            make.right.equalTo(self.view.snp_right).offset(-90)
            
            
        }
        
    }
    
    
    
    func controlValueChanged(control:BetterSegmentedControl){
    
        if(control.index == 0){
            
            scrollViewPage?.goToIndex(0, animated:false)
            pageIndex = "mTank"
        }else{
        
            scrollViewPage?.goToIndex(1, animated:false)
            pageIndex = "mDrone"
        
        }
    }
    
    func backAction(){
    
        self.dismissViewControllerAnimated(true) { 
         
            
        }
    }
    
    func reduceAction(sender:UIButton){
        
        if(getBlueToothManager(pageIndex!).allKeys.count>0){
            clearBlueToothManager(pageIndex!)
        }
        delegate?.PageDidChanged(self.pageIndex!)
        self.dismissViewControllerAnimated(true) {}
    }
    
}

extension SettingViewController:ISScrollViewPageDelegate{

    func scrollViewPageDidChanged(scrollViewPage: ISScrollViewPage, index: Int) {
        
    }

}
