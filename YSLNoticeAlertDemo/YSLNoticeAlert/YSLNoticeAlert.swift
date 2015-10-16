//
//  YSLNoticeAlert.swift
//  YSLNoticeAlertDemo
//
//  Created by yamaguchi on 2015/07/24.
//  Copyright (c) 2015年 h.yamaguchi. All rights reserved.
//

import UIKit

private let YSLNoticeAlertColorSuccess = UIColor(red: 114 / 255.0, green: 209 / 255.0, blue: 142 / 255.0, alpha: 1.0)
private let YSLNoticeAlertColorFailure = UIColor(red: 215 / 255.0, green: 104 / 255.0, blue: 91 / 255.0, alpha: 1.0)
private let YSLNoticeAlertColorOther = UIColor(red: 89 / 255.0, green: 126 / 255.0, blue: 133 / 255.0, alpha: 1.0)
private let YSLNoticeAleartHeight : CGFloat = 80
private let YSLNoticeLabelMargin : CGFloat = 10

internal enum YSLAlertType : Int {
    case Success = 0
    case Failure
    case Other
}

public class YSLNoticeAlert: UIView {
    
    static var titleFont : UIFont! = UIFont.boldSystemFontOfSize(15)
    static var subTitleFont : UIFont! = UIFont.systemFontOfSize(13)
    static var titleTextColor : UIColor! = UIColor.whiteColor()
    static var subTitleTextColor : UIColor! = UIColor.whiteColor()
    
    private var titleLabel : UILabel!
    private var subTitleLabel : UILabel!
    public var callback: (()->Void)?

    init()
    {
        super.init(frame: CGRectZero)
        self.commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.commonInit()
    }
    
    // MARK: - Public
    internal func showAlert (title title: String?, subTitle: String?, alertType: YSLAlertType) {
        self.title(title, subTitle: subTitle, alertType: alertType, color: nil)
    }
    
    internal func showAlert (title title: String?, subTitle: String?, alertType: YSLAlertType, completion: (()->Void)?) {
        self.title(title, subTitle: subTitle, alertType: alertType, color: nil)
        
        if (completion != nil) {
            self.callback = completion
        }
    }
    
    
    internal func showAlert (title title: String?, subTitle: String?, color: UIColor) {
        self.title(title, subTitle: subTitle, alertType: YSLAlertType.Other, color: color)
    }

    // MARK: - Private
    private func commonInit () {
        
        let rect = UIScreen.mainScreen().bounds
        self.userInteractionEnabled = true
        self.frame = CGRectMake(0, -YSLNoticeAleartHeight, rect.size.width, YSLNoticeAleartHeight)
        titleLabel = UILabel()
        titleLabel.frame = CGRectMake(YSLNoticeLabelMargin, 30, rect.size.width - (YSLNoticeLabelMargin * 2), 20);
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.font = YSLNoticeAlert.titleFont
        titleLabel.textColor = YSLNoticeAlert.titleTextColor
        titleLabel.text = ""
        self.addSubview(titleLabel)
        
        subTitleLabel = UILabel()
        subTitleLabel.frame = CGRectMake(YSLNoticeLabelMargin, titleLabel.frame.origin.y + titleLabel.frame.size.height, rect.size.width - (YSLNoticeLabelMargin * 2), 30)
        subTitleLabel.textAlignment = NSTextAlignment.Center
        subTitleLabel.font = YSLNoticeAlert.subTitleFont
        subTitleLabel.textColor = YSLNoticeAlert.subTitleTextColor
        subTitleLabel.numberOfLines = 0
        subTitleLabel.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        subTitleLabel.text = ""
        self.addSubview(subTitleLabel)
        
        let window = UIApplication.sharedApplication().windows.first
        window!.addSubview(self)
        
        titleLabel.backgroundColor = UIColor.clearColor()
        subTitleLabel.backgroundColor = UIColor.clearColor()
        self.backgroundColor = YSLNoticeAlertColorOther
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "dissmissAlertHandler")
        self.addGestureRecognizer(tapGesture)
    }
    
    private func title (title: String?, subTitle: String?, alertType: YSLAlertType, color: UIColor?) {
        titleLabel.text = title
        subTitleLabel.text = subTitle
        
        switch alertType {
        case .Success:
            self.backgroundColor = YSLNoticeAlertColorSuccess
        case .Failure:
            self.backgroundColor = YSLNoticeAlertColorFailure
        case .Other:
            self.backgroundColor = YSLNoticeAlertColorOther
        }
        
        if color != nil {
            self.backgroundColor = color
        }
      
        if title == nil || title!.isEmpty {
            subTitleLabel.frame.origin.y = (self.frame.size.height / 2)
        }
        
        if subTitle ==  nil || subTitle!.isEmpty {
            titleLabel.frame.origin.y = (self.frame.size.height / 2)
        }
        
        let rect = UIScreen.mainScreen().bounds
        // Show Animation
        UIView.animateWithDuration(0.25,delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut,
            animations: { () -> Void in
            self.frame = CGRectMake(0, 0, rect.size.width, YSLNoticeAleartHeight)
            }) {(finished) -> Void in
        }

        // Dismiss Animation
        NSTimer.scheduledTimerWithTimeInterval(2.0,
            target: self,
            selector: Selector("dissmissAlert"),
            userInfo: nil,
            repeats: false)
    }
    
    @objc private func dissmissAlertHandler () {
        if ((self.callback) != nil) {
            self.callback!()
        }
        self.dissmissAlert()
    }
    
    @objc private func dissmissAlert () {
                
        if titleLabel != nil {
            let rect = UIScreen.mainScreen().bounds
            UIView.animateWithDuration(0.25,delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut,
                animations: { () -> Void in
                    self.frame = CGRectMake(0, -YSLNoticeAleartHeight, rect.size.width, YSLNoticeAleartHeight)
                }) { (finished) -> Void in
                    self.titleLabel = nil
                    self.subTitleLabel = nil;
                    self.removeFromSuperview()
            }
        }
    }
}

