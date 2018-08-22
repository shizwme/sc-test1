//
//  CarDataBean.swift
//  sc
//
//  Created by Mac on 2018/8/22.
//  Copyright © 2018年 ajmc. All rights reserved.
//

import Foundation

class CarDataBean{
    var logo : String?;
    var brand_id : Int?;
    var model : String?;
    var volumn : String?;
    var gear_box : String?;
    var drive_type : String?;
    var configure : String?;
    var appearance : String?;
    var households_date : Int?;
    var upload_date : Int?;
    var mileage : Double?;
    var dipan_desc : String?;
    var special_remarks : String?;
    var transfer_count : Int?;
    var reg_location : String?;
    var key_count : Int?;
    var commercial_insurance_end : Int?;
    var force_insurance_end : Int?;
    var oil_type : String?;
    var owner_type : String?;
    var operate_type : String?;
    var car_type : String?;
    var city_id : Int?;
    var data_type : Int?;
    var sale_date : Int?;
    var sale_price : Double?;
    var sale_duration : String?;
    var merchant_id : Int?;
    var user_id : Int?;
    var status : Int?;
    var car_data_id : Int?;
    var impact_text : String?;
    var is_auctioned : Int?;
    var auction_org_id : Int?;
    var auction_special_id : Int?;
    var auction_note_id : Int?;
    var now_auction_price : Double?;
    var start_auction_price : Double?;
    var expect_auction_price_high : Double?;
    var expect_auction_price_low : Double?;
    var auction_start_date : Double?;
    var auction_end_date : Double?;
    var check_flag : Int?;
    var id : Int?;
    var is_enable : Int?;
    var create_date : Int?;
    var delete_date : Int?;
    var is_click : Int?;
    
    var household_dateStr_year : String!;
    var household_dateStr_long : String!;
    var brand_name : String!;
    
    class func parseObject(json : Any) -> CarDataBean {
        return parseObject(dict : json as! NSDictionary);
    }
    
    class func parseObject(dict : NSDictionary) -> CarDataBean {
        let carData : CarDataBean = CarDataBean();
        carData.logo = dict.value(forKey: "logo") as? String;
        carData.brand_id = dict.value(forKey: "brand_id") as? Int;
        carData.model = dict.value(forKey: "model") as? String;
        carData.volumn = dict.value(forKey: "volumn") as? String;
        carData.gear_box = dict.value(forKey: "gear_box") as? String;
        carData.drive_type = dict.value(forKey: "drive_type") as? String;
        carData.configure = dict.value(forKey: "configure") as? String;
        carData.appearance = dict.value(forKey: "appearance") as? String;
        carData.households_date = dict.value(forKey: "households_date") as? Int;
        carData.upload_date = dict.value(forKey: "upload_date") as? Int;
        carData.mileage = dict.value(forKey: "mileage") as? Double;
        carData.dipan_desc = dict.value(forKey: "dipan_desc") as? String;
        carData.special_remarks = dict.value(forKey: "special_remarks") as? String;
        carData.transfer_count = dict.value(forKey: "transfer_count") as? Int;
        carData.reg_location = dict.value(forKey: "reg_location") as? String;
        carData.key_count = dict.value(forKey: "key_count") as? Int;
        carData.commercial_insurance_end = dict.value(forKey: "commercial_insurance_end") as? Int;
        carData.force_insurance_end = dict.value(forKey: "force_insurance_end") as? Int;
        carData.oil_type = dict.value(forKey: "oil_type") as? String;
        carData.owner_type = dict.value(forKey: "owner_type") as? String;
        carData.operate_type = dict.value(forKey: "operate_type") as? String;
        carData.car_type = dict.value(forKey: "car_type") as? String;
        carData.city_id = dict.value(forKey: "city_id") as? Int;
        carData.data_type = dict.value(forKey: "data_type") as? Int;
        carData.sale_date = dict.value(forKey: "sale_date") as? Int;
        carData.sale_price = dict.value(forKey: "sale_price") as? Double;
        carData.sale_duration = dict.value(forKey: "sale_duration") as? String;
        carData.merchant_id = dict.value(forKey: "merchant_id") as? Int;
        carData.user_id = dict.value(forKey: "user_id") as? Int;
        carData.status = dict.value(forKey: "status") as? Int;
        carData.car_data_id = dict.value(forKey: "car_data_id") as? Int;
        carData.impact_text = dict.value(forKey: "impact_text") as? String;
        carData.is_auctioned = dict.value(forKey: "is_auctioned") as? Int;
        carData.auction_org_id = dict.value(forKey: "auction_org_id") as? Int;
        carData.auction_special_id = dict.value(forKey: "auction_special_id") as? Int;
        carData.auction_note_id = dict.value(forKey: "auction_note_id") as? Int;
        carData.now_auction_price = dict.value(forKey: "now_auction_price") as? Double;
        carData.start_auction_price = dict.value(forKey: "start_auction_price") as? Double;
        carData.expect_auction_price_high = dict.value(forKey: "expect_auction_price_high") as? Double;
        carData.expect_auction_price_low = dict.value(forKey: "expect_auction_price_low") as? Double;
        carData.auction_start_date = dict.value(forKey: "auction_start_date") as? Double;
        carData.auction_end_date = dict.value(forKey: "auction_end_date") as? Double;
        carData.check_flag = dict.value(forKey: "check_flag") as? Int;
        carData.id = dict.value(forKey: "id") as? Int;
        carData.is_enable = dict.value(forKey: "is_enable") as? Int;
        carData.create_date = dict.value(forKey: "create_date") as? Int;
        carData.delete_date = dict.value(forKey: "delete_date") as? Int;
        
        carData.household_dateStr_year = DateFormatterUtil.formatter(pattern: "yyyy年", time: carData.households_date!);
        carData.household_dateStr_long = DateFormatterUtil.formatter(pattern: "yyyy-MM-dd HH:mm:ss", time: carData.households_date!);
        
        carData.brand_name = setBrandName(brandId: carData.brand_id!);
        
        return carData;
    }
    
    class func parseArray(json : Any) -> [CarDataBean] {
        return parseArray(array : json as! NSArray);
    }
    
    class func parseArray(array : NSArray) -> [CarDataBean] {
        var carDataArray = [CarDataBean]();
        for item in array{
            let carData : CarDataBean = parseObject(dict: item as! NSDictionary);
            carDataArray.append(carData);
        }
        
        return carDataArray;
    }
    
    class func setBrandName(brandId : Int) -> String{
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/" + AppConstant.brandFileNamePList;
        let brand : NSArray = PListUtil.getInstance().getArray(filePath : path)!;
        var brandName = "";
        for item in brand{
            let dict = item as! NSDictionary;
            if dict.value(forKey: "id") as! Int == brandId{
                brandName = dict.value(forKey: "name") as! String;
                break;
            }
        }

        return brandName;
    }
}
