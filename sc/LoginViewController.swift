//
//  LoginViewController.swift
//  sc
//
//  Created by Mac on 2018/8/14.
//  Copyright © 2018年 ajmc. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: BaseViewController {

    @IBOutlet var mobileTextField: UITextField!;
    
    @IBOutlet var passwordTextField: UITextField!;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func mobileTextFieldComplete(_ sender: UITextField) {
        //sender.resignFirstResponder();
        passwordTextField.becomeFirstResponder();
    }
    
    @IBAction func passwordTextFieldComplete(_ sender: UITextField) {
        sender.resignFirstResponder();
        //登陆操作
        loginAction();
    }
    
    @IBAction func containerTouchDown(_ sender: UIControl) {
        if mobileTextField.isFirstResponder{
            mobileTextField.resignFirstResponder();
        }
        else if passwordTextField.isFirstResponder{
            passwordTextField.resignFirstResponder();
        }
    }
    
    @IBAction func loginButtonClick(_ sender: UIButton) {
        loginAction();
    }
    
    private func loginAction(){
        print("加密密码\(passwordTextField.text!.md5())");
        if checkData(){
            //网络操作
            print("网络操作");
            creatActivityIndicator();
            playActivityIndicator();
            
            let parameters: Parameters = [
                "token": getToken(),
                "uid": getUserId(),
                "t": 3,
                "mobile": mobileTextField.text!,
                "password": passwordTextField.text!.md5()
//                "t": [1,2,3],
//                "bar": [
//                    "baz": "qux"
//                ]
            ]

            Alamofire.request(AppConstant.baseUrl + "user/flogin", method: .get, parameters: parameters).responseJSON{
                response in
                print("Request: \(String(describing: response.request))")   // original url request
                print("Response: \(String(describing: response.response))") // http url response
                print("Result: \(response.result)")                         // response serialization result
                
                self.stopActivityIndicator();
                
                if let json = response.result.value {
                    print("JSON: \(json)") // serialized json response
                    if let result  = json as? NSDictionary{
                        let flag = result.value(forKey: "flag") as? Int;
                        let msg = result.value(forKey: "msg") as? String;
                        if flag! > 0{
                            if let user = result.value(forKey: "user") as? NSDictionary{
                                if PListUtil.getInstance().setDictionary(filePath: self.documentsPath + "/" + AppConstant.userFileNamePList, dictionary: user){}
                            }
                            else{
                                if PListUtil.getInstance().setDictionary(filePath: self.documentsPath + "/" + AppConstant.userFileNamePList, dictionary: NSDictionary()){}
                            }
                            
                            if let merchant = result.value(forKey: "merchant") as? NSDictionary{
                                if PListUtil.getInstance().setDictionary(filePath: self.documentsPath + "/" + AppConstant.merchantFileNamePList, dictionary: merchant){}
                            }
                            else{
                                if PListUtil.getInstance().setDictionary(filePath: self.documentsPath + "/" + AppConstant.merchantFileNamePList, dictionary: NSDictionary()){}
                            }
                            
                            self.navigationController?.popViewController(animated: true);
                        }
                        else{
                            let alertController = UIAlertController(title: "提示", message: msg, preferredStyle:UIAlertControllerStyle.alert);
                            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil));
                            self.present(alertController, animated: true, completion: nil);
                        }
                    }
                }
                
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    print("Data: \(utf8Text)") // original server data as UTF8 string
                }
            };
        }
    }
    
    private func checkData() -> Bool{
        let mobile : String = mobileTextField.text!;
        let regexHelper = try? RegexHelper(pattern: "^1[3-9][0-9]{9}$");
        if mobile.count != 11 || !(regexHelper?.match(mobile))!{
            let alertController = UIAlertController(title: "提示", message: "电话号码格式错误", preferredStyle:UIAlertControllerStyle.alert);
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler:nil));
            self.present(alertController, animated: true, completion: nil);
            
            return false;
        }
        
        let password : String = passwordTextField.text!;
        if password.count > 16 || password.count < 6{
            let alertController = UIAlertController(title: "提示", message: "密码格式错误", preferredStyle:UIAlertControllerStyle.alert);
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler:nil));
            self.present(alertController, animated: true, completion: nil);
            
            return false;
        }
        
        return true;
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
