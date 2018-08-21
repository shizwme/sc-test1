//
//  AuctionFastAuctionListViewController.swift
//  sc
//
//  Created by Mac on 2018/8/20.
//  Copyright © 2018年 ajmc. All rights reserved.
//

import UIKit
import Alamofire

class AuctionFastAuctionListViewControllerTemp: BaseViewController {
    
    var pageNow : Int = 1;
    
    private func initParams(page: Int) -> Parameters{
        let parameters: Parameters = [
            "token": getToken(),
            "uid": getUserId(),
            "t": 3,
            "pageNow": page
            //                "t": [1,2,3],
            //                "bar": [
            //                    "baz": "qux"
            //                ]
        ]
        return parameters;
    }
    
    private func getData(){
        print("网络操作");
        creatActivityIndicator();
        playActivityIndicator();
        Alamofire.request(AppConstant.baseUrl + "carData/fauctionListCarDataFastAuction", method: .get, parameters: initParams(page: pageNow)).responseJSON{
            response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            self.stopActivityIndicator();
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
//                if let result  = json as? NSDictionary{
//                    let flag = result.value(forKey: "flag") as? Int;
//                    let msg = result.value(forKey: "msg") as? String;
//                    if flag! > 0{
//
//                    }
//                    else{
//                        let alertController = UIAlertController(title: "提示", message: msg, preferredStyle:UIAlertControllerStyle.alert);
//                        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil));
//                        self.present(alertController, animated: true, completion: nil);
//                    }
//                }
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        };
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getData();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
