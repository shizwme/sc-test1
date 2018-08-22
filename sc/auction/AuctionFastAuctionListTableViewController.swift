//
//  AuctionFastAuctionListTableViewController.swift
//  sc
//
//  Created by Mac on 2018/8/21.
//  Copyright © 2018年 ajmc. All rights reserved.
//

import UIKit
import Alamofire

class AuctionFastAuctionListTableViewController: BaseTableViewController {
    
    var carDataArray : [CarDataBean]?;
    
    var pageBean : PageBean?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self;
        tableView.delegate = self;
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let d : NSDictionary = ["pageNow" : (pageBean != nil ? pageBean!.pageNumber! + 1 : 1)];
        initParam(params: d);
        
        getHttpJSONData(url: AppConstant.baseUrl + PathConstant.buyCarPath,
                        method: HTTPMethod.get, parameters: alamofireParameters);
    }
    
    override func parseJson(json: Any) -> Bool {
        print("解析数据");
        if let resultD  = json as? NSDictionary{
            let carList = resultD.value(forKey: "list") as! NSArray;
            let page = resultD.value(forKey: "page") as! NSDictionary;
            
            self.pageBean = PageBean.parseObject(dict: page);
            self.carDataArray = CarDataBean.parseArray(array: carList);
            
            self.tableView.reloadData();
        }
        else{
            print("数据错误,获取更新类型失败");
        }
        return true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return carDataCount;
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if carDataArray == nil{
            return 0;
        }
        return carDataArray!.count;
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fastAuctionTableViewCell", for: indexPath);

        let logo = cell.viewWithTag(10) as! UIImageView;
        let title = cell.viewWithTag(2) as! UILabel;
        let condition = cell.viewWithTag(3) as! UILabel;
        let price = cell.viewWithTag(4) as! UILabel;
        let date = cell.viewWithTag(5) as! UILabel;
        
        let item = self.carDataArray![indexPath.row];
        
        //logo.image = UIImage(named: "auction_deposit_note");
        getImageData(url: "\(AppConstant.baseUrl!)\(PathConstant.carDataImagePath!)\(item.id ?? 0)/\(item.logo ?? "")", image : logo);
        title.text = "\(item.brand_name!)\(item.model!) \(item.volumn!)\(item.gear_box!)";
        condition.text = "\(item.household_dateStr_year!)/\(item.drive_type!)/\(item.mileage!/10000)万公里";
        price.text = "\(Int(item.start_auction_price!/10000)) .x万";
        date.text = "\(item.auction_end_date!)";
        
        return cell;
    }

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
