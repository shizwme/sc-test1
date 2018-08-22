//
//  BaseTableViewController.swift
//  sc
//
//  Created by Mac on 2018/8/21.
//  Copyright © 2018年 ajmc. All rights reserved.
//

import UIKit
import Alamofire

class BaseTableViewController: UITableViewController {

    var activityIndicator:UIActivityIndicatorView!;
    
    var alamofireParameters: Parameters!;
    
    lazy var documentsPath: String = {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return paths.first!
    }()
    
    //初始化访问参数
    func initParam(params : NSDictionary){
        alamofireParameters = [
            "token": (DeviceUtil.getInstance().getIDFV() + "\(PListUtil.getInstance().getDictionaryValueInt(filePath: documentsPath + "/" + AppConstant.userFileNamePList, key: "id"))").md5(),
            "uid": PListUtil.getInstance().getDictionaryValueInt(filePath: documentsPath + "/" + AppConstant.userFileNamePList, key: "id"),
            "t": 3
        ];
        
        for i in params{
            alamofireParameters.updateValue(i.value, forKey: i.key as! String);
        }
        print("Alamofire访问参数：\(alamofireParameters)");
    }
    
    //访问json数据
    func getHttpJSONData(url : String, method : HTTPMethod, parameters : Parameters){
        //网络操作
        print("网络操作");
        Alamofire.request(url, method: method, parameters: parameters).responseJSON{
            response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
                //解析数据
                if self.parseJson(json: json){}
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        };
    }
    
    func getImageData(url : String, image : UIImageView) {
        print("获取图片：\(url)");
        Alamofire.request(url).responseData {
            response in
            if let d = response.result.value{
                image.image = UIImage(data: d);
            }
        };
    }
    
    func parseJson(json : Any) -> Bool {
        return false;
    }
    
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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
