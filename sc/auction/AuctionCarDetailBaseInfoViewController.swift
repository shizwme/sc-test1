//
//  AuctionCarDetailBaseInfoViewController.swift
//  sc
//
//  Created by Mac on 2018/8/24.
//  Copyright © 2018年 ajmc. All rights reserved.
//

import UIKit
import Alamofire

class AuctionCarDetailBaseInfoViewController: BaseViewController {

    @IBOutlet var scrollView1: UIScrollView!
    @IBOutlet var containerView: UIView!
    @IBOutlet var brandModelLab: UILabel!
    @IBOutlet var housedateLab: UILabel!
    @IBOutlet var mileageLab: UILabel!
    @IBOutlet var volumnLab: UILabel!
    @IBOutlet var gearBoxLab: UILabel!
    @IBOutlet var regLocationLab: UILabel!
    @IBOutlet var transCountLab: UILabel!
    @IBOutlet var operateTypeLab: UILabel!
    @IBOutlet var ownerTypeLab: UILabel!
    @IBOutlet var oilTypeLab: UILabel!
    @IBOutlet var jqxLab: UILabel!
    @IBOutlet var syxLab: UILabel!
    @IBOutlet var keyCountLab: UILabel!
    @IBOutlet var dipanDescLab: UILabel!
    @IBOutlet var carConfigureLab: UILabel!
    
    
    var carData : CarDataBean?;
    
    var carImageScanViewController : CarDataImageScanViewController?;
    
    var carImagesArray : [ImagesBean]?;
    
    func initCarData() {
        //dateLab.text = "\(carData?.auction_start_date)";
        brandModelLab.text = "\((carData?.brand_name)!)-\((carData?.model)!)";
        housedateLab.text = "\((carData?.household_dateStr_year_month)!)";
        mileageLab.text = "\((carData?.mileage)!/10000)万公里";
        volumnLab.text = "\((carData?.volumn)!)";
        gearBoxLab.text = "\((carData?.gear_box)!)";
        regLocationLab.text = "\((carData?.reg_location)!)";
        transCountLab.text = "\((carData?.transfer_count)!)次";
        operateTypeLab.text = "\((carData?.operate_type)!)";
        ownerTypeLab.text = "\((carData?.owner_type)!)";
        oilTypeLab.text = "\((carData?.oil_type)!)";
        jqxLab.text = "\((carData?.force_insurance_end_ymd)!)";
        syxLab.text = "\((carData?.commercial_insurance_end_ymd)!)";
        keyCountLab.text = "\((carData?.key_count)!)把";
        dipanDescLab.text = "\((carData?.dipan_desc)!)";
        carConfigureLab.text = "\((carData?.configure_str)!)";
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "imageScanSegueId"{
            carImageScanViewController = segue.destination as? CarDataImageScanViewController;
        }
    }
    
    override func parseJson(json: Any) -> Bool {
        print("解析数据");
        if let resultD  = json as? NSDictionary{
            let images = resultD.value(forKey: "list") as! NSArray;
            self.carImagesArray = ImagesBean.parseArray(array: images);
            
            let delegate = UIApplication.shared.delegate as! AppDelegate;
            delegate.trans?.updateValue((self.carImagesArray)!, forKey: "carImagesArray");
            
            self.carImageScanViewController?.notification();
        }
        else{
            print("数据错误,获取更新类型失败");
        }
        return true;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //初始化数据
        initCarData();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let delegate = UIApplication.shared.delegate as! AppDelegate;
        carData = delegate.trans!["carData"] as? CarDataBean;
        
        let d : NSDictionary = ["carId" : (carData?.id)!];
        initParam(params: d);
        getHttpJSONData(url: AppConstant.baseUrl + PathConstant.imagePath,
                        method: HTTPMethod.get, parameters: alamofireParameters);
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true);
        let width = containerView.frame.width;
        let height = containerView.frame.height;
        print("view的高度：\(height)");
        scrollView1.contentSize = CGSize(width: width, height: height);
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
