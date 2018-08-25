//
//  AuctionCarDetailCheckReportViewController.swift
//  sc
//
//  Created by Mac on 2018/8/24.
//  Copyright © 2018年 ajmc. All rights reserved.
//

import UIKit
import WebKit

class AuctionCarDetailCheckReportViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet var webView1: WKWebView!;
    
    var carData : CarDataBean?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let delegate = UIApplication.shared.delegate as! AppDelegate;
        carData = delegate.trans!["carData"] as? CarDataBean;
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("加载网页viewDidAppear");
        webView1.load(URLRequest(url: URL(string: AppConstant.baseUrl + PathConstant.webPath + "android_check_report.jsp?ci=\((carData?.id)!)")!));
        print("加载网页完毕");
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
