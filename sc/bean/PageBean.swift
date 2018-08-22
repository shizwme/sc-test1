//
//  PageBean.swift
//  sc
//
//  Created by Mac on 2018/8/22.
//  Copyright © 2018年 ajmc. All rights reserved.
//

import Foundation

class PageBean{
    var indexEnd : Int?;
    var indexStart : Int?;
    var pageIndexCount : Int?;
    var pageNumber : Int?;
    var pageSize : Int?;
    var totalPage : Int?;
    var totalRow : Int?;
    
    class func parseObject(json : Any) -> PageBean {
        return parseObject(dict : json as! NSDictionary);
    }
    
    class func parseObject(dict : NSDictionary) -> PageBean {
        let page : PageBean = PageBean();

        page.indexEnd = dict.value(forKey: "indexEnd") as? Int;
        page.indexStart = dict.value(forKey: "indexStart") as? Int;
        page.pageNumber = dict.value(forKey: "pageNumber") as? Int;
        page.pageSize = dict.value(forKey: "pageSize") as? Int;
        page.totalPage = dict.value(forKey: "totalPage") as? Int;
        page.totalRow = dict.value(forKey: "totalRow") as? Int;
        
        return page;
    }
    
    class func parseArray(json : Any) -> [PageBean] {
        return parseArray(array : json as! NSArray);
    }
    
    class func parseArray(array : NSArray) -> [PageBean] {
        var pageArray = [PageBean]();
        for item in array{
            let page : PageBean = parseObject(dict: item as! NSDictionary);
            pageArray.append(page);
        }
        
        return pageArray;
    }
}
