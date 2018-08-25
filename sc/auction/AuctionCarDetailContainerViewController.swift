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
    @IBOutlet var dateLab: UILabel!
    @IBOutlet var auctionMobiLab: UILabel!
    @IBOutlet var auctionCountLab: UILabel!
    @IBOutlet var startAuctionPriceLab: UILabel!
    @IBOutlet var myAuctionPriceLab: UILabel!
    
    var carData : CarDataBean?;
    
    var auctionAlertDialog : UIAlertController?;
    
    //出价
    @IBAction func auctionBtnClick(_ sender: UIButton) {
        let alertController = UIAlertController(title: "出价", message: "出价必须为500的整数倍", preferredStyle:UIAlertControllerStyle.alert);
        alertController.addTextField(configurationHandler: { (textField: UITextField!) -> Void in
            textField.placeholder = "请输入价格";
            textField.keyboardType = UIKeyboardType.numberPad;
            // 添加监听代码，监听文本框变化时要做的操作
            NotificationCenter.default.addObserver(self, selector: #selector(self.alertTextFieldDidChange), name: NSNotification.Name.UITextFieldTextDidChange, object: textField);
        });
        
        alertController.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil));
        let okAction = UIAlertAction(title: "出价", style: UIAlertActionStyle.default , handler: { (action: UIAlertAction!) -> Void in
            let price = (alertController.textFields?.first)! as UITextField;
            let str = price.text;
            print("出价价格：\(str ?? "0")");
            
            //执行出价逻辑
            
            
            //NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
        })
        okAction.isEnabled = false

        alertController.addAction(okAction);
        self.present(alertController, animated: true, completion: nil);
    }
    
    /// 监听文字改变
    @objc func alertTextFieldDidChange(){
        let alertController = self.presentedViewController as! UIAlertController?;
        if (alertController != nil) {
            let price = (alertController!.textFields?.first)! as UITextField;
            let okAction = alertController!.actions.last! as UIAlertAction;
            if (!(price.text?.isEmpty)! && Int(price.text!)! % 500 == 0) {
                okAction.isEnabled = true;
            } else {
                okAction.isEnabled = false;
            }
        }
    }
    
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
    
    func initCarData() {
        //dateLab.text = "\(carData?.auction_start_date)";
        auctionMobiLab.text = "暂无人出价";
        auctionCountLab.text = "出价人数：0";
        startAuctionPriceLab.isHidden = true;
        myAuctionPriceLab.text = "我的最新出价0万";
        
        if (carData?.auction_start_date)! < DateFormatterUtil.getCurrentTime(){
            dateLab.text = "\(DateFormatterUtil.formatter(pattern: "yyyy-MM-dd HH:mm:ss", time: (carData?.auction_end_date)!)) 结束";
        }
        else{
            dateLab.text = "\(DateFormatterUtil.formatter(pattern: "yyyy-MM-dd HH:mm:ss", time: (carData?.auction_start_date)!)) 开始";
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let delegate = UIApplication.shared.delegate as! AppDelegate;
        carData = delegate.trans!["carData"] as? CarDataBean;
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewControllerContainer.isHidden = false;
        checkReportViewControllerContainer.isHidden = true;
        
        //初始化数据
        initCarData();
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
