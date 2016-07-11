//
//  AppConfig.swift
//  Elara
//
//  Created by HeHongwe on 15/12/18.
//  Copyright © 2015年 harvey. All rights reserved.
//

import Foundation
import UIKit
import CoreBluetooth
import Hue

let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height

let UI_FONT_24 = UIFont.boldSystemFontOfSize(22)
let UI_FONT_20 = UIFont.systemFontOfSize(20)
let UI_FONT_16 = UIFont.systemFontOfSize(16)
let UI_FONT_14 = UIFont.systemFontOfSize(14)
let UI_FONT_10 = UIFont.systemFontOfSize(10)

let UNLOCK_CMD :[UInt16] = [1500, 1500, 2000, 1000, 1500, 1500, 1500, 1500]
let NORMAL_CMD :[UInt16] = [1500, 1500, 1500, 1150, 1000, 1000, 1000, 1000]
let DOWN_CMD:[UInt16] = [1500, 1500, 1500, 1200, 1000, 1000, 1000, 1000]
let LOCK_CMD:[UInt16] = [1500, 1500, 1000, 1000, 1500, 1500, 1500, 1500]

let THEMECOLOR = UIColor.hex("#646465")
let BACKGROUDCOLOR  = UIColor.hex("#262626")
let BUTTONBACKGROUND = UIColor.hex("#8C8B8E")
let BUTTONTITLECOLOR = UIColor.hex("")
let BUTTONSELECTEDBACKGROUND = UIColor.hex("")
let BUTTONSELECTEDTITLECOLOR = UIColor.hex("")

let DEVICENAME = "microduino"
let CHARACTERISTICID1 = "FFF6"
let CHARACTERISTICID2 = "F0C4"

let TANKOPERATION = "tankopertationway"
let DRONEOPERATION = "droneopertationway"


public func setControl(index:Int){

    let userDefaults = NSUserDefaults.standardUserDefaults()
    userDefaults.setValue(index, forKey:"Control")
    userDefaults.synchronize()
}
public func getControl()->Int{

    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    if  userDefaults.objectForKey("Control") != nil {
        
        return userDefaults.objectForKey("Control") as! Int
        
    }else{
        
        return 10
    }
}

public func setBlueToothManager(manager:NSDictionary,key:String){

    let userDefaults = NSUserDefaults.standardUserDefaults()
    userDefaults.setValue(manager, forKey:key)
    userDefaults.synchronize()
}

public func getBlueToothManager(key:String)->NSDictionary{

    let userDefaults = NSUserDefaults.standardUserDefaults()

    if  userDefaults.objectForKey(key) != nil {
        
        return userDefaults.objectForKey(key) as! NSDictionary
    }else{
        let dict = NSDictionary()
        return dict
    }
}

public func clearBlueToothManager(key:String){

    let userDefaults = NSUserDefaults.standardUserDefaults()
    userDefaults.removeObjectForKey(key)

}

public func setOperationWay(way:Int,key:String){

    let userDefaults = NSUserDefaults.standardUserDefaults()
    userDefaults.setValue(way, forKey:key)
    userDefaults.synchronize()

}

public func getOperationWay(key:String)->Int{
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    if  userDefaults.objectForKey(key) != nil {
        
        return userDefaults.objectForKey(key) as! Int
    }else{
       
        return 10
    }
}

