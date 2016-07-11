//
//  mTankViewController.swift
//  mRobotPro
//
//  Created by harvey on 16/7/1.
//  Copyright © 2016年 harvey. All rights reserved.
//

import UIKit
import CoreBluetooth
import SnapKit
import Localize_Swift
class mTankViewController: UIViewController {
    
    // MARK: 定义
    //蓝牙相关
    let bluetoothManager = BluetoothManager.getInstance()
    var connectingView : ConnectingView?
    var writeData:NSMutableData = NSMutableData()
    var characteristic : CBCharacteristic?
    var writeType: CBCharacteristicWriteType?
    private var services : [CBService]?
    
    
    // - 滑杆
    var speed:UInt16 = 0
    var accelerator:UInt16 = 0
    var holderspeed:UInt16 = 0
    var holderaccelerator:UInt16 = 0
    
    // 发送字节数
    var _nBytes:Int = 0
    var writeCount:Int = 18
    
    //滑动范围
    var rockRange:CGFloat = 500

    //定时器
    var writeDataTimer:NSTimer!
    
    //页面tag
    var controllerTag = 0
    
    override func viewDidLoad() {

        setControl(0)
        
        let backGroundImage = UIImageView(frame:self.view.bounds)
        backGroundImage.image = UIImage(named:"mtank_bg")
        self.view.addSubview(backGroundImage)
  
        
        
        self.view.addSubview(tankButton)
        self.view.addSubview(droneButton)
        self.view.addSubview(settingButton)
        self.view.addSubview(joyStick1)
        self.view.addSubview(joyStick2)
        
        
        if self.bluetoothManager.connectedPeripheral != nil {
            self.bluetoothManager.disconnectPeripheral()
        }
      
        self.bluetoothManager.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(handleNotification), name: nil, object: BluetoothManager.getInstance())
  
        
    }
 
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.navigationBar.hidden = true
        controllerTag = 0
        tankButton.snp_makeConstraints { (make) in
            make.width.height.equalTo(60)
            make.top.equalTo(20)
            make.left.equalTo(20)
            
        }
        
        droneButton.snp_makeConstraints { (make) in
            
            make.width.height.equalTo(60)
            make.top.equalTo(20)
            make.right.equalTo(-20)
            
        }
        
        settingButton.snp_makeConstraints { (make) in
            
            make.width.height.equalTo(60)
            make.top.equalTo(20)
            make.centerX.equalTo(self.view.snp_centerX)
            
        }
        
        let time: NSTimeInterval = 0.030
        let delay = dispatch_time(DISPATCH_TIME_NOW,
                                  Int64(time * Double(NSEC_PER_SEC)))
        dispatch_after(delay, dispatch_get_main_queue()) {
            
            self.connectingView = ConnectingView(frame:self.view.frame,deviceimage:"icon_tank",backimage:"icon_drone2",controllerTag:self.controllerTag)
            self.connectingView?.delegate = self
            
            
        }
        
        if(getOperationWay(TANKOPERATION)==0){
            
            joyStick1.tag  = 1003
            joyStick2.tag  = 1004
            
        }else{
            joyStick1.tag  = 1004
            joyStick2.tag  = 1003
        }
        
    }
    
    private lazy var joyStick1:mJoyStick = {
        
        let joyStick1 = mJoyStick(frame:CGRectMake(30,SCREEN_HEIGHT-220,180,180))
        joyStick1.tag = 1003
        joyStick1.delegate = self
        return joyStick1
        
    }()
    
    private lazy var joyStick2:mJoyStick = {
        
        let joyStick2 = mJoyStick(frame:CGRectMake(SCREEN_WIDTH-200,SCREEN_HEIGHT-220,180,180))
        joyStick2.delegate = self
        joyStick2.tag = 1004
        return joyStick2
        
    }()
    
    private lazy var tankButton:UIButton = {
        
        let tankButton = UIButton()
        tankButton.setImage(UIImage(named:"icon_tank2"), forState: UIControlState.Normal)
        tankButton.tag = 1001
        tankButton.addTarget(self, action:#selector(gotoWeight), forControlEvents: UIControlEvents.TouchUpInside)
        return tankButton
        
    }()
    
    private lazy var droneButton:UIButton = {
        
        let droneButton = UIButton()
        droneButton.setImage(UIImage(named:"icon_drone2"), forState: UIControlState.Normal)
        droneButton.tag = 1002
        droneButton.addTarget(self, action:#selector(gotoWeight), forControlEvents: UIControlEvents.TouchUpInside)
        return droneButton
        
    }()
    
    private lazy var settingButton:UIButton = {
        let settingButton = UIButton()
        settingButton.setImage(UIImage(named:"icon_drone2"), forState: UIControlState.Normal)
        settingButton.addTarget(self, action:#selector(gotoSetting), forControlEvents: UIControlEvents.TouchUpInside)
        return settingButton
    }()
    
   }

extension mTankViewController{

    // MARK: - 跳转drone页面
    func gotoWeight(sender:UIButton){
        
        if(sender.tag != 1001){
            if((writeDataTimer) != nil){
                writeDataTimer.invalidate()
            }
            NSNotificationCenter.defaultCenter().removeObserver(self)
            self.navigationController?.wxs_pushViewController(mDroneViewController(), animationType:.SysRevealFromRight)
        }}
    
    // MARK: - 跳转设置页面
    func gotoSetting(sender:UIButton){
        
        let setting = SettingViewController()
        setting.delegate = self
        setting.indextag = 0
        controllerTag = 1
        self.navigationController?.wxs_presentViewController(setting, animationType:.SysRevealFromTop, completion:nil)
        
    }
    
    // MARK: - 蓝牙中断通知
    func handleNotification(notif: NSNotification) {
        switch notif.name {
        case PeripheralNotificationKeys.DisconnectNotif.rawValue:
            print("\(PeripheralNotificationKeys.DisconnectNotif.rawValue)")
            if((writeDataTimer) != nil){
                writeDataTimer.invalidate()
            }
            mAlertController.alert("", message:"Bluetooth connection is broken".localized(), buttons:["reconnect".localized()], tapBlock: { (UIAlertAction, Int) in
                
                self.initBlueManager()
            })
            
        default:
            print("default")
        }
    }
    
    func initBlueManager(){
        
        if self.bluetoothManager.connectedPeripheral != nil {
            self.bluetoothManager.disconnectPeripheral()
        }
        self.bluetoothManager.delegate = self
        let time: NSTimeInterval = 0.030
        let delay = dispatch_time(DISPATCH_TIME_NOW,
                                  Int64(time * Double(NSEC_PER_SEC)))
        dispatch_after(delay, dispatch_get_main_queue()) {
            
            self.connectingView = ConnectingView(frame:self.view.frame,deviceimage:"icon_tank",backimage:"icon_drone2",controllerTag:self.controllerTag)
            self.connectingView?.delegate = self
        }
    }

}


extension mTankViewController:JoyStickDelegate{

   
    func joyStickValueChange(joystick: mJoyStick) {
   
        
        speed = speed == 0 ? 1500 : 1500
        accelerator = accelerator == 0 ? 1500 :1500
        holderspeed = holderspeed == 0 ? 1500 : 1500   //摇杆
        holderaccelerator = holderaccelerator == 0 ? 1500 : 1500
        
        if(joystick.tag == 1003){
            
            if((1500 + (joystick.y/90)*rockRange) > 1500+rockRange){
                
                speed =  1500 + UInt16(rockRange)
                
            }else if((1500 + (joystick.y/90)*rockRange) < 1500){
                
                speed = 1000
                
            }else{
                
                speed = UInt16(1500 + (joystick.y/90)*rockRange)
                accelerator = UInt16(1500 + (joystick.x/90)*rockRange) > 1500 + UInt16(rockRange) ? 1500 + UInt16(rockRange) : UInt16(1500 + (joystick.x/90)*rockRange)
            }
        }else{
            
            if(abs(joystick.x)<10){
                
                holderspeed = 1500
                holderaccelerator = UInt16(1500 + (joystick.y/90)*rockRange)>1500 + UInt16(rockRange) ? 1500 + UInt16(rockRange) : UInt16(1500 + (joystick.y/90)*rockRange)
                
            }else{
                
                holderaccelerator = 1500
                holderspeed =  UInt16(1500 + (joystick.x/90)*rockRange)>1500 + UInt16(rockRange) ? 1500 + UInt16(rockRange) : UInt16(1500 + (joystick.x/90)*rockRange)
            }
        }
 
        writeDataFormat(accelerator, speed: speed, holderaccelerator: holderspeed, holderspeed:holderaccelerator )
         doTimer()
      
    
    }
    
    
    // MARK: -  格式化输入数据
    func writeDataFormat(accelerator:UInt16,speed:UInt16,holderaccelerator:UInt16,holderspeed:UInt16){
        
        var head: UInt16 = UInt16(0xBBAA)
        var code:UInt8 = UInt8(0xc8)
        var data:[UInt16] = [accelerator,speed,holderaccelerator,holderspeed,1500,1500,1500,1500]
        
        var sum =  getChecksum(16, cmd:200, mydata:data)
        writeData = NSMutableData()
        writeData.appendBytes(&head, length:sizeof(UInt16))
        writeData.appendBytes(&code, length:sizeof(UInt8))
        writeData.appendBytes(&data, length:sizeof(UInt16)*8)
        writeData.appendBytes(&sum, length:sizeof(UInt8))

    }
    

    // MARK: - 返回校验值
    func getChecksum(length:UInt16, cmd:UInt8, mydata:[UInt16]) ->UInt8{
        
        let writeData:NSMutableData = NSMutableData()
        writeData.appendBytes(mydata, length:sizeof(UInt16)*8)
        let count = writeData.length/sizeof(UInt8)
        var array = [UInt8](count:count,repeatedValue: 0)
        writeData.getBytes(&array, length:count * sizeof(UInt8))
        
        var checksum:UInt8 = 0
        checksum ^= (UInt8(length) & 0xFF)
        checksum ^= (cmd & 0xFF)
        for i in 0 ..< Int(length) {
            
            checksum ^= (array[i] & 0xFF);
            
        }
        return UInt8(checksum);
    }
    
    
    // MARK: - 写入数据
    func doTimer(){
        
        writeDataTimer = NSTimer.scheduledTimerWithTimeInterval(0.020, target: self, selector: #selector(timerFireMethod), userInfo: nil, repeats:true);
        writeDataTimer.fire()
        
    }
    
    func timerFireMethod() {
        
        if(joyStick1.y != 0||joyStick2.y != 0){
            if (_nBytes+writeCount<=writeData.length) {
                self.bluetoothManager.writeValue(writeData.subdataWithRange(NSMakeRange(_nBytes,writeCount)), forCahracteristic: self.characteristic!, type:.WithoutResponse)
                _nBytes=_nBytes+writeCount
                
                
            }else{
                self.bluetoothManager.writeValue( writeData.subdataWithRange(NSMakeRange(_nBytes,2)), forCahracteristic: self.characteristic!, type:.WithoutResponse)
                _nBytes = 0
            }
            
        }
    }

 
}
extension mTankViewController:BluetoothDelegate{
    
    // MARK: BluetoothDelegate
    func didDiscoverPeripheral(peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        
        if(getBlueToothManager("mTank").allKeys.count>0){
        
            let dict = getBlueToothManager("mTank") as NSDictionary
            bluetoothManager.connectRetirePeripheral(dict.objectForKey("uuid") as! String)
        
        }
        if(peripheral.name == DEVICENAME){
            
        if (labs(RSSI.longValue))<40 {
       
            bluetoothManager.connectPeripheral(peripheral)
            bluetoothManager.stopScanPeripheral()
            let dict = NSMutableDictionary()
            dict.setObject(peripheral.name!,forKey:"name")
            dict.setObject(peripheral.identifier.UUIDString, forKey:"uuid")
            setBlueToothManager(dict, key:"mTank")
            
            }
        }
    }
    
    /**
     The bluetooth state monitor
     - parameter state: The bluetooth state
     */
    func didUpdateState(state: CBCentralManagerState) {
        print("mTankViewController --> didUpdateState:\(state)")
        switch state {
        case .Resetting:
            print("mTankViewController --> State : Resetting")
        case .PoweredOn:
            bluetoothManager.startScanPeripheral()
            UnavailableView.hideUnavailableView()
        case .PoweredOff:
            print(" mTankViewController -->State : Powered Off")
            fallthrough
        case .Unauthorized:
            print("mTankViewController --> State : Unauthorized")
            fallthrough
        case .Unknown:
            print("mTankViewController --> State : Unknown")
            fallthrough
        case .Unsupported:
            print("mTankViewController --> State : Unsupported")
            bluetoothManager.stopScanPeripheral()
            bluetoothManager.disconnectPeripheral()
            let time: NSTimeInterval = 0.030
            let delay = dispatch_time(DISPATCH_TIME_NOW,
                                      Int64(time * Double(NSEC_PER_SEC)))
            dispatch_after(delay, dispatch_get_main_queue()) {
                if((self.connectingView) != nil){
                    self.connectingView!.hideConnectingView()
                }

                }
            UnavailableView.showUnavailableView()
            
            
        }
    }
    
    /**
     The callback function when central manager connected the peripheral successfully.
     - parameter connectedPeripheral: The peripheral which connected successfully.
     */
    func didConnectedPeripheral(connectedPeripheral: CBPeripheral) {
        print("mTankViewController --> didConnectedPeripheral")
        // connectingView?.tipLbl.text = "Interrogating..."
        
    }
    
    /**
     The peripheral services monitor
     - parameter services: The service instances which discovered by CoreBluetooth
     */
    func didDiscoverServices(peripheral: CBPeripheral) {
        print("mTankViewController --> didDiscoverService:\(peripheral.services)")
        if((self.connectingView) != nil){
            self.connectingView!.hideConnectingView()
        }
        bluetoothManager.discoverCharacteristics()
        services = bluetoothManager.connectedPeripheral?.services
        
    }
    
    /**
     The method invoked when interrogated fail.
     - parameter peripheral: The peripheral which interrogation failed.
     */
    func didFailedToInterrogate(peripheral: CBPeripheral) {
        self.connectingView!.hideConnectingView()
        
    }
    
    func didDiscoverCharacteritics(service: CBService) {
        
        print("Service.characteristics:\(service.characteristics)")
        
        for  characteristic in service.characteristics!  {
            
            print("Service UUID:\(service.UUID)  characteristic UUID:\(characteristic.UUID)")
            switch characteristic.UUID.description {
            case CHARACTERISTICID1:
                self.characteristic = characteristic
            case CHARACTERISTICID2:
                self.characteristic = characteristic
            default:
                break
            }
            
        }
    }
    
}

extension mTankViewController:mConnectingViewDelegate{

    func mConnectingViewBackAction() {
    
        self.connectingView?.hideConnectingView()
        bluetoothManager.stopScanPeripheral()
        mAlertController.alert("", message:"The device is connected , make sure it is switched".localized(), buttons:["Cancel".localized(),"Confirm".localized()], tapBlock: { ( action,i) in
        self.bluetoothManager.startScanPeripheral()
            if(i==0){
                self.connectingView = ConnectingView(frame:self.view.frame,deviceimage:"icon_tank",backimage:"icon_drone2",controllerTag:self.controllerTag)
                self.connectingView?.delegate = self
            }else{
            
                self.bluetoothManager.disconnectPeripheral()
                 self.navigationController?.wxs_pushViewController(mDroneViewController(), animationType:.SysRevealFromRight)
              }
            })    }
}

extension mTankViewController:settingDelegate{

    func PageDidChanged(name: String) {
        
        if(name == "mTank"){
        
            initBlueManager()
      
        }else{
            if((writeDataTimer) != nil){
                writeDataTimer.invalidate()
            }
            NSNotificationCenter.defaultCenter().removeObserver(self)
            self.navigationController?.wxs_pushViewController(mDroneViewController(), animationType:.SysRevealFromRight)
        
        }
    }
}
