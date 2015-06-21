//
//  ViewController.swift
//  HappySumoVIP
//
//  Created by J. B. Whiteley on 6/20/15.
//  Copyright (c) 2015 Whiteley. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    var webView:WKWebView!
    
    @IBOutlet weak var backButton: UIButton!
    var url:NSURL {
        let date = NSDate()
        let cal = NSCalendar.currentCalendar()
        var comps:NSURLComponents
        let month:Int = cal.component(NSCalendarUnit.CalendarUnitMonth, fromDate: date)
        let year:Int = cal.component(.CalendarUnitYear, fromDate: date) % 100
        return urlForYear(year, month: month)
    }
    
    private func urlForYear(year:Int, month:Int) -> NSURL {
        let surl = "http://www.happysumosushi.com/vip/\(month)\(year)provip.php"
        return NSURL(string: surl)!
    }
    
    @IBAction func backTapped(sender: AnyObject) {
        self.webView.goBack()
    }
    
    func actionTapped() {
        UIApplication.sharedApplication().openURL(url)
    }
    
    func nextMonth() {
        let date = NSDate()
        let cal = NSCalendar.currentCalendar()
        var comps:NSURLComponents
        var month:Int = cal.component(NSCalendarUnit.CalendarUnitMonth, fromDate: date)
        var year:Int = cal.component(.CalendarUnitYear, fromDate: date) % 100
        month++
        if month >= 13 {
            month = 1
            year++
        }
        let url = urlForYear(year, month: month)
        self.webView.loadRequest(NSURLRequest(URL: url))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Happy Sumo"
        
        self.backButton.layer.cornerRadius = 5
        self.backButton.layer.masksToBounds = true
        self.backButton.backgroundColor = UIColor.whiteColor()
        
        var bbi = UIBarButtonItem(title: "Next Month", style: .Plain, target: self, action: "nextMonth")
        self.navigationItem.rightBarButtonItem = bbi
        
        bbi = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: "actionTapped")
        self.navigationItem.leftBarButtonItem = bbi
        
        let frame = self.view.bounds
        webView = WKWebView(frame: frame)
        webView.autoresizingMask = .FlexibleHeight | .FlexibleWidth
        self.view.addSubview(webView)
        self.view.bringSubviewToFront(self.backButton)
        let request = NSURLRequest(URL: url)
        webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

