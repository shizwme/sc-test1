//
//  AuctionCarDetailCheckReportViewController.swift
//  sc
//
//  Created by Mac on 2018/8/24.
//  Copyright © 2018年 ajmc. All rights reserved.
//

import UIKit

class AuctionCarDetailCheckReportViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true);
        scrollView.contentSize = CGSize(width: 5000, height: 10000);
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
