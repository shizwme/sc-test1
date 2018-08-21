//
//  BaseViewController.swift
//  sc
//
//  Created by Mac on 2018/8/20.
//  Copyright © 2018年 ajmc. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var activityIndicator:UIActivityIndicatorView!;
    
    lazy var documentsPath: String = {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return paths.first!
    }()
    
    func getToken() -> String {
        return (DeviceUtil.getInstance().getIDFV() + "\(PListUtil.getInstance().getDictionaryValueInt(filePath: documentsPath + "/" + AppConstant.userFileNamePList, key: "id"))").md5();
    }
    
    func getUserId() -> Int {
        return PListUtil.getInstance().getDictionaryValueInt(filePath: self.documentsPath + "/" + AppConstant.userFileNamePList, key: "id")
    }
    
    func creatActivityIndicator(){
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle:UIActivityIndicatorViewStyle.gray)
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
    }
    
    func playActivityIndicator(){
        //进度条开始转动
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        //进度条停止转动
        activityIndicator.stopAnimating()
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
