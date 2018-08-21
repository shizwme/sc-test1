//
//  DeviceUtil.swift
//  sc
//
//  Created by Mac on 2018/8/20.
//  Copyright © 2018年 ajmc. All rights reserved.
//

import Foundation
import UIKit

class DeviceUtil{
    
    private static let instance : DeviceUtil = DeviceUtil();
    
    private init(){}
    
    public class func getInstance() -> DeviceUtil{
        return instance;
    }
    
    /**
     IdentifierForVendor
     是给Vendor标识用户用的，每个设备在所属同一个Vender的应用里，都有相同的值。其中的Vender是指应用提供商，但准确点说，是通过BundleID的反转的前两部分进行匹配，如果相同就是同一个Vender，例如对于com.taobao.app1, com.taobao.app2 这两个BundleID来说，就属于同一个Vender，共享同一个idfv的值。和idfa不同的是，idfv的值是一定能取到的，所以非常适合于作为内部用户行为分析的主id，来标识用户，替代OpenUDID。
     */
    public func getIDFV() -> String{
        if UIDevice.current.identifierForVendor != nil{
            return UIDevice.current.identifierForVendor!.uuidString;
        }
        else{
            return "123456";
        }
    }
}
