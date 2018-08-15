//
//  RegisterViewController.swift
//  sc
//
//  Created by Mac on 2018/8/14.
//  Copyright © 2018年 ajmc. All rights reserved.
//

import UIKit
import Alamofire
//import MobileCoreServices

class RegisterViewController: UIViewController {

    @IBOutlet var mobileTextField: UITextField!;
    @IBOutlet var passwordTextField: UITextField!;
    @IBOutlet var repasswordTextField: UITextField!;
    @IBOutlet var mcodeTextField: UITextField!
    @IBOutlet var mcodeButton: UIButton!
    
    var activityIndicator:UIActivityIndicatorView!;
    var timer: Timer!;
    var count: Int = 120;
    
    @IBAction func mobileTextFieldComplete(_ sender: UITextField) {
        //sender.resignFirstResponder();
        if checkData(flag: 1){
            passwordTextField.becomeFirstResponder();
        }
    }
    
    @IBAction func passwordTextFieldComplete(_ sender: UITextField) {
        //sender.resignFirstResponder();
        if checkData(flag: 2){
            repasswordTextField.becomeFirstResponder();
        }
    }
    
    @IBAction func repasswordTextFieldComplete(_ sender: UITextField) {
        //sender.resignFirstResponder();
        if checkData(flag: 3){
            mcodeTextField.becomeFirstResponder();
        }
    }
    
    @IBAction func mcodeTextFieldComplete(_ sender: UITextField) {
        if checkData(flag: 4){
            sender.resignFirstResponder();
            //注册操作
            registerAction();
        }
    }
    
    @IBAction func containerTouchDown(_ sender: UIControl) {
        hideSoftInput();
    }
    
    private func hideSoftInput(){
        if mobileTextField.isFirstResponder{
            mobileTextField.resignFirstResponder();
        }
        else if passwordTextField.isFirstResponder{
            passwordTextField.resignFirstResponder();
        }
        else if repasswordTextField.isFirstResponder{
            repasswordTextField.resignFirstResponder();
        }
        else if mcodeTextField.isFirstResponder{
            mcodeTextField.resignFirstResponder();
        }
    }
    
    @IBAction func registerButtonClick(_ sender: UIButton) {
        hideSoftInput();
        registerAction();
    }
    
    @IBAction func getMCodeButtonClick(_ sender: UIButton) {
        hideSoftInput();
        getMCode();
    }
    
    private func getMCode(){
        print("按钮状态\(mcodeButton.isEnabled)");
        if mcodeButton.isEnabled == false{
            return;
        }
        let mobile : String = mobileTextField.text!;
        let regexHelper = try? RegexHelper(pattern: "^1[3-9][0-9]{9}$");
        if mobile.count != 11 || !(regexHelper?.match(mobile))!{
            let alertController = UIAlertController(title: "提示", message: "电话号码格式错误", preferredStyle:UIAlertControllerStyle.alert);
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler:nil));
            self.present(alertController, animated: true, completion: nil);
            
            return;
        }
        SMSSDK.getVerificationCode(by: SMSGetCodeMethod.SMS, phoneNumber: mobileTextField.text, zone: "86", template: nil, result: {
            error in
            if (error == nil){
                // 请求成功
                let alertController = UIAlertController(title: "提示", message: "验证码发送成功，请注意查收", preferredStyle:UIAlertControllerStyle.alert);
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler:nil));
                self.present(alertController, animated: true, completion: nil);
            }
            else{
                // error
                let alertController = UIAlertController(title: "提示", message: "验证码发送失败", preferredStyle:UIAlertControllerStyle.alert);
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler:nil));
                self.present(alertController, animated: true, completion: nil);
            }
        });
        
        createTimer();
    }
    
    private func checkData(flag: Int) -> Bool{
        if flag == 0 || flag == 1{
            let mobile : String = mobileTextField.text!;
            let regexHelper = try? RegexHelper(pattern: "^1[3-9][0-9]{9}$");
            if mobile.count != 11 || !(regexHelper?.match(mobile))!{
                let alertController = UIAlertController(title: "提示", message: "电话号码格式错误", preferredStyle:UIAlertControllerStyle.alert);
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler:nil));
                self.present(alertController, animated: true, completion: nil);
                
                return false;
            }
        }
        
        if flag == 0 || flag == 2{
            let password : String = passwordTextField.text!;
            if password.count > 16 || password.count < 6{
                let alertController = UIAlertController(title: "提示", message: "密码格式错误", preferredStyle:UIAlertControllerStyle.alert);
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler:nil));
                self.present(alertController, animated: true, completion: nil);
                
                return false;
            }
        }
        
        if flag == 0 || flag == 3{
            let password : String = passwordTextField.text!;
            let repassword : String = repasswordTextField.text!;
            if password != repassword{
                let alertController = UIAlertController(title: "提示", message: "两次输入密码不一致", preferredStyle:UIAlertControllerStyle.alert);
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler:nil));
                self.present(alertController, animated: true, completion: nil);
                
                return false;
            }
        }
        
        if flag == 0 || flag == 4{
            let mcode : String = mcodeTextField.text!;
            if mcode.count != 6{
                let alertController = UIAlertController(title: "提示", message: "验证码格式错误", preferredStyle:UIAlertControllerStyle.alert);
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler:nil));
                self.present(alertController, animated: true, completion: nil);
                
                return false;
            }
        }
        
        return true;
    }
    
    private func registerAction(){
        if checkData(flag: 0){
            //网络操作
            print("网络操作");
            creatActivityIndicator();
            playActivityIndicator();
            
            let parameters: Parameters = [
                "token": "123",
                "uid": 0,
                "t": 3,
                "mobile": mobileTextField.text!,
                "password": passwordTextField.text!.md5(),
                "mcode": mcodeTextField.text!
            ]
            
            Alamofire.request(AppConstant.baseUrl + "user/fregisterPersonal", method: .get, parameters: parameters).responseJSON{
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
                        
                        let alertController = UIAlertController(title: "提示", message: msg, preferredStyle:UIAlertControllerStyle.alert);
                        if flag! > 0{
                            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                                action in
                                self.navigationController?.popViewController(animated: true);
                            }));
                        }
                        else{
                            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil));
                        }
                        self.present(alertController, animated: true, completion: nil);
                    }
                }
                
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    print("Data: \(utf8Text)") // original server data as UTF8 string
                }
            };
        }
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
    
    func createTimer(){
        if timer != nil{
            return;
        }
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {
            ti in
            self.countdown();
        });
        mcodeButton.isEnabled = false;
        timer.fire();
    }
    
    // 计数方法
    func countdown(){
        self.count -= 1;
        if self.count <= 0{
            self.timer.invalidate();
            self.timer = nil;
            self.mcodeButton.setTitle("点击获取验证码", for: UIControlState.normal);
            self.mcodeButton.isEnabled = true;
            self.count = 120;
        }
        else{
            self.mcodeButton.titleLabel?.text = "\(count) s";
            self.mcodeButton.setTitle("\(count) s", for: UIControlState.disabled);
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if timer != nil{
            timer.invalidate();
            timer = nil;
        }
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
