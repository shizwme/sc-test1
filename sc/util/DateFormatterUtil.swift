//
//  DateFormatterUtil.swift
//  sc
//
//  Created by Mac on 2018/8/22.
//  Copyright © 2018年 ajmc. All rights reserved.
//

import Foundation

class DateFormatterUtil {
    class func formatter(pattern : String?, date : Date) -> String{
        var pat = "yyyy-MM-dd HH:mm:ss";
        if pattern != nil{
            pat = pattern!;
        }
        let dformatter = DateFormatter();
        dformatter.dateFormat = pat;
        let datestr = dformatter.string(from: date);
        return datestr;
    }
    
    class func formatter(pattern : String?, time : Int) -> String{
        return formatter(pattern: pattern, date: Date(timeIntervalSince1970: TimeInterval(time/1000)));
    }
    
    class func getCurrentTime() -> Int {
        let now = Date();
        let timeInterval : TimeInterval = now.timeIntervalSince1970;
        let timeStamp = Int(timeInterval);
        return timeStamp * 1000;
    }
}
