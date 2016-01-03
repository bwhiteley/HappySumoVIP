//
//  ViewController.swift
//  HappySumoVIP
//
//  Created by J. B. Whiteley on 6/20/15.
//  Copyright (c) 2015 Whiteley. All rights reserved.
//

import UIKit
import WebKit
import SafariServices

class ViewController: UIViewController {
    
    var loaded:Bool = false
    
    var url:NSURL {
        let date = NSDate()
        let cal = NSCalendar.currentCalendar()
        let month:Int = cal.component(NSCalendarUnit.Month, fromDate: date)
        let year:Int = cal.component(.Year, fromDate: date) % 100
        return urlForYear(year, month: month)
    }
    
    private func urlForYear(year:Int, month:Int) -> NSURL {
        var smonth = "\(month)"
        if smonth.characters.count == 1 {
            smonth = "0" + smonth
        }
        let surl = "http://www.happysumosushi.com/vip/\(smonth)\(year)provip.php"
        return NSURL(string: surl)!
    }
    
    func actionTapped() {
        UIApplication.sharedApplication().openURL(url)
    }
    
    func nextMonthURL() -> NSURL {
        let date = NSDate()
        let cal = NSCalendar.currentCalendar()
        var month:Int = cal.component(NSCalendarUnit.Month, fromDate: date)
        var year:Int = cal.component(.Year, fromDate: date) % 100
        month++
        if month >= 13 {
            month = 1
            year++
        }
        let url = urlForYear(year, month: month)
        return url
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if !loaded {
            self.loaded = true
            self.currentMonthTapped()
        }
    }
    
    
    @IBAction func currentMonthTapped() {
        let safari = SFSafariViewController(URL: self.url)
        self.presentViewController(safari, animated: true, completion: nil)
    }
    
    
    @IBAction func nextMonthTapped() {
        let safari = SFSafariViewController(URL: self.nextMonthURL())
        self.presentViewController(safari, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Happy Sumo"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

