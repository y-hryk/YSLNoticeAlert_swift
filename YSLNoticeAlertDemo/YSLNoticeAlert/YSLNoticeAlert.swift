//
//  YSLNoticeAlert.swift
//  YSLNoticeAlertDemo
//
//  Created by yamaguchi on 2015/07/24.
//  Copyright (c) 2015年 h.yamaguchi. All rights reserved.
//

import UIKit

let YSLALERT_SUCCESS_COLOR = UIColor.whiteColor()
let YSLALERT_FAILURE_COLOR = UIColor.whiteColor()
let YSLALERT_NOTICE_COLOR = UIColor(red: 0.34902, green: 0.498039, blue: 0.521569, alpha: 1.0)


enum YSLAlertType : Int {
    case Success = 0
    case Failure
    case Notice
}

let kAleartHeight : CGFloat = 80
let kLabelMargin : CGFloat = 10

public class YSLNoticeAlert: UIView {
    
    var titleLabel : UILabel!
    var subTitleLabel : UILabel!

    init()
    {
        super.init(frame: CGRectZero)
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        let rect = UIScreen.mainScreen().bounds
        // title
        titleLabel = UILabel()
        titleLabel.frame = CGRectMake(kLabelMargin, 30, rect.size.width - (kLabelMargin * 2), 20);
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.font = UIFont.boldSystemFontOfSize(15)
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.text = "Hello World"
        self.addSubview(titleLabel)
        
        // detail
        subTitleLabel = UILabel()
        subTitleLabel.frame = CGRectMake(kLabelMargin, titleLabel.frame.origin.y + titleLabel.frame.size.height, rect.size.width - (kLabelMargin * 2), 30)
        subTitleLabel.textAlignment = NSTextAlignment.Center
        subTitleLabel.font = UIFont.systemFontOfSize(13)
        subTitleLabel.numberOfLines = 2
        subTitleLabel.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        subTitleLabel.textColor = UIColor.whiteColor()
        subTitleLabel.text = "YSLNoticeAlert Demo."
        self.addSubview(subTitleLabel)
        
        let window = UIApplication.sharedApplication().windows.first as! UIWindow
        window.addSubview(self)
        
        titleLabel.backgroundColor = UIColor.clearColor()
        subTitleLabel.backgroundColor = UIColor.clearColor()
        self.backgroundColor = YSLALERT_NOTICE_COLOR
    }
    
    required public init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Public
    class func showAlert(#title: String, subTitle: String, alertType: YSLAlertType) {
        self.alertView().title(title, subTitle: subTitle, alertType: alertType, color: nil)
    }
    
    class func showAlert(#title: String, subTitle: String, color: UIColor) {
        self.alertView().title(title, subTitle: subTitle, alertType: YSLAlertType.Notice, color: color)
    }

    // MARK: - Private
    private static func alertView () -> YSLNoticeAlert {
        let rect = UIScreen.mainScreen().bounds
        return YSLNoticeAlert(frame: CGRectMake(0, -kAleartHeight, rect.size.width, kAleartHeight))
    }
    
    private func title (title: String, subTitle: String, alertType: YSLAlertType, color: UIColor?) {
        titleLabel.text = title
        subTitleLabel.text = subTitle
        
        switch alertType {
        case .Success:
            self.backgroundColor = UIColor.greenColor()
        case .Failure:
            self.backgroundColor = UIColor.redColor()
        case .Notice:
            self.backgroundColor = YSLALERT_NOTICE_COLOR
        }
        
        if (color != nil) {
            self.backgroundColor = color
        }
        
        let rect = UIScreen.mainScreen().bounds
        // Show Animation
        UIView.animateWithDuration(0.25,delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut,
            animations: {[unowned self] () -> Void in
        
            self.frame = CGRectMake(0, 0, rect.size.width, kAleartHeight)
                
            }) {(finished) -> Void in
        }
        
        // Dismiss Animation
        var dispatchTime : dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(2.0 * Double(NSEC_PER_SEC)))
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            // your function here
            [unowned self] in
            self.dissmissAlert()
        })
    }
    
    private func dissmissAlert () {
        let rect = UIScreen.mainScreen().bounds
        UIView.animateWithDuration(0.25,delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut,
            animations: {[unowned self] () -> Void in
            self.frame = CGRectMake(0, -kAleartHeight, rect.size.width, kAleartHeight)
            }) { [unowned self](finished) -> Void in
                self.removeFromSuperview()
        }
    }
    
    
}
