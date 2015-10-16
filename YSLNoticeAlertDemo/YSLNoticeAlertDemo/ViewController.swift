//
//  ViewController.swift
//  YSLNoticeAlertDemo
//
//  Created by yamaguchi on 2015/07/24.
//  Copyright (c) 2015年 h.yamaguchi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func awakeFromNib() {
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button_success = UIButton(type: UIButtonType.System)
        button_success.frame = CGRectMake(20, 150, self.view.frame.size.width - (20 * 2), 44)
        button_success.setTitle("show alert success", forState: UIControlState.Normal)
        button_success.addTarget(self, action: "showAlert:", forControlEvents:UIControlEvents.TouchUpInside)
        button_success.tag = 1
        self.view.addSubview(button_success)
        
        let button_failure = UIButton(type: UIButtonType.System)
        button_failure.frame = CGRectMake(20, button_success.frame.origin.y + button_success.frame.size.height + 54, self.view.frame.size.width - (20 * 2), 44)
        button_failure.setTitle("show alert failure", forState: UIControlState.Normal)
        button_failure.addTarget(self, action: "showAlert:", forControlEvents:UIControlEvents.TouchUpInside)
        button_failure.tag = 2
        self.view.addSubview(button_failure)
        
        let button_other = UIButton(type: UIButtonType.System)
        button_other.frame = CGRectMake(20, button_failure.frame.origin.y + button_failure.frame.size.height + 54, self.view.frame.size.width - (20 * 2), 44)
        button_other.setTitle("show alert other", forState: UIControlState.Normal)
        button_other.addTarget(self, action: "showAlert:", forControlEvents:UIControlEvents.TouchUpInside)
        button_other.tag = 3
        self.view.addSubview(button_other)
        
        let button_custom = UIButton(type: UIButtonType.System)
        button_custom.frame = CGRectMake(20, button_other.frame.origin.y + button_other.frame.size.height + 54, self.view.frame.size.width - (20 * 2), 44)
        button_custom.setTitle("show alert custom", forState: UIControlState.Normal)
        button_custom.addTarget(self, action: "showAlert:", forControlEvents:UIControlEvents.TouchUpInside)
        button_custom.tag = 4
        self.view.addSubview(button_custom)
    }
    
    func showAlert(button: UIButton) {
        switch (button.tag) {
        case 1:
            YSLNoticeAlert().showAlert(title: "Login Success", subTitle: "", alertType: YSLAlertType.Success, completion: { () -> Void in
                print("AAAA")
            })
        case 2:
            YSLNoticeAlert().showAlert(title: "Login Error", subTitle: "Please try again.", alertType: YSLAlertType.Failure)
        case 3:
            YSLNoticeAlert().showAlert(title: "YSLNoticeAlert Title Demo", subTitle: "YSLNoticeAlert SubTitle Demo", alertType: YSLAlertType.Other)
        case 4:
            YSLNoticeAlert().showAlert(title: "YSLNoticeAlert Title Demo", subTitle: "YSLNoticeAlert SubTitle Demo", color: UIColor.orangeColor())
            self.hogeMethod("aaaa", age: 16, callback: { () -> Void in
                 
            })
        default:
            break
        }
    }
    
    func hogeMethod(name: String, age: Int, callback: () -> Void) -> Void {
        
        // とりあえず例として第１引数(名前)と第２引数(年齢)からメッセージ文字列を作成
        let message = "\(name)さん\(age)歳ですね"
        
        // 処理が終わったら第３引数で受け取った関数を実行。今回はメッセージを渡す
        callback()
    }
}
