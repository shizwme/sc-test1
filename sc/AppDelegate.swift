//
//  AppDelegate.swift
//  sc
//
//  Created by Mac on 2018/8/14.
//  Copyright © 2018年 ajmc. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    lazy var documentsPath: String = {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return paths.first!
    }();
    
    var parameters: Parameters!;
    
    var oldUpdateTypePList : NSArray!;
    
    private func initParam(){
        parameters = [
            "token": (DeviceUtil.getInstance().getIDFV() + "\(PListUtil.getInstance().getDictionaryValueInt(filePath: documentsPath + "/" + AppConstant.userFileNamePList, key: "id"))").md5(),
            "uid": PListUtil.getInstance().getDictionaryValueInt(filePath: documentsPath + "/" + AppConstant.userFileNamePList, key: "id"),
            "t": 3
        ];
    }
    
    private func getOldUpdateTypePList(){
        oldUpdateTypePList = PListUtil.getInstance().getArray(filePath: documentsPath + "/" + AppConstant.updateTypeFileNamePList);
    }
    
    private func getUpdateType(){
        initParam();
        getOldUpdateTypePList();
        
        //网络操作
        print("网络操作，获取更新类型");
        Alamofire.request(AppConstant.baseUrl + "updateType/fget", method: .get, parameters: parameters).responseJSON{
            response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
                if let resultD  = json as? NSDictionary{
                    let result = resultD.value(forKey: "updateType") as! NSArray;
                    //首次执行，没有历史数据
                    if self.oldUpdateTypePList == nil{
                        print("首次执行，没有历史数据");
                        for item in result{
                            self.getUpdateTypeItem(updateTypeItem : item as! NSDictionary);
                        }
                    }
                    //有历史数据
                    else{
                        print("非首次执行，有历史数据");
                        for oi in self.oldUpdateTypePList{
                            let oid = oi as! NSDictionary;
                            print(oid);
                            for ni in result{
                                let nid = ni as! NSDictionary;
                                print(nid);
                                if (oid.value(forKey: "utype") as! Int) == (nid.value(forKey: "utype") as! Int){
                                    if (oid.value(forKey: "ver") as! Int) < (nid.value(forKey: "ver") as! Int){
                                        self.getUpdateTypeItem(updateTypeItem : nid);
                                    }
                                }
                            }
                        }
                    }
                    
                    //更新本地数据
                    print("更新本地数据，更新更新类型");
                    if PListUtil.getInstance().setArray(filePath: self.documentsPath + "/" + AppConstant.updateTypeFileNamePList, dictionary: result){};
                }
                else{
                    print("数据错误,获取更新类型失败");
                }
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        };
        
    }
    
    func getUpdateTypeItem(updateTypeItem : NSDictionary) {
        let utype : Int = updateTypeItem.value(forKey: "utype") as! Int;
        var url : String = AppConstant.baseUrl;
        switch utype {
            case 1:
                url += "brand/fget";
            case 2:
                url += "carConfigure/fget";
            case 3:
                url += "carAppearance/fget";
            default :
                print("未知的更新类型,不能获取更新项");
                return;
        }
        
        print("网络操作，获取更新项：\(utype)-\(updateTypeItem.value(forKey: "name") as! String)");
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON{
            response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
                if let resultD  = json as? NSDictionary{
                    //更新本地数据
                    print("更新本地数据，更新更新项：\(utype)-\(updateTypeItem.value(forKey: "name") as! String)");
                    switch utype {
                    case 1:
                        let result = resultD.value(forKey: "brand") as! NSArray;
                        if PListUtil.getInstance().setArray(filePath: self.documentsPath + "/" + AppConstant.brandFileNamePList, dictionary: result){};
                    case 2:
                        let result = resultD.value(forKey: "carConfigure") as! NSArray;
                        if PListUtil.getInstance().setArray(filePath: self.documentsPath + "/" + AppConstant.carConfigureFileNamePList, dictionary: result){};
                    case 3:
                        let result = resultD.value(forKey: "carAppearance") as! NSArray;
                        if PListUtil.getInstance().setArray(filePath: self.documentsPath + "/" + AppConstant.carAppearanceFileNamePList, dictionary: result){};
                    default :
                        print("未知的更新类型,不能更新更新项");
                    }
                }
                else{
                    print("数据错误,获取更新项失败");
                }
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        };
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        Thread.sleep(forTimeInterval: 3.0);
        
        print("沙盒路径：\(documentsPath)");

        getUpdateType();
        
        return true
    }
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        print("applicationDidFinishLaunching");
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "sc")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

