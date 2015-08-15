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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        button.frame = CGRectMake(20, 300, self.view.frame.size.width - (20 * 2), 44)
        button.setTitle("show alert", forState: UIControlState.Normal)
        button.addTarget(self, action: "showAlert", forControlEvents:UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
    }

    override func viewDidAppear(animated: Bool) {
        
    }
    
    func showAlert () {
      //  YSLNoticeAlert.showAlert(title: "Hellow", subTitle: "subText", alertType: YSLAlertType.Failure)
        YSLNoticeAlert.showAlert(title: "Hellow word", subTitle: "sub", color: UIColor.greenColor())
    }
}
