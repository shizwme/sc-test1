//
//  ImagesBean.swift
//  sc
//
//  Created by Mac on 2018/8/25.
//  Copyright © 2018年 ajmc. All rights reserved.
//

import Foundation

class ImagesBean{
    var img_small : String?;
    var img_big : String?;
    var img_original : String?;
    var user_id : Int?;
    var object_id : Int?;
    var type : Int?;
    
    class func parseObject(json : Any) -> ImagesBean {
        return parseObject(dict : json as! NSDictionary);
    }
    
    class func parseObject(dict : NSDictionary) -> ImagesBean {
        let image : ImagesBean = ImagesBean();
        image.img_big = dict.value(forKey: "img_big") as? String;
        image.img_small = dict.value(forKey: "img_small") as? String;
        image.img_original = dict.value(forKey: "img_original") as? String;
        image.user_id = dict.value(forKey: "user_id") as? Int;
        image.object_id = dict.value(forKey: "object_id") as? Int;
        image.type = dict.value(forKey: "type") as? Int;
        
        return image;
    }
    
    class func parseArray(json : Any) -> [ImagesBean] {
        return parseArray(array : json as! NSArray);
    }
    
    class func parseArray(array : NSArray) -> [ImagesBean] {
        var carDataArray = [ImagesBean]();
        for item in array{
            let carData : ImagesBean = parseObject(dict: item as! NSDictionary);
            carDataArray.append(carData);
        }
        
        return carDataArray;
    }
}
