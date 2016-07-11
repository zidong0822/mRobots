//
//  ConnectingView.swift
//  Swift-LightBlue
//
//  Created by Pluto Y on 16/1/7.
//  Copyright © 2016年 Pluto-y. All rights reserved.
//

import UIKit
public protocol mConnectingViewDelegate {
    
    func mConnectingViewBackAction()
  
}
class ConnectingView: UIView {
    
    var deviceImageView:UIImageView?
    var mobileImageView:UIImageView?
    var delegate:mConnectingViewDelegate?
    var backButton:UIButton?
    init(frame:CGRect,deviceimage:String,backimage:String,controllerTag:Int){
        super.init(frame:frame)
        showConnectingView()
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        
        backButton = UIButton()
        backButton!.setImage(UIImage(named:backimage), forState: UIControlState.Normal)
        backButton!.addTarget(self, action:#selector(backAction), forControlEvents: UIControlEvents.TouchUpInside)
        addSubview(backButton!)
        
        
        deviceImageView = UIImageView()
        deviceImageView?.image = UIImage(named:deviceimage)
        addSubview(deviceImageView!)
        
        mobileImageView = UIImageView()
        mobileImageView?.image = UIImage(named:"shebei")
        addSubview(mobileImageView!)
        
        
        let imageView = UIImageView(frame: CGRectMake(210,165,30, 45))
        imageView.image = UIImage(named:"you")
        self.addSubview(imageView)
        
        let imageView1 = UIImageView(frame: CGRectMake(SCREEN_WIDTH-220,165,30, 45))
        imageView1.image = UIImage(named:"you")
        imageView1.transform = CGAffineTransformMakeScale(-1,1)
        self.addSubview(imageView1)
        
        let promptLabel = UILabel()
        promptLabel.font = UI_FONT_24
        promptLabel.textColor = UIColor.hex("#646465")
        promptLabel.textAlignment = NSTextAlignment.Center
        promptLabel.text = "靠近设备进行连接"
        self.addSubview(promptLabel)
        
        
        deviceImageView?.snp_makeConstraints(closure: { (make) in
            make.width.height.equalTo(80)
            make.left.equalTo(100)
            make.top.equalTo(self.frame.height/2-40)
            
        })
        
        mobileImageView?.snp_makeConstraints(closure: { (make) in
            
            make.width.height.equalTo(80)
            make.trailing.equalTo(self.snp_trailing).offset(-100)
            make.top.equalTo(self.frame.height/2-40)
        })
        
        promptLabel.snp_makeConstraints { (make) in
            
            make.width.equalTo(200)
            make.height.equalTo(40)
            make.left.equalTo(self.frame.width/2-100)
            make.bottom.equalTo(-70)
        }
        
        backButton!.snp_makeConstraints { (make) in
            
            make.width.height.equalTo(60)
            make.top.equalTo(20)
            make.right.equalTo(-20)
        }
        let time: NSTimeInterval = 0.5
        let delay = dispatch_time(DISPATCH_TIME_NOW,
                                  Int64(time * Double(NSEC_PER_SEC)))
        dispatch_after(delay, dispatch_get_main_queue()) {
            
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(1.8)
            UIView.setAnimationRepeatCount(2000)
            var point = imageView.center
            point.x += 100
            imageView.center = point
            var point1 = imageView1.center
            point1.x -= 100
            imageView1.center = point1
            UIView.commitAnimations()
            
            
        }
        
        if(controllerTag == 1){
        
            backButton?.hidden = true
        }else{
        
            backButton?.hidden = false
        }
     
     
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func backAction(){
    
        delegate?.mConnectingViewBackAction()
    
    }
    
    
    /**
     Show the ConnectingView
     */
     func showConnectingView() {
        if let app = UIApplication.sharedApplication().delegate as? AppDelegate, let window = app.window {
            
            self.frame = window.frame
            self.tag = 1
            window.addSubview(self)
        }
   
    }
    
    /**
     Hide the ConnectingView
     */
    func hideConnectingView(){
        if let app = UIApplication.sharedApplication().delegate as? AppDelegate, let window = app.window {
            for views in window.subviews{
                views.viewWithTag(1)?.removeFromSuperview()
            }
        }
        for views in self.subviews{
            views.removeFromSuperview()
        }
    }
}

