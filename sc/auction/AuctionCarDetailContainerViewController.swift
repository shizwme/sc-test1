//
//  AuctionCarDetailContainerViewController.swift
//  sc
//
//  Created by Mac on 2018/8/24.
//  Copyright © 2018年 ajmc. All rights reserved.
//

import UIKit

class AuctionCarDetailContainerViewController: UIViewController {

    @IBOutlet var viewControllerContainer: UIView!
    @IBOutlet var checkReportViewControllerContainer: UIView!
    @IBOutlet var segmentView: UISegmentedControl!
    
    @IBAction func segmentValueChange(_ sender: UISegmentedControl) {
        print("选中的Index：\(sender.selectedSegmentIndex)");
        changeView(index: sender.selectedSegmentIndex);
    }
    
    func changeView(index : Int) {
        switch index {
        case 0:
            viewControllerContainer.isHidden = false;
            checkReportViewControllerContainer.isHidden = true;
        case 1:
            viewControllerContainer.isHidden = true;
            checkReportViewControllerContainer.isHidden = false;
        default:
            print("未知的SegmentIndex");
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewControllerContainer.isHidden = false;
        checkReportViewControllerContainer.isHidden = true;
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
