//
//  PListUtil.swift
//  sc
//
//  Created by Mac on 2018/8/20.
//  Copyright © 2018年 ajmc. All rights reserved.
//

import Foundation

class PListUtil{
    private static let instance : PListUtil = PListUtil();
    
    private init(){}
    
    public class func getInstance() -> PListUtil{
        return instance;
    }
    
    public func getDictionary(filePath : String) -> NSDictionary?{
        return NSDictionary(contentsOfFile: filePath);
    }
    
    public func setDictionary(filePath : String, dictionary : NSDictionary) -> Bool{
        return dictionary.write(toFile: filePath, atomically: true);
    }
    
    public func getArray(filePath : String) -> NSArray?{
        return NSArray(contentsOfFile: filePath);
    }
    
    public func setArray(filePath : String, dictionary : NSArray) -> Bool{
        return dictionary.write(toFile: filePath, atomically: true);
    }
    
    public func getDictionaryValueInt(filePath : String, key : String) -> Int{
        let dic = NSDictionary(contentsOfFile: filePath);
        if dic == nil{
            return 0;
        }
        return dic?.value(forKey: key) as! Int;
    }
}
