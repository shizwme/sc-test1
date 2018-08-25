//
//  AuctionNavViewController.swift
//  sc
//
//  Created by Mac on 2018/8/19.
//  Copyright © 2018年 ajmc. All rights reserved.
//

import UIKit
import Alamofire

class AuctionNavViewController: BaseViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true);
        print(path);
        
        path = NSSearchPathForDirectoriesInDomains(.preferencePanesDirectory, .userDomainMask, true);
        print(path);
        
        print("AuctionNavViewController");
        
        let delegate = UIApplication.shared.delegate as! AppDelegate;
        print("获取到的docPath：\(String(describing: delegate.trans!["docPath"]))");
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBAction func fastAuctionIVClick(_ sender: UITapGestureRecognizer) {
        //实例化目标controller
//        var viewController = self.storyboard?.instantiateViewController(withIdentifier: "id") as UIViewController;
        //跳转
//        self.navigationController?.showDetailViewController(ViewController, sender: nil);
//    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
