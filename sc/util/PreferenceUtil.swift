//
//  PreferenceUtil.swift
//  sc
//
//  Created by Mac on 2018/8/20.
//  Copyright © 2018年 ajmc. All rights reserved.
//

import Foundation

class PreferenceUtil {
    private static let instance : PreferenceUtil = PreferenceUtil();
    
    private init(){}
    
    public class func getInstance() -> PreferenceUtil{
        return instance;
    }
    
    public func getObject(key : String) -> Any?{
        let userDefaults = UserDefaults.standard;
        let obj = userDefaults.object(forKey: key);
        return obj;
    }
    
    public func setObject(object : Any?, key : String) -> Bool{
        let userDefaults = UserDefaults.standard;
        userDefaults.set(object, forKey: key);
        return userDefaults.synchronize();
    }
}
